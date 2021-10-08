//
//  ViewController.swift
//  Chapter73_NSDate
//
//  Created by 小鍋涼太 on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §73.1 NSDateFormatter
        // DateFormatterは重いのでできれば使いまわしたほうがいい。
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
        // §73.7 Get current Date
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        
        // §73.2 Date Comparison
        let date1 = dateFormatter.date(from: "2021-10-08 at 10:20")
        let date2 = dateFormatter.date(from: "2021-10-08 at 10:10")
        if date1 != date2 {
            print("date1とdate2は別です。")
        }
        if date1! > date2! {
            print("date1のほうがdate2よりも未来にあります。")
        }
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year, .month, .day,
            .hour, .minute, .second
        ]
        let dateComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        print(dateComponents.year.debugDescription)
        
        // §73.3 Get Historic Time from NSDate (eg: 5s ago, 2m ago, 3h ago)
        // 何分前か　とかを計算するときにTimeIntervalを使う。
        
        // §73.4 Get Unix Epoch time
        print(Date().timeIntervalSince1970)
        
        // §73.6 Get time cycle type (12-hour or 24-hour)
        
        // §73.8 Get NSDate Object N seconds from current date
        let nextWeek = Date(timeIntervalSinceNow: 7 * 24 * 60 * 60)
        print(nextWeek)
        
        // §73.9 UTC Time offset from NSDate with TimeZone
        
        // §73.10 Convert NSDate that is composed from hour and minutes (only) to a full Date
        // 時間と分だけでDateを作りたい場合がある。
        let hourAndMinute = Date()
        let calendar = Calendar.current
        let hourAndMinuteComponents = calendar.dateComponents([.hour, .minute], from: hourAndMinute)
        print(hourAndMinuteComponents)
    }


}

