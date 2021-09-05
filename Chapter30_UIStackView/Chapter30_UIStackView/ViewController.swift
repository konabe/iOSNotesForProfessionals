//
//  ViewController.swift
//  Chapter30_UIStackView
//
//  Created by 小鍋涼太 on 2021/09/05.
//

import UIKit

// Chapter30: UIStackView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §30.1 Center Buttons with UIStackView
        // UIStackViewを使って、複数のパーツを中心に寄せる。
        
        // §30.2 Create a horizontal stack view programmatically
        // §30.3 Create a vertical stack view programmatically
        let stackView = UIStackView(frame: CGRect(x: 20, y: 10, width: 200, height: 200))
//        stackView.axis = .horizontal
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layer.borderWidth = 1
        
        let label1 = UILabel()
        label1.text = "Text1"
        label1.textAlignment = .center
        let label2 = UILabel()
        label2.text = "Text2"
        label2.textAlignment = .center
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(label2)
        view.addSubview(stackView)
    }


}

