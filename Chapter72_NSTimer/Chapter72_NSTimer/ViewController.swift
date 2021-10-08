//
//  ViewController.swift
//  Chapter72_NSTimer
//
//  Created by 小鍋涼太 on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    private var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §72.1 Creating a Timer
        // §72.3 Timer frequency options
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.label.text = Date().description
            print("called")
        }
        
        // §72.2　Manually firing a timer
        // 強制的に中身を実行する。
        timer.fire()
        
        // §72.5 Passing of data using Timer
        // userInfo: で渡す。
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(stopTapped(_:)), userInfo: "I am iOS guy", repeats: false)
        
    }
    // §72.4 Invalidating a timer
    // Timerを作った同じスレッドの中でとめなければならない。
    // 他のスレッドからメッセージを送ろうとすると、適切にスレッドから抜けられなくなる。
    // 一度止めたら二度と発火できない。
    @IBAction @objc func stopTapped(_ sender: Any) {
        timer.invalidate()
        label.textColor = .red
    }
    

}

