//
//  ViewController.swift
//  Chapter63_PassingDataBetweenViewControllers
//
//  Created by 小鍋涼太 on 2021/09/25.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §63.1 Using the Delegate Pattern
        // §63.2 Using Segues ( passing data forward )
        // §63.3 Passing data backwards using unwind to segue
        // TODO: 面倒なのでここでは試してない。DelegateがClosureに変わっただけ
        // §63.4 Passing data using closures ( passing data back )
        // §63.5 Using callback closure passing data back
        // §63.6 By assigning property ( passing data forward )
        
    }
    
    func showDetail() {
        performSegue(withIdentifier: "showSecondViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondViewController", let secondVC = segue.destination as? SecondViewController {
            secondVC.delegate = self
            secondVC.initialString = "test"
        }
    }
    
    @IBAction func unwindToPresentingViewController(segue: UIStoryboardSegue) {
        if segue.identifier == "unwindSecondViewController" {
            if let vc2 = segue.source as? SecondViewController {
                label.text = (label.text ?? "") + " " + vc2.passedData
            }
        }
    }


}
protocol DataEnteredDelegate: AnyObject {
    func userDidEnterInformation(info: String)
}

extension FirstViewController: DataEnteredDelegate {
    func userDidEnterInformation(info: String) {
//        label.text = info
        navigationController?.popViewController(animated: true)
    }
}

class SecondViewController: UIViewController {
    weak var delegate: DataEnteredDelegate?
    @IBOutlet weak var textfield: UITextField!
    var initialString: String?
    var passedData = "passed"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.text = initialString ?? ""
    }
    
    @IBAction func sendTextBackButton(_ sender: Any) {
        delegate?.userDidEnterInformation(info: textfield.text ?? "")
    }
    
}
