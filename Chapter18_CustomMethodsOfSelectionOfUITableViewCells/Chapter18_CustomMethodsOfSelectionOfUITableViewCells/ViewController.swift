//
//  ViewController.swift
//  Chapter18_CustomMethodsOfSelectionOfUITableViewCells
//
//  Created by 小鍋涼太 on 2021/08/30.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §18.1 Distinction between single and double selection on row
        let doubleTapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleDoubleTap(sender:))
        )
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        tableView.addGestureRecognizer(doubleTapGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapGesture(sender:))
        )
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        tableView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    @objc
    private func handleTapGesture(sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: touchPoint) {
            print("Single \(indexPath)")
        }
    }
    
    @objc
    private func handleDoubleTap(sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: touchPoint) {
            print("Double \(indexPath)")
        }
    }
    
}

