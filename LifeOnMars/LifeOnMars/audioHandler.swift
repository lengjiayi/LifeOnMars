//
//  audioHandler.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 nju. All rights reserved.
//

import Foundation

class audioHandler{
    //MARK: Properties
    let FILESIZE_START = 4
    let NUMCHANNELS_START = 22
    let SAMPLERATE_START = 24
    let BYTERATE_START = 28
    let DATA_SIZE_START = 40
    let DATA_START = 44
    let outputPath = "/merge.wav"
    
    //MARK: Public Methods
    func mergeWav(_ filenames: [String]) -> (Double,Data?){
        if(filenames.count == 0 ){
            return (0.0, nil)
        }
        var datas: [Data] = []
        for file in filenames{
            let tmpdata: Data = loadWav(file)
            //            checkData(tmpdata)
            datas.append(tmpdata)
        }
        var datasize = 0
        var outputAudio = getHead(datas[0])
        for data in datas{
            let tmpdata = getAudioData(data)
            outputAudio.append(tmpdata)
            datasize += tmpdata.count
        }
        //set filesize
        var tmpbytes:[UInt8] = intToLittleEndian(outputAudio.count-8)
        for i in 0...3{
            outputAudio[FILESIZE_START+i] = tmpbytes[i]
        }
        //set datasize
        tmpbytes = intToLittleEndian(datasize)
        for i in 0...3{
            outputAudio[DATA_SIZE_START+i] = tmpbytes[i]
        }
        let duration = checkData(outputAudio)
        return (duration, outputAudio)
    }
    
    //MARK: Private Methods
    private func loadWav(_ filename: String) -> Data {
        if let path = Bundle.main.path(forResource: "wavs", ofType: nil){
//            print(path)
            let readHandler = try! FileHandle(forReadingAtPath: path+"/"+filename)
            let data = readHandler?.readDataToEndOfFile()
            return data!
        }
        else{
            fatalError("folder not found")
        }
    }
    
    private func saveWav(_ data: Data){
        if let path = Bundle.main.path(forResource: "wavs", ofType: nil){
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: path+outputPath){
                fileManager.createFile(atPath: path+outputPath, contents: data, attributes: nil)
            }
            else{
                let writeHandler = try! FileHandle(forWritingAtPath: path+outputPath)
                writeHandler?.write(data)
            }
        }
        else{
            fatalError("folder not found")
        }
    }
    
    private func littleEndianToInt(_ data:Data) -> Int{
        var ret : Int = 0
        for i in 0..<data.count{
            ret *= 256
            ret += Int(data[data.count-i-1])
        }
        return ret
    }
    
    private func intToLittleEndian(_ value: Int) -> [UInt8]{
        var tmp = value
        var ret : [UInt8] = []
        for i in 0...3{
            ret.append(UInt8(tmp%256))
            tmp /= 256
        }
        return ret
    }
    
    private func checkData(_ data: Data) -> Double{
        let filesize = littleEndianToInt(data.subdata(in: Range(FILESIZE_START...FILESIZE_START+3))) + 8
        let numchannels = littleEndianToInt(data.subdata(in: Range(NUMCHANNELS_START...NUMCHANNELS_START+1)))
        let samplerate = littleEndianToInt(data.subdata(in: Range(SAMPLERATE_START...SAMPLERATE_START+3)))
        let byterate = littleEndianToInt(data.subdata(in: Range(BYTERATE_START...BYTERATE_START+3)))
        let tmp = littleEndianToInt(data.subdata(in: Range(BYTERATE_START+4...BYTERATE_START+7)))
        let datasize = littleEndianToInt(data.subdata(in: Range(DATA_SIZE_START...DATA_SIZE_START+3)))
        print("""
            文件大小：\(filesize)    字节
            声道数：\(numchannels)
            采样率：\(samplerate)
            每秒字节数：\(byterate)
            每次采样字节数：\(tmp%256)
            采样位数：\(tmp/256/256)
            数据大小：\(datasize)    字节
            
            """)
        return Double(datasize)/Double(byterate)
    }
    
    private func getAudioData(_ data: Data) -> Data{
        let datasize = littleEndianToInt(data.subdata(in: Range(DATA_SIZE_START...DATA_SIZE_START+3)))
        return data.subdata(in: Range(DATA_START...DATA_START+datasize-1))
    }
    
    private func getHead(_ data: Data) -> Data{
        return data.subdata(in: Range(0...DATA_START-1))
    }
    
}
