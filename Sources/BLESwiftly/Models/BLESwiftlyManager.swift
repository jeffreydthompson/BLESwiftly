//
//  BLEManager.swift
//
//  Created by Jeffrey Thompson on 11/16/22.
//

import Foundation
import Combine
import CoreBluetooth

public class BLESwiftlyManager: NSObject, BLEService {
    
    @Published var _isScanning = false
    var isScanning: Published<Bool>.Publisher { $_isScanning }
    
    var isOn = PassthroughSubject<Bool, BLEError>()
    var isConnectedToPeripheral = PassthroughSubject<Bool, BLEError>()
    
    public var scannedPeripheral = PassthroughSubject<BLEPeripheral, Never>()
    
    private var cbManager: CBCentralManager!
    
    override init() {
        super.init()
        cbManager = CBCentralManager(delegate: self, queue: .global(qos: .default))
    }
    
    public func startScan(duration seconds: Double?) {
        cbManager.scanForPeripherals(withServices: nil)
        updateScanState()
        if let seconds = seconds {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
                guard let self = self else { return }
                self.stopScan()
            }
        }
    }
    
    public func stopScan() {
        cbManager.stopScan()
        updateScanState()
    }
    
    private func updateScanState() {
        _isScanning = cbManager.isScanning
    }
    
}

extension BLESwiftlyManager: CBCentralManagerDelegate {
    
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
        updateScanState()
    }
    
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if let data = try? JSONSerialization.data(peripheral, BLEAdvertisementData: advertisementData, rssi: RSSI),
           let peripheral = try? JSONDecoder().decode(BLEPeripheral.self, from: data) {
            scannedPeripheral.send(peripheral)
        }
    }
    
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        isConnectedToPeripheral.send(true)
    }
    
    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
        isConnectedToPeripheral.send(completion: .failure(.failedToConnect))
    }
    
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
        if let _ = error {
            isConnectedToPeripheral.send(completion: .failure(.disconnectError))
        } else {
            isConnectedToPeripheral.send(false)
        }
    }
}

extension BLESwiftlyManager: CBPeripheralDelegate {
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        peripheral.services?.forEach({ service in
            
        })
        
    }
}
