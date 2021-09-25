//
//  Keyboard.swift
//  Chapter64_ManagingTheKeyboard
//
//  Created by 小鍋涼太 on 2021/09/26.
//

import UIKit

protocol KeyboardDelegate: AnyObject {
    func keyWasTapped(character: String)
}

class Keyboard: UIView {
    
    weak var delegate: KeyboardDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let view = Bundle.main.loadNibNamed("Keyboard", owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
    
    @IBAction func keyTapped(_ sender: UIButton) {
        self.delegate?.keyWasTapped(character: sender.titleLabel!.text!)
    }
}
