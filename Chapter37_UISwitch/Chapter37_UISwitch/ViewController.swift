//
//  ViewController.swift
//  Chapter37_UISwitch
//
//  Created by 小鍋涼太 on 2021/09/10.
//

import UIKit

// Chapter37 UISwitch

class ViewController: UIViewController {

    @IBOutlet weak var sampleSwitch: UISwitch!
    @IBOutlet weak var sampleSwitchForIOS7: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §37.1 Set Image for On/Off state
        // iOS7以降はこれだと効果がない
        // https://developer.apple.com/documentation/uikit/uiswitch/1623689-onimage
        sampleSwitch.onImage = UIImage(named: "switch_on")
        sampleSwitch.offImage = UIImage(named: "switch_off")
        
        // もし同じことがしたいなら、UIButtonを使う方法がある。
        // typeはIB上でCustomにしている
        // selectedをonとして判定すれば同じように使える。
        sampleSwitchForIOS7.isSelected = true
        sampleSwitchForIOS7.setImage(UIImage(named: "switch_on"), for: .selected)
        sampleSwitchForIOS7.setImage(UIImage(named: "switch_off"), for: .normal)
        sampleSwitchForIOS7.addAction(.init { _ in
            self.sampleSwitchForIOS7.isSelected.toggle()
        }, for: .touchUpInside)
        
        // §37.3 Set Background Color
        sampleSwitch.onTintColor = .blue
        // offTintColorみたいな役割をしたいときはこうする
        sampleSwitch.tintColor = .yellow
        sampleSwitch.backgroundColor = .yellow
        sampleSwitch.layer.cornerRadius = sampleSwitch.frame.height / 2
    }
    
    // §37.2 Set On / Off
    @IBAction func didTapSwitch(_ sender: UIButton) {
        // 切り替わる前の状態なので、反転する必要がある。
        sampleSwitch.setOn(!sender.isSelected, animated: true)
    }
    

}

