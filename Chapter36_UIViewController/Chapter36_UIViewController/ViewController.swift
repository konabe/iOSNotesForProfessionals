//
//  ViewController.swift
//  Chapter36_UIViewController
//
//  Created by 小鍋涼太 on 2021/09/10.
//

import UIKit

// Chapter36 UIViewController

// §36.1 Subclassing
// Gesture Recognizerでも同じことが達成できる
//
class ViewController: UIViewController {
    
    @IBOutlet weak var myCustomControl: MyCustomControl!
    @IBOutlet weak var trackingBeganLablel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    
    var viewProgramatically = false
    
    // §36.3 Set the view programatically
    override func loadView() {
        if viewProgramatically {
            let uiView = UIView()
            uiView.backgroundColor = .gray
            view = uiView
        } else {
            super.loadView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myCustomControl?.delegate = self
        
        // §36.2 Access the container view controller
        _ = tabBarController
        _ = navigationController
        
        // §36.4 Instantiate from a Storyboard
        
        // §36.5 Create an instance
        _ = UIViewController()
        
        // §36.5 Adding/removing a child view controller
        let vc2 = UIViewController()
        addChild(vc2)
        print(children)
        vc2.removeFromParent()
        print(children)
        
    }
    
    // §36.4
    @IBAction func instantiateTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Sub", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func identifierTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Sub", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "identifier")
        present(vc, animated: true, completion: nil)
    }
    
}

extension ViewController: ViewControllerCommunicationDelegate {
    func myTrackingBegan() {
        trackingBeganLablel.text = "Tracking began"
    }
    
    func myTrackingContinuing(location: CGPoint) {
        xLabel.text = "x: \(location.x)"
        yLabel.text = "y: \(location.y)"
    }
    
    func myTrackingEnded() {
        trackingBeganLablel.text = "Tracking ended"
    }
    
    
}

// UIControlのサブクラス
protocol ViewControllerCommunicationDelegate: AnyObject {
    func myTrackingBegan()
    func myTrackingContinuing(location: CGPoint)
    func myTrackingEnded()
}

class MyCustomControl: UIControl {
    weak var delegate: ViewControllerCommunicationDelegate?
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        delegate?.myTrackingBegan()
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let point = touch.location(in: self)
        delegate?.myTrackingContinuing(location: point)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        delegate?.myTrackingEnded()
    }
}

