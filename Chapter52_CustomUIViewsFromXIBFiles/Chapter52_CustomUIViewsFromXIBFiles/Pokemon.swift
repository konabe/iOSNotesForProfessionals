//
//  Pokemon.swift
//  Chapter52_CustomUIViewsFromXIBFiles
//
//  Created by 小鍋涼太 on 2021/09/18.
//

import UIKit

// xibでFilesOwnerをこのクラスに指定

@IBDesignable class Pokemon: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBInspectable var image: UIImage? {
        get {
            return imageView.image
        }
        set(image) {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = viewForNibForClass()
        view.frame = bounds
        addSubview(view)
    }
    
    private func viewForNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Pokemon", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    @IBAction func didTap(_ sender: UISwitch) {
        imageView.alpha = sender.isOn ? 1.0 : 0.2
    }
    
}
