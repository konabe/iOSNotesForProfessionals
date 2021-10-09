//
//  ViewController.swift
//  Chapter88_SafariServices
//
//  Created by 小鍋涼太 on 2021/10/10.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // §88.1 Open a URL with SafariViewController
        let safariVC = SFSafariViewController(url: URL(string: "https://httpbin.org/")!)
        safariVC.delegate = self
        present(safariVC, animated: true, completion: nil)
        
        // §88.3 Add Items to Safari Reading List
        let readingList = SSReadingList.default()
        // 許可されていない場合はreadingListはnilになる。
        try! readingList?.addItem(with: URL(string: "https://httpbin.org/")!, title: "HTTPBIN", previewText: "これはhttpbinのプレビューです")
        let supports = SSReadingList.supportsURL(URL(string: "https://httpbin.org/")!)
        print(supports)
    }


}

// §88.2 Implement SFSafariViewControllerDelegate
extension ViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        print("completed")
    }
    
    func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
        print(title)
        return [UIActivity()]
    }
}
