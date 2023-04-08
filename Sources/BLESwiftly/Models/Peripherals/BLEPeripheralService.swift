//
//  File.swift
//  
//
//  Created by Jeffrey Thompson on 3/16/23.
//

import Foundation
import CoreBluetooth

public struct BLEPeripheralService {
    var uuidString: String
    var isPrimary: Bool
    var includedServices = [BLEPeripheralService]()
    var characteristics = [BLEPeripheralCharacteristic]()
    
    public init(
        uuidString: String,
        isPrimary: Bool,
        includedServices: [BLEPeripheralService] = [BLEPeripheralService](),
        characteristics: [BLEPeripheralCharacteristic] = [BLEPeripheralCharacteristic]()) {
            
            self.uuidString = uuidString
            self.isPrimary = isPrimary
            self.includedServices = includedServices
            self.characteristics = characteristics
    }
    
    init(from cbService: CBService) {
        isPrimary = cbService.isPrimary
        uuidString = cbService.uuid.uuidString
    }
}
