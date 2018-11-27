//
//  MarsTranslator.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 nju. All rights reserved.
//

import Foundation
class MarsTranslator{

    
    //MARK: Accent dictionary
    let AccentList:[[Int:Int]]=[
        [
            29:12,    12:29,    1:11,    11:1,
            21:14,    14:21,    23:27,    27:23,
            ],
        [
            6:15,    15:6,    2:31,    31:2,
            27:30,    30:27,    24:22,    22:24,
            ],
        [
            20:13,    13:20,    26:25,    25:26,
            12:4,    4:12,    11:8,    8:11,
            ],
        [
            1:16,    16:1,    11:28,    28:11,
            12:8,    8:12,    29:4,    4:29,
            ],
        [
            24:23,    23:24,    21:17,    17:21,
            26:7,    7:26,    18:10,    10:18,
            ],
        [
            7:3,    3:7,    23:8,    8:23,
            1:13,    13:1,    6:26,    26:6,
            ]
    ]
    let provinceList = [
        "Solis Lacus":0,
        "Arabia Terra":1,
        "Olympus Mons":2,
        "Valles Marineris":3,
        "Cydonia":4,
        "Planum Austrlate":5,
        ]
    
    //MARK: public Methods
    
    //convert unicode string to hex array
    func stringToHex(msg string: String, province provinceName: String) -> [Int]{
        var hexArray:[Int] = []
        for element in string.unicodeScalars{
            let myInt = element.value
            hexArray += intToHex(Int(myInt))
        }
        return addAccent(msg: hexArray, province: provinceName)
    }
    
    //convert hex array to unicode string
    func hexToChar(msg hexArray: [Int], province provinceName: String) -> String{
        var value = 0
        var string = ""
        let realArray = addAccent(msg: hexArray, province: provinceName)
        for x in realArray{
            if x < 0{
                string.append(Character(UnicodeScalar(value)!))
                value = 0
            }
            else{
                value *= 16
                value += x%16
            }
        }
        return string
    }
    
    //convert hex array to filelist
    func hexToFile(msg hexArray: [Int], gender male:Bool) -> [String]{
        var files:[String] = []
        if !male{
            for x in hexArray{
                if(x>0){
                    files.append("\(x)_female.wav")
                }
            }
            files.append("end_female.wav")
        }
        else{
            for x in hexArray{
                if(x>0){
                    files.append("\(x)_male.wav")
                }
            }
            files.append("end_male.wav")
        }
        return files
    }
    
    //MARK: private Methods
    private func intToHex(_ value: Int) -> [Int]{
        var hex = [Int]()
        var tmp = value
        var even = 1
        while tmp > 0 {
            hex.insert(tmp%16 + 16 * even, at: 0)
            tmp /= 16
            even = 1 - even
        }
        hex.append(-1)
        return hex
    }
    
    private func addAccent(msg hexArray: [Int], province provicneName:String) -> [Int]{
        if let index = provinceList[provicneName]{
            var ret = hexArray
            for i in 0..<ret.count{
                if let val = AccentList[index][ret[i]]{
                    ret[i] = val
                }
            }
            return ret
        }
        else{
            fatalError("Province Not Found")
        }
    }
}

/*
 let t = MarsTranslator()
 let result = t.stringToHex(msg: "大家好", province: "Planum Austrlate")
 
 for x in result{
 print(x)
 }
 
 //print(t.hexToChar(msg: result, province: "Cydonia"))
 print(t.hexToChar(msg: result, province: "Planum Austrlate"))
 */
