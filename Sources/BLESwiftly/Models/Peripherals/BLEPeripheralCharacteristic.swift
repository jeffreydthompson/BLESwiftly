//
//  File.swift
//  
//
//  Created by Jeffrey Thompson on 3/16/23.
//

import Foundation
import CoreBluetooth

public struct BLEPeripheralCharacteristic {
    
    let uuidString: String
    let value: Data?
    let properties: [CharacteristicProperty]
    
    public init(uuidString: String, value: Data?, properties: [CharacteristicProperty]) {
        self.uuidString = uuidString
        self.value = value
        self.properties = properties
    }
    
    init(from cbCharacteristic: CBCharacteristic) {
        uuidString = cbCharacteristic.uuid.uuidString
        value = cbCharacteristic.value
        properties = CharacteristicProperty.getProperties(from: cbCharacteristic.properties)
    }
}
