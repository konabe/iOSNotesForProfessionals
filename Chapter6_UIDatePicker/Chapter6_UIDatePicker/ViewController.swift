//
//  ViewController.swift
//  Chapter6_UIDatePicker
//
//  Created by 小鍋涼太 on 2021/08/24.
//

import UIKit

// Chapter6: UIDatePicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §6.1 Create a Date Picker
        let datePicker = UIDatePicker(frame: CGRect(x: 20, y: 40, width: 320, height: 200))
        // 旧デザインのホイールのスタイルにしたい場合はこれを設定
        datePicker.preferredDatePickerStyle = .wheels
        view.addSubview(datePicker)
        
        // §6.2 Setting Minimum-Maximum Date
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        
        // §6.3 Modes
        // .date: 日付だけ, .time: 時間だけ
        // .dateAndTime: 日付と時間, .countDownTimer: 時間と分だけ
        datePicker.datePickerMode = .countDownTimer
        
        // §6.4 Setting minute interval
        // 1 ~ 30
        datePicker.minuteInterval = 10
        
        // §6.5 Count Down Duration ( 2h 20m )
        datePicker.countDownDuration = 2 * 3600 + 20 * 60
    }


}

