//
//  ViewController.swift
//  Chapter83_NSPredicate
//
//  Created by 小鍋涼太 on 2021/10/09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §83.1 Form validation using NSPredicate
        let mobileNumberRegEx = "^[0-9]{10}$"
        // §83.3 Creating an NSPredicate Using predicateWithFormat
        // formatを使って、どういう条件でマッチさせるか決められる。
        // 動的に変えたい場合は%を使って引数で与える。
        // https://qiita.com/yusuga/items/8fd531ebd8f5e72bb97b
        let mobileNumberPredicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegEx)
        print(mobileNumberPredicate.predicateFormat)
        if mobileNumberPredicate.evaluate(with: "123a567890") {
            print("OK")
        } else {
            print("NG")
        }
        
        // §83.2 Creating an NSPredicate Using predicateWithBlock
        let predicate = NSPredicate { (item, bindings) -> Bool in
            return item is UILabel
        }
        print(predicate.evaluate(with: UILabel()) ? "OK" : "NG")
        
        // §83.4 Creating an NSPredicate with Substitution Variables
        // あとから置き換えることができるよという意味。
        let template = NSPredicate(format: "self BEGINSWITH $letter")
        let variables = ["letter": "r"]
        let beginsWithR = template.withSubstitutionVariables(variables)
        print(beginsWithR.evaluate(with: "regular") ? "OK" : "NG")
        
        // §83.5 NSPredicate with `AND`, `OR` and `NOT` condition
        let combinedPredicate = NSCompoundPredicate(notPredicateWithSubpredicate: beginsWithR)
        print(combinedPredicate.evaluate(with: "regular") ? "OK" : "NG")
        
        // §83.6 Using NSPredicate to Filter an Array
        let heroes = ["tracer", "bastion", "reaper", "junkrat", "roadhog"]
        let template2 = NSPredicate(format: "self BEGINSWITH $letter2")
        let beginsWithRVariables = ["letter2": "r"]
        let beginsWithR2 = template2.withSubstitutionVariables(beginsWithRVariables)
        let beginsWithRHeroes = heroes.filter{ beginsWithR2.evaluate(with:$0) }
        print(beginsWithRHeroes)
    }


}

