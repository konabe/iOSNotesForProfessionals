//
//  ViewController.swift
//  Chapter54_UIPickerView
//
//  Created by 小鍋涼太 on 2021/09/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnFolder: UIButton!
    let pickerView = UIPickerView()
    let pickerViewRows = ["First row", "Second row", "Third row", "Fourth row"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §54.1 Basic example
        btnFolder.addAction(.init {_ in
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            self.view.addSubview(self.pickerView)
        }, for: .touchUpInside)
        
        pickerView.setValue(UIColor.green, forKey: "textColor")
        pickerView.setValue(UIColor.blue, forKey: "backgroundColor")
    }

}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerViewRows[row]
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerViewRows.count
    }
}
