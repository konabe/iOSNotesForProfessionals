//
//  ViewController.swift
//  Chapter15_UITableViewController
//
//  Created by 小鍋涼太 on 2021/08/30.
//

import UIKit

// Chapter15: UITableViewController
// テキストフィールドとセルをたくさん持つ要な場合はこっちのほうがいい。

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §15.1 TableView with dynamic properties with tableviewCellStyle basic
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // §15.1 Identifierについてはstoryboard上で定義している。
        // スタイルについてもstoryboard上でbasicとした。
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "Cell \(indexPath.row) :Hello"
            return cell
        }
        // §15.2 TableView with Custom Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
        cell.lblTitle.text = "Cell \(indexPath.row) :Hello"
        return cell
    }


}

