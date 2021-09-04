//
//  ViewController.swift
//  Chapter26_UINavigationController
//
//  Created by 小鍋涼太 on 2021/09/04.
//

import UIKit

// §26.3 Purpose
// UINavigationControllerはViewControllerの木構造の階層を構成(navigation stack)するために使われる。

// §26.5 Creating a NavigationController
// ストーリーボードで設定できる。

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // §26.1 Embed a view controller in a navigation controller programmatically
        let vc = SecondViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: false, completion: nil)
    }

}

// §26.1
class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        title = "SecondViewController"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // §26.4 Pushing a view controller onto the navigation stack
        navigationController?.pushViewController(ThirdViewController(), animated: true)
    }
}

// §26.1
class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        title = "ThirdViewController"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.pushViewController(ForthViewController(), animated: true)
    }
}

// §26.2
class ForthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        title = "ForthViewController"
        
        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 20))
        btn.setTitle("popViewController", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.addAction(.init{ _ in
            // §26.2 Popping in a Navigation Controller
            self.navigationController?.popViewController(animated: true)
        }, for: .touchUpInside)
        view.addSubview(btn)
        
        let btn2 = UIButton(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 20))
        btn2.setTitle("popToRootViewController", for: .normal)
        btn2.setTitleColor(.black, for: .normal)
        btn2.backgroundColor = .white
        btn2.addAction(.init{ _ in
            // §26.2 Popping in a Navigation Controller
            self.navigationController?.popToRootViewController(animated: true)
        }, for: .touchUpInside)
        view.addSubview(btn2)
        
    }
}
