//
//  btCommon.swift
//  LifeOnMars
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018 nju. All rights reserved.
//

import UIKit
import CoreBluetooth

class btCommon: UIView , CBPeripheralManagerDelegate{
    
    var peripheralManager:CBPeripheralManager? = nil
    private let Service_UUID: String = "CDD1"
    private let Characteristic_UUID: String = "CDD2"
    private var characteristic: CBMutableCharacteristic?
    private var info:String?
    var father:mainViewController? = nil
    
    
    init(frame: CGRect ,info:String) {
        super.init(frame: frame)
        self.info = info
        peripheralManager = CBPeripheralManager(delegate: self, queue: .main, options: nil)
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        peripheralManager = CBPeripheralManager(delegate: self, queue: .main, options: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: CBPeripheralManager Delegate
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if (error != nil) {
            print(error)
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("Advertising...")
        if error != nil {
            print(error)
        }
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if(peripheral.state == .poweredOn){
            print("update")
            initperipheral()
            peripheral.startAdvertising([CBAdvertisementDataLocalNameKey : "LOM" + info!,
                                         CBAdvertisementDataServiceUUIDsKey : [CBUUID.init(string: Service_UUID)]])
        }
    }
    
    /** 中心设备读取数据的时候回调 */
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        // 请求中的数据，这里把文本框中的数据发给中心设备
        request.value = ("LOM" + info!).data(using: .utf8)
        // 成功响应请求
        peripheral.respond(to: request, withResult: .success)
    }
    
    /** 中心设备写入数据 */
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        let request = requests.last!
        print(String.init(data: request.value!, encoding: String.Encoding.utf8)!)
        if(father != nil){
            father?.receiveMsg(data: String.init(data: request.value!, encoding: String.Encoding.utf8)!)
        }
        
    }
    
    /** 订阅成功回调 */
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("\(#function) 订阅成功回调")
    }
    
    /** 取消订阅回调 */
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        print("\(#function) 取消订阅回调")
    }
    
    //MARK: Methods
    func initperipheral(){
        
        let serviceID = CBUUID.init(string: Service_UUID)
        let service = CBMutableService.init(type: serviceID, primary: true)
        let characteristicID = CBUUID.init(string: Characteristic_UUID)
        let characteristic = CBMutableCharacteristic.init(type: characteristicID,
                                                          properties: [.read, .write, .notify],
                                                          value: nil,
                                                          permissions: [.readable, .writeable])
        service.characteristics = [characteristic]
        self.peripheralManager?.add(service)
        self.characteristic = characteristic
    }
}
