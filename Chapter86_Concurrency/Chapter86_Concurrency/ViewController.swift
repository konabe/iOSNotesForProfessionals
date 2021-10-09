//
//  ViewController.swift
//  Chapter86_Concurrency
//
//  Created by 小鍋涼太 on 2021/10/09.
//

import UIKit

// Queueを使うと並行処理が行われる。
// 

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §86.1 Dispatch group - waiting for other threads completed
        print("viewDidLoad")
        let prepareGroup = DispatchGroup()
        prepareGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("2sec")
            prepareGroup.leave()
        }
        prepareGroup.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("3sec")
            prepareGroup.leave()
        }
        // enterした分だけleaveしないといけない。
        // prepareGroup.enter()
        prepareGroup.notify(queue: DispatchQueue.main) {
            print("Prepare Completed")
        }
        
        // §86.2 Executing on the main thread
        // メインスレッドでの実行を保証する必要があることがある。
        // i.e. REST APIを非同期で実行して、結果をUILabelに表示するとき。
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.async {
                self.view.backgroundColor = .red
            }
        }
        
        // §86.3 Running code concurrency -- Running code while running other code
        let queue = DispatchQueue(label: "test", attributes: .concurrent)
        queue.async {
            for i in 0..<100 {
                print("Foo \(i)")
                usleep(100000)
            }
        }
        for i in 0..<100 {
            print("Bar \(i)")
            usleep(50000)
        }
    }


}

