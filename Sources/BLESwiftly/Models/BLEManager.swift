//
//  BLEManager.swift
//
//  Created by Jeffrey Thompson on 11/16/22.
//

import Foundation
import Combine
import CoreBluetooth

public class BLEManager: NSObject, BLEService {

    private var cbManager: CBCentralManager!
    
    public var isOn = PassthroughSubject<Bool, BLEError>()
    public var isScanning = PassthroughSubject<Bool, Never>()
    public var scannedPeripheral = PassthroughSubject<BLEPeripheral, Never>()
    
    override init() {
        super.init()
        cbManager = CBCentralManager(delegate: self, queue: .global(qos: .default))
    }
    
    public func startScan(duration seconds: Double?) {
        cbManager.scanForPeripherals(withServices: nil)
        if let seconds = seconds {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
                guard let self = self else { return }
                self.stopScan()
            }
        }
    }
    
    public func stopScan() {
        cbManager.stopScan()
    }
    
}

extension BLEManager: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            isOn.send(true)
        case .poweredOff:
            isOn.send(false)
        case .unauthorized:
            isOn.send(completion: .failure(.bleIsUnauthorized))
        case .unsupported:
            isOn.send(completion: .failure(.bleIsUnsupported))
        case .unknown:
            isOn.send(completion: .failure(.bleUnknownError))
        default:
            isOn.send(false)
        }
    }
    
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if let data = try? JSONSerialization.data(peripheral, BLEAdvertisementData: advertisementData, rssi: RSSI),
           let peripheral = try? JSONDecoder().decode(BLEPeripheral.self, from: data) {
            scannedPeripheral.send(peripheral)
        }
    }
}
