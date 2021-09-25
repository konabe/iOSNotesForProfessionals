//
//  ViewController.swift
//  Chapter64_ManagingTheKeyboard
//
//  Created by 小鍋涼太 on 2021/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // § 64.1 Create a custom in-app keyboard
        // - xibでキーボードのレイアウトを作る(UIView)
        // - UITextFieldにカスタムキーボードを使うことを伝える
        // - デリゲートでキーボードとVieController間で通信
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self
        textField.inputView = keyboardView
        
        // §64.2 Dismiss a keyboard with tap on view
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tapGestureRecognizer)
        // iOS10ならこっちの方法もある。
        textField.delegate = self
        
        // §64.3 Managing the Keyboard Using a Singleton + Delegate
        // TODO: 雑なので飛ばす。
        
        // §64.4 Moving view up or down when keyboard is present
        // 安定感がないので、修正が必要
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // §64.5 Scrolling a UIScrollView/UITableView When Displaying the Keyboard
        // Keyboardの高さに合わせてUITableViewのcontentInsetを変えれば良い。
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
}

extension ViewController: KeyboardDelegate {
    func keyWasTapped(character: String) {
        textField.insertText(character)
    }
}

extension ViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
