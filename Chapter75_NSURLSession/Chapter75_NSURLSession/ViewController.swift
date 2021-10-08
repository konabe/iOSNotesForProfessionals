//
//  ViewController.swift
//  Chapter75_NSURLSession
//
//  Created by 小鍋涼太 on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §75.1 Create a Session And Data Task
        let url = URL(string: "https://httpbin.org/")!
        // §75.3 Simple GET Request
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration)
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            print(response.debugDescription)
        }.resume()
        
        // §75.2 Setting up background configuration
        let mySessionID = "org.httpbin.bgSession"
        let bgSessionConfig = URLSessionConfiguration.background(withIdentifier: mySessionID)
        let sessionBg = URLSession(configuration: bgSessionConfig, delegate: self, delegateQueue: nil)
        let task = sessionBg.dataTask(with: url)
        task.resume()
        // 同じSessionIDで２つのセッションを作るのは危険
        // 適切なタイミングで再作成したほうがいい。
        
        // §75.4 Sending a POST request with arguments using NSURLSession in Objective-C
        // TODO: Objective-Cなので飛ばす
    }
}

extension ViewController: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(task.response.debugDescription)
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        // https://tech-blog.optim.co.jp/entry/2020/03/30/160000
        print("background session finished!")
    }
}

