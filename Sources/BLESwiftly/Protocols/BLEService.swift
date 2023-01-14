//
//  BLEService.swift
//
//  Created by Jeffrey Thompson on 11/16/22.
//

import Foundation
import Combine

public protocol BLEService {

    var isOn: PassthroughSubject<Bool, BLEError> { get }
    var isScanning: PassthroughSubject<Bool, Never> { get }
    var scannedPeripheral: PassthroughSubject<BLEPeripheral, Never> { get }
    
    func startScan(duration seconds: Double?)
    func stopScan()
    
}

extension BLEService {

    func startScan() {
        startScan(duration: nil)
    }
}


