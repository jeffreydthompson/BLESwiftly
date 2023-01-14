//
//  BLEPeripheral.swift
//
//  Created by Jeffrey Thompson on 9/16/22.
//

import Foundation

public struct BLEPeripheral: Identifiable, Decodable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case id, name, rssi
        case serviceUUIDs = "kCBAdvDataServiceUUIDs"
        case timeStamp = "kCBAdvDataTimestamp"
        case localName = "kCBAdvDataLocalName"
        case isConnectable = "kCBAdvDataIsConnectable"
        case mfgData = "kCBAdvDataManufacturerData"
    }
    
    public var id: String
    public var name: String?
    public var rssi: Int
    public var serviceUUIDs: [String]?
    public var timeStamp: Double?
    public var localName: String?
    public var isConnectable: Bool?
    public var mfgData: String?
    
}
