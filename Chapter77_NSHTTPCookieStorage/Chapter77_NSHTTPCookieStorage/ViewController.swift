//
//  ViewController.swift
//  Chapter77_NSHTTPCookieStorage
//
//  Created by 小鍋涼太 on 2021/10/08.
//

import UIKit

// https://qiita.com/temoki/items/f14156b39f3aa913ed7e
// iOS 10以上では、URLSessionくらいでしか使われていない。

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §77.1 Store and read the cookies from UserDefault
        // クッキーがURLSessionを通して取得できるかだけ確認。
        let session = URLSession.shared.dataTask(with: URL(string: "https://httpbin.org/cookies/set?freeform=dada")!) { data, response, error in
            let savedC = HTTPCookieStorage.shared.cookies
            print(savedC.debugDescription)
        }
        session.resume()
    }


}
