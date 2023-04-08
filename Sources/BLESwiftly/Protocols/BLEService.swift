//
//  BLEService.swift
//
//  Created by Jeffrey Thompson on 11/16/22.
//

import Foundation
import Combine

protocol BLEService {
    
    var isOn: PassthroughSubject<Bool, BLEError> { get }
    var isConnectedToPeripheral: PassthroughSubject<Bool, BLEError> { get }
    var isScanning: Published<Bool>.Publisher { get }
    
    var inRangeDevice: PassthroughSubject<BLEPeripheral, Never> { get }
    
    func startScan(duration seconds: Double?)
    func stopScan()
    
    // FIXME: make the following throw on error
    func connect(toPeripheralWith uuid: UUID) throws
    func subscribe(characteristicWith cUuid: UUID) throws
    func write(characteristicWith cUuid: UUID, value: String) throws
    func write(characteristicWith cUuid: UUID, command: Data) throws
    
    func queryPeripheralServices(with uuid: UUID) async throws -> [UUID]
}

extension BLEService {
    func startScan() {
        startScan(duration: nil)
    }
}


