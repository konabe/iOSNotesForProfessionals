//
//  ViewController.swift
//  Chapter16_UIRefreshControl TableView
//
//  Created by 小鍋涼太 on 2021/08/30.
//

import UIKit

// Chapter 16: UIRefreshControl TableView
// UIRefreshControlはTableViewのコンテンツのリフレッシュに使う。

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §16.1 Set up refreshControl on tableview
        let refreshControl = UIRefreshControl()
        refreshControl.addAction(.init{ _ in
            self.pullToRefresh(sender: refreshControl)
        }, for: .valueChanged)
        refreshControl.tintColor = .red
        refreshControl.attributedTitle = NSAttributedString(string: "更新中")
        tableView.refreshControl = refreshControl
    }
    
    private func pullToRefresh(sender: UIRefreshControl) {
        sender.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("Complete")
            sender.endRefreshing()
        }
    }

}

