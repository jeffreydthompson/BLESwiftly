//
//  JSONSerialization+withBLEAdvData.swift
//
//  Created by Jeffrey Thompson on 9/18/22.
//

import Foundation
import CoreBluetooth

extension JSONSerialization {
    class func data(
        _ peripheral: CBPeripheral,
        BLEAdvertisementData advData: [String: Any],
        rssi: NSNumber
    ) throws -> Data {

        var bluetoothData = [String: Any]()
        
        bluetoothData["id"] = peripheral.identifier.uuidString
        bluetoothData["rssi"] = rssi
        
        if let peripheralName = peripheral.name {
            bluetoothData["name"] = peripheralName
        }

        if let uuids = advData["kCBAdvDataServiceUUIDs"] as? NSArray {
            bluetoothData["kCBAdvDataServiceUUIDs"] = uuids.map { "\($0)" }
        }
        
        if let name = advData["kCBAdvDataLocalName"] {
            bluetoothData["kCBAdvDataLocalName"] = name as? String
        }
        
        if let data = advData["kCBAdvDataManufacturerData"] as? Data {
            bluetoothData["kCBAdvDataManufacturerData"] = data.hexString
        }
        
        if let connectable = advData["kCBAdvDataIsConnectable"] as? Bool {
            bluetoothData["kCBAdvDataIsConnectable"] = connectable
        }
        
        if let timestamp = advData["kCBAdvDataTimestamp"] as? Double {
            bluetoothData["kCBAdvDataTimestamp"] = timestamp
        }
        
        return try JSONSerialization.data(withJSONObject: bluetoothData, options: .fragmentsAllowed)
    }
}
