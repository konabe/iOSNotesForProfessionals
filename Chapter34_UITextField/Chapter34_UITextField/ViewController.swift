//
//  ViewController.swift
//  Chapter34_UITextField
//
//  Created by 小鍋涼太 on 2021/09/07.
//

import UIKit

// Chapter34 UITextField
// キーボードでテキスト入力を収集する。

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var noCursorTextField: CustomTextField!
    private var focusedControl: UIControl!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var pickerTextfield: UITextField!
    var picker: MyPickerView?
    var pickerAccessory: UIToolbar?
    @IBOutlet weak var cursorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §34.1 Get Keyboard Focus and Hide Keyboard
        
        // §34.2 Dismmiss keyboard when user pushes the return button
        textField.delegate = self
        
        // §34.4 Input accessory view (toolbar)
        // キーボードの上に出てくるアクセサリーを追加する
        // 次へ、戻る　ボタン、完了、送信ボタン
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
        
        // §34.5 Moving scroll when UITextView becomes first responder
        // UIKeyboardWillShowNofiticationとUIKeyboardWillHideNotificationを観測して、キーボードの高さにあわせてScrollViewのContentInsetsを変更する。
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: self.view.window, queue: nil) { note in
            guard self.view.window != nil, self.isViewLoaded else {
                return
            }
            guard let userInfo = note.userInfo as? [String: Any] else {
                return
            }
            // keyboardはWindowレベルなのでconvertでviewレベルに変換する。
            let keyboardFrameInWindow = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            let keyboardFrameInView = self.view.convert(keyboardFrameInWindow.cgRectValue, from: nil)
            // 現状スクロールビューとキーボードはどれくらいの高さ被っているのか計算する
            let scrollViewKeyboardIntersection = self.scrollView.frame.intersection(keyboardFrameInView)
            let newContentInsets = UIEdgeInsets(top: 0, left: 0, bottom: scrollViewKeyboardIntersection.size.height, right: 0)
            
            UIView.animate(withDuration: 1.0) {
                self.scrollView.contentInset = newContentInsets
                self.scrollView.scrollIndicatorInsets = newContentInsets
                
                guard let focusedControl = self.focusedControl else {
                    return
                }
                // scrollViewからみてどこかを計算する
                // TODO: うまくいってなさそうなのでデバッグ
                var controlFrameInScrollView = self.scrollView.convert(focusedControl.bounds, from: focusedControl)
                controlFrameInScrollView = controlFrameInScrollView.insetBy(dx: 0, dy: -10)
                let controlVisualOffsetToTopOfScrollView = controlFrameInScrollView.origin.y - self.scrollView.contentOffset.y
                let controlVisualBottom = controlVisualOffsetToTopOfScrollView + controlFrameInScrollView.size.height
                let scrollViewVisibleHeight = self.scrollView.frame.size.height - scrollViewKeyboardIntersection.size.height
                if controlVisualBottom > scrollViewVisibleHeight {
                    var newContentOffset = self.scrollView.contentOffset
                    newContentOffset.y += controlVisualBottom - scrollViewVisibleHeight
                    newContentOffset.y += min(newContentOffset.y, self.scrollView.contentSize.height - scrollViewVisibleHeight)
                    self.scrollView.setContentOffset(newContentOffset, animated: false)
                } else if controlFrameInScrollView.origin.y < self.scrollView.contentOffset.y {
                    var newContentOffset = self.scrollView.contentOffset
                    newContentOffset.y = controlFrameInScrollView.origin.y
                    self.scrollView.setContentOffset(newContentOffset, animated: false)
                }
            }
            
            
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: self.view.window, queue: nil) { note in
            self.scrollView.contentInset = .zero
            self.scrollView.scrollIndicatorInsets = .zero
        }
        
        // §34.6 KeyboardType
        textField.keyboardType = .numberPad
        
        // §34.7 Change Placholder color and font
        var placeholderAttributes = [NSAttributedString.Key: Any]()
        placeholderAttributes[.foregroundColor] = UIColor.red
        placeholderAttributes[.font] = UIFont.systemFont(ofSize: 5)
        if let placeholder = textField.placeholder {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        }
        
        // §34.8 Replace keyboard with UIPickerView
        // キーボードの代わりにUIPickerViewを見せたい。
        picker = MyPickerView()
        // 親ビューの幅が変わったら、それに応じて、高さも幅も変わる
        picker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        picker?.backgroundColor = .white
        picker?.data = ["One", "Two", "Three", "Four", "Five"]
        pickerTextfield.inputView = picker
        pickerAccessory = UIToolbar()
        pickerAccessory?.autoresizingMask = .flexibleHeight
        pickerAccessory?.barStyle = .default
        pickerAccessory?.barTintColor = .red
        pickerAccessory?.backgroundColor = .red
        pickerAccessory?.isTranslucent = false
        var accessoryFrame = pickerAccessory?.frame
        accessoryFrame?.size.height = 44.0 // おすすめの高さ
        pickerAccessory?.frame = accessoryFrame!
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnClicked))
        cancelButton.tintColor = .white
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClicked))
        doneButton2.tintColor = .white
        pickerAccessory?.items = [cancelButton, flexSpace, doneButton2]
        pickerTextfield.inputAccessoryView = pickerAccessory
        picker?.selectRow(3, inComponent: 0, animated: true)
        
        // §34.9 Create a UITextField
        // §34.12 Initialize text field
        _ = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        
        // §34.10 Getting and Setting the Cursor Position
        // UITextViewでも同じことができる
        
        // §34.11 Dismiss Keyboard
        
        // §34.13 Autocapitalization
        noCursorTextField.autocapitalizationType = .allCharacters
        // §34.14 Set Alignment
        noCursorTextField.textAlignment = .center
    }
    
    // §34.1
    @IBAction func focusButtonTapped(_ sender: Any) {
        textField.becomeFirstResponder()
    }
    @IBAction func resignButtonTapped(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    // §34.4
    @objc func done() {
        print("done")
        textField.resignFirstResponder()
    }
    
    // §34.8
    @objc func cancelBtnClicked() {
        pickerTextfield.resignFirstResponder()
    }
    
    // §34.8
    @objc func doneBtnClicked() {
        pickerTextfield.resignFirstResponder()
        pickerTextfield.text = picker?.selectedValue
    }
    // §34.10
    @IBAction func didtapCursorBtn(_ sender: Any) {
        var result = ""
        let startPosition = textField.beginningOfDocument
        let selectedRange = textField.selectedTextRange
        if let selectedRange = selectedRange {
            let cursorPosition = textField.offset(from: startPosition, to: selectedRange.start)
            result += "cursorPosition=\(cursorPosition)"
        }
        cursorLabel.text = result
    }
    
    @IBAction func didTapBeginningBtn(_ sender: Any) {
        let newPosition = textField.beginningOfDocument
        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
    }
    
    @IBAction func didTapEndBtn(_ sender: Any) {
        let newPosition = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
    }
    
    @IBAction func didTapLeftBtn(_ sender: Any) {
        if let selectedRange = textField.selectedTextRange {
            // in引数はカーソルが向かう方向のことをいう
            if let newPosition = textField.position(from: selectedRange.start, in: .left, offset: 1) {
                textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    @IBAction func didTapAllBtn(_ sender: Any) {
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }
    
    // §34.11
    @IBAction func textFieldResign(_ sender: Any) {
        textField.resignFirstResponder()
    }
    

}

extension ViewController: UITextFieldDelegate {
    // §34.2
    // §34.11
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == secondTextField || textField == firstTextField {
            focusedControl = submitButton
        }
        return true
    }
    
    
}

class CustomTextField: UITextField {
    // §34.3 Hide blinking caret
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
}

// §34.8
class MyPickerView: UIPickerView {
    var data: [String]? {
        didSet {
            super.delegate = self
            super.dataSource = self
            self.reloadAllComponents()
        }
    }
    var textFieldBeingEdited: UITextField?
    var selectedValue: String {
        get {
            data?[selectedRow(inComponent: 0)] ?? ""
        }
    }
    
}

extension MyPickerView: UIPickerViewDelegate {
    
}

extension MyPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        data?[row]
    }
    
}
