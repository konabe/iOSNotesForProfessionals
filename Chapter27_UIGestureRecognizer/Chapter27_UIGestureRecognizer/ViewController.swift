//
//  ViewController.swift
//  Chapter27_UIGestureRecognizer
//
//  Created by 小鍋涼太 on 2021/09/04.
//

import UIKit

// Chapter 27: UITapGestureRecognizer

class ViewController: UIViewController {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var longView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §27.1 UITapGestureRecognizer
        // targeで初期化する
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        view.addGestureRecognizer(recognizer)
        
        // §27.2 UITapGestureRecognizer (Double Tap)
        recognizer.numberOfTapsRequired = 2
        
        // §27.3 Adding a Gesture recognizer in the Interface Builder
        // UIパーツのところにGestureがあるので、ドラッグすれば登録される。
        
        // §27.4 UILongPressGestureRecognizer
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        longPressGesture.minimumPressDuration = 1.0
        longView.addGestureRecognizer(longPressGesture)
        
        // §27.5 UISwipeGestureRecognizer
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
        swipeRightGesture.direction = .right
        swipeRightGesture.direction = .left
        view.addGestureRecognizer(swipeRightGesture)
        view.addGestureRecognizer(swipeLeftGesture)
        
        // §27.6 UIPinchGestureRecognizer
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(gesture:)))
        longView.addGestureRecognizer(pinchGesture)
        
        // §27.7 UIRotationGestureRecognizer
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(gesture:)))
        longView.addGestureRecognizer(rotateGesture)
    }
    
    // §27.1
    @objc
    private func handleTap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .recognized {
            positionLabel.text = recognizer.location(in: recognizer.view).debugDescription
        }
    }

    // §27.3
    @IBAction func redViewTapped(_ sender: Any) {
        UIView.animate(withDuration: 2.0) {
            self.redView.backgroundColor = .blue
        }
    }
    
    // §27.4
    @objc
    private func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            positionLabel.text = "ロングタップ"
        }
    }
    
    // §27.5
    @objc
    private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            positionLabel.text = "Swipe right"
        } else if gesture.direction == .left {
            positionLabel.text = "Swipe left"
        }
    }
    
    // §27.6
    @objc
    private func handlePinch(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            let transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
            longView.transform = transform
        }
    }
    
    // §27.7
    @objc
    private func handleRotate(gesture: UIRotationGestureRecognizer) {
        if gesture.state == .changed {
            let transform = CGAffineTransform(rotationAngle: gesture.rotation)
            longView.transform = transform
        }
    }
    
}

