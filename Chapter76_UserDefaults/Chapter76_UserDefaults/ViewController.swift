//
//  ViewController.swift
//  Chapter76_UserDefaults
//
//  Created by 小鍋涼太 on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §76.1 Setting values
        // §76.6 Getting Default values
        UserDefaults.standard.set("Netherlands", forKey: "HomeCountry")
        UserDefaults.standard.set(try! NSKeyedArchiver.archivedData(withRootObject: CustomObject(name: "testName", unitId: 100), requiringSecureCoding: false), forKey: "customKey")
        
        // §76.2 UserDefaults uses in Swift 3
        // $76.3 Use MAnagers to save and Read Data
        // Managerクラスを使えばいいという話。
        
        // §76.4 Saving Values
        // ディスクに周期的に保存してるが、すぐに変更を反映したい場合はこれを呼ぶ。
        UserDefaults.standard.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(UserDefaults.standard.string(forKey: "HomeCountry"))
        if let data = UserDefaults.standard.object(forKey: "customKey") as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? CustomObject {
                print("\(unarchivedObject.name!) : \(unarchivedObject.unitId!)")
            }
        }
        
        // §76.5 Clearing UserDefaults
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.string(forKey: "HomeCountry") == nil {
            print("ちゃんと消えてます")
        }
    }


}

class CustomObject: NSObject, NSCoding {
    var name: String?
    var unitId: Int?
    
    init(name: String, unitId: Int) {
        self.name = name
        self.unitId = unitId
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(unitId, forKey: "unitId")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String
        unitId = coder.decodeObject(forKey: "unitId") as? Int
    }
    
    
}
