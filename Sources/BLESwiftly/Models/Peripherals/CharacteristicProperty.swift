//
//  File.swift
//  
//
//  Created by Jeffrey Thompson on 3/16/23.
//

import Foundation

//
//  CharacteristicProperty.swift
//  BluetoothBarebones
//
//  Created by Jeffrey Thompson on 3/16/23.
//

import Foundation
import CoreBluetooth

public enum CharacteristicProperty: UInt, CaseIterable {
    case broadcast
    case read
    case writeWithoutResponse
    case write
    case notify
    case indicate
    case authenticatedSignedWrites
    case extendedProperties
    case notifyEncryptionRequired
    case indicateEncryptionRequired
    
    private var maskValue: UInt {
        1 << rawValue
    }
    
    var toString: String {
        [
            "Broadcast",
            "Read",
            "Write Without Response",
            "Write",
            "Notify",
            "Indicate",
            "Authenticated Signed Writes",
            "Extended Properties",
            "Notify Encryption Required",
            "Indicate Encryption Required"
        ][Int(rawValue)]
    }
    
    private func isPresent(in properties: CBCharacteristicProperties) -> Bool {
        (properties.rawValue & self.maskValue) == self.maskValue
    }
    
    static func getProperties(
        from cbProperties: CBCharacteristicProperties) -> [CharacteristicProperty] {
            
            var properties = [CharacteristicProperty]()
            CharacteristicProperty.allCases.forEach { property in
                if property.isPresent(in: cbProperties) {
                    properties.append(property)
                }
            }
            return properties
    }
}
