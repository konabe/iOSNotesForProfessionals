//
//  ViewController.swift
//  Chapter91_SwiftAndObjectiveCInteroperability
//
//  Created by 小鍋涼太 on 2021/10/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §91.1 Using Objective-C Classes in Swift
        let instanceOfCustomObject = CustomObject()
        instanceOfCustomObject.someProperty = "Hello World"
        print(instanceOfCustomObject.someProperty)
        instanceOfCustomObject.someMethod()
        
    }
    
}

// 91.2 Using Swift Classes in Objective-C
class MySwiftObject: NSObject {
    var someProperty_ : NSString = "Some Initializer Val"
    @objc func someProperty() -> NSString {
        return someProperty_
    }
    @objc func setSomeProperty(_ p: NSString) -> Void {
        someProperty_ = p
    }
    
    // Objective-Cで使えるようにする。
    @objc func someFunction(someArg: AnyObject) -> String {
        let returnVal = "You sent me \(someArg)"
        return returnVal
    }
}
