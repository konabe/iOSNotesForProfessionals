//
//  ViewController.swift
//  Chapter50_UIDevice
//
//  Created by 小鍋涼太 on 2021/09/18.
//

import UIKit

// Chapter50 UIDevice

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §50.1 Get iOS device model name
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        // x86_64はシミュレータ
        print("identifier = \(identifier)")
        
        // §50.2 Identifying the Device and Operating
        let deviceInfo = UIDevice.current
        print(".name = \(deviceInfo.name)")
        print(".systemName = \(deviceInfo.systemName)")
        print(".systemVersion = \(deviceInfo.systemVersion)")
        print(".model = \(deviceInfo.model)")
        print(".localizedModel = \(deviceInfo.localizedModel)")
        // iPhoneかiPadか？などを識別できる
        print(".userInterfaceIdiom = \(deviceInfo.userInterfaceIdiom.rawValue)")
        print(".identifierForVendor = \(String(describing: deviceInfo.identifierForVendor))")
        
        // §50.3 Getting the Device Orientation
        // simulatorだとunknownになってしまってる。。
        // 代替手段を使ったほうがよいらしい。
        // NotificationCenterで変更を検知できるらしいが、変更があるかもわからないので省略。
        print(".orientation = \(deviceInfo.orientation.rawValue)")
        
        // §50.4 Getting the Device Battery State
        // §50.6 Getting Battery Status and Battery Level
        deviceInfo.isBatteryMonitoringEnabled = true
        // 1 充電ケーブルがささってない 2 充電中 3 充電完了
        print(".batteryState = \(deviceInfo.batteryState.rawValue)")
        NotificationCenter.default.addObserver(forName: UIDevice.batteryStateDidChangeNotification, object: nil, queue: nil) { notificaiton in
            switch deviceInfo.batteryState {
            case .unknown:
                self.label.text = "不明"
            case .unplugged:
                self.label.text = "充電ケーブルが外れてる"
            case .charging:
                self.label.text = "充電中"
            case .full:
                self.label.text = "充電完了"
            @unknown default:
                fatalError()
            }
        }
        NotificationCenter.default.addObserver(forName: UIDevice.batteryLevelDidChangeNotification, object: nil, queue: nil) { note in
            self.label.text =  "バッテリー\(deviceInfo.batteryLevel) %"
        }
        
        // §50.5 Using the Proximity Sensor
        // TODO: うまくいかなかった
        NotificationCenter.default.addObserver(forName: UIDevice.proximityStateDidChangeNotification, object: nil, queue: nil) { note in
            self.label.text = deviceInfo.proximityState ? "顔が近い" : "顔が遠い"
        }
        
    }


}
