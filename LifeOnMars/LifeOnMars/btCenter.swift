//
//  btCenter.swift
//  LifeOnMars
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018 nju. All rights reserved.
//

import UIKit
import CoreBluetooth

class btCenter: UIView, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    var centerManager:CBCentralManager? = nil
    var mperipheral:CBPeripheral? = nil
    var pers:[CBPeripheral] = []
    var infos:[String] = []
    
    private let Service_UUID: String = "CDD1"
    private let Characteristic_UUID: String = "CDD2"
    private var characteristic: CBCharacteristic?

    override init(frame: CGRect) {
        super.init(frame: frame)
        centerManager = CBCentralManager(delegate: self, queue: .main, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if(central.state == .poweredOn){
            central.scanForPeripherals(withServices: [CBUUID.init(string: Service_UUID)], options: nil)
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral.name)
//        if((peripheral.name?.hasPrefix("LOM"))!){
        pers.append(peripheral)
        centerManager?.connect(peripheral, options: nil)
//        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        //        centerManager?.stopScan()
        print("连接成功")
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID.init(string: Service_UUID)])
    }
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接失败")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("断开连接")
        // 重新连接
        central.connect(peripheral, options: nil)
    }
    
    //MARK: CBPeripheralDelegate
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service: CBService in peripheral.services! {
            print("外设中的服务有：\(service)")
        }
        let service = peripheral.services?.last
        if(service != nil){
            peripheral.discoverCharacteristics([CBUUID.init(string: Characteristic_UUID)], for: service!)
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic: CBCharacteristic in service.characteristics! {
            print("外设中的特征有：\(characteristic)")
        }
        
        self.characteristic = service.characteristics?.last
        peripheral.readValue(for: self.characteristic!)
        peripheral.setNotifyValue(true, for: self.characteristic!)
    }
    
    /** 订阅状态 */
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("订阅失败: \(error)")
            return
        }
        if characteristic.isNotifying {
            print("订阅成功")
        } else {
            print("取消订阅")
        }
    }
    /** 接收到数据 */
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let data = characteristic.value
        infos.append(String.init(data: data!, encoding: String.Encoding.utf8)!)
    }
    
    /** 写入数据 */
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("写入数据")
    }
    
    //MARK: Methods
    func send(data: String) {
        let rawdata = data.data(using: String.Encoding.utf8)
        self.mperipheral?.writeValue(rawdata!, for: self.characteristic!, type: CBCharacteristicWriteType.withResponse)
    }
    
    func link(index:Int){
        mperipheral = pers[index]
        centerManager?.connect(mperipheral!, options: nil)
    }
    
    /** 断开连接 */
    func disconnect(){
        infos.removeAll()
        for x in pers{
            centerManager?.cancelPeripheralConnection(x)
        }
        pers.removeAll()
    }
}
