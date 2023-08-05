//
//  CallArduinoWithBluetooth.swift
//  testSpaceiOS
//
//  Created by a mystic on 2023/08/02.
//

import UIKit
import CoreBluetooth
import SwiftUI

class BluetoothController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    // 아두이노의 온도센서 서비스 UUID와 특성 UUID 설정
    let serviceUUID = CBUUID(string: "온도센서 서비스 UUID")
    let characteristicUUID = CBUUID(string: "온도센서 특성 UUID")
    
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // CBCentralManager 초기화
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // 블루투스 상태 변화 시 호출되는 메소드
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("블루투스가 활성화되었습니다.")
            // 주변 디바이스 찾기 시작
            centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        case .poweredOff:
            print("블루투스가 비활성화되었습니다.")
        case .unsupported:
            print("블루투스가 지원되지 않습니다.")
        default:
            break
        }
    }
    
    // 주변 디바이스를 찾았을 때 호출되는 메소드
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print("주변 디바이스를 찾았습니다.")
        
        // 원하는 Peripheral을 찾았을 경우 연결을 시도합니다.
        if peripheral.name == "온도센서 디바이스 이름" {
            centralManager.stopScan() // 스캔 중지
            self.peripheral = peripheral // 연결할 Peripheral 저장
            self.peripheral?.delegate = self
            centralManager.connect(peripheral, options: nil) // Peripheral 연결 시도
        }
    }
    
    // Peripheral과 연결되었을 때 호출되는 메소드
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Peripheral과 연결되었습니다.")
        peripheral.discoverServices([serviceUUID]) // 서비스 탐색 시작
    }
    
    // 서비스를 찾았을 때 호출되는 메소드
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                if service.uuid == serviceUUID {
                    peripheral.discoverCharacteristics([characteristicUUID], for: service) // 특성 탐색 시작
                }
            }
        }
    }
    
    // 특성을 찾았을 때 호출되는 메소드
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == characteristicUUID {
                    peripheral.readValue(for: characteristic) // 특성 값을 읽어옴
                }
            }
        }
    }
    
    // 특성 값을 읽어왔을 때 호출되는 메소드
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value {
            // 데이터 처리 (여기서는 그냥 콘솔에 출력)
            print("온도 센서 데이터: \(value)")
            // 데이터를 블루투스로 전송하는 함수 호출 (예시)
            sendDataOverBluetooth(data: value)
        }
    }
    
    // 블루투스로 데이터를 보내는 함수 (여기서는 예시로 콘솔에 출력)
    func sendDataOverBluetooth(data: Data) {
        let dataString = String(data: data, encoding: .utf8)
        print("블루투스로 전송한 데이터: \(dataString ?? "")")
    }
}

struct bluetooth: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        BluetoothController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
}

class testcontrolelr: UIViewController {
    override func viewDidLoad() {
        print("testcontroller")
    }
}

struct testWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return testcontrolelr()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
    
}
