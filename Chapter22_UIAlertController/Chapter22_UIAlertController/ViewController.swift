//
//  ViewController.swift
//  Chapter22_UIAlertController
//
//  Created by 小鍋涼太 on 2021/09/03.
//

import UIKit

// Chapter 22: UIAlertController

class ViewController: UIViewController {

    @IBOutlet weak var simpleAlertViewButton: UIButton!
    @IBOutlet weak var destructiveAlertViewButton: UIButton!
    @IBOutlet weak var actionSheetsButton: UIButton!
    @IBOutlet weak var textFieldButton: UIButton!
    var textFieldDefaultAction: UIAlertAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §22.5 Displaying and handling alerts
        // UIAlertViewの3つ以上は縦に並ぶので注意。
    }
    
    @IBAction func simpleAlertViewTapped(_ sender: Any) {
        // §22.1 AlertViews with UIAlertController
        // UIAlertView, UIActionSheetはiOS8でDeprecatedになった。
        // これらをUIAlertControllerとした。 (preferredStyleを変えれば切り替えられる。)
        // Delegateはない
        let alert = UIAlertController(title: "シンプル", message: "シンプルなアラートビューです。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.simpleAlertViewButton.setTitle("キャンセルされました。", for: .normal)
        }))
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.simpleAlertViewButton.setTitle("OKされました。", for: .normal)
        })
        alert.addAction(okAction)
        // §22.4 Highlighting an action button
        // preferredActionに設定すると、文字が濃くなる
        alert.preferredAction = okAction
        present(alert, animated: true)
    }
    
    @IBAction func destructiveAlertViewTapped(_ sender: Any) {
        // §22.1
        let alert = UIAlertController(title: "シンプル", message: "シンプルなアラートビューです。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: { _ in
            self.destructiveAlertViewButton.setTitle("キャンセルされました。", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.destructiveAlertViewButton.setTitle("OKされました。", for: .normal)
        }))
        present(alert, animated: true)
    }
    
    @IBAction func actionSheetsTapped(_ sender: Any) {
        // §22.2 Action Sheets with UIAlertController
        let alertController = UIAlertController(title: "デモ", message: "２つのボタンのデモです。", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.actionSheetsButton.setTitle("キャンセルされました。", for: .normal)
        }
        let firstAction = UIAlertAction(title: "1st", style: .default) { _ in
            self.actionSheetsButton.setTitle("1stが選ばれました。", for: .normal)
        }
        let secondAction = UIAlertAction(title: "2nd", style: .default) { _ in
            self.actionSheetsButton.setTitle("2ndが選ばれました。", for: .normal)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.actionSheetsButton.setTitle("Deleteされました", for: .normal)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
    
    @IBAction func textFieldTapped(_ sender: Any) {
        // §22.3 Adding Text Field in UIAlertController like a prompt Box
        let alert = UIAlertController(title: "こんにちは", message: "iOSの世界へようこそ", preferredStyle: .alert)
        textFieldDefaultAction = UIAlertAction(title: "OK", style: .default) { _ in
            
        }
        textFieldDefaultAction.isEnabled = false
        alert.addAction(textFieldDefaultAction)
        alert.addTextField() { tf in
            tf.delegate = self
        }
        present(alert, animated: true)
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // §22.3
        textFieldButton.setTitle(textField.text, for: .normal)
        textFieldDefaultAction.isEnabled = true
    }
}
