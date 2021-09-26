//
//  ViewController.swift
//  Chapter67_AutoLayout
//
//  Created by 小鍋涼太 on 2021/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §67.1 Space Views Evenly
        // 2つのViewをセンタリングしたいときがある。
        // UILayoutGuideを使えばいい。
        // iOS9以降なら使える
        // Interface Builderでは使えないので注意。
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        let leadingSpace = UILayoutGuide()
        let trailingSpace = UILayoutGuide()
        view.addLayoutGuide(leadingSpace)
        view.addLayoutGuide(trailingSpace)
        leadingSpace.widthAnchor.constraint(equalTo: trailingSpace.widthAnchor).isActive = true
        
        leadingSpace.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leadingSpace.trailingAnchor.constraint(equalTo: button1.leadingAnchor).isActive = true
        
        trailingSpace.leadingAnchor.constraint(equalTo: button2.trailingAnchor).isActive = true
        trailingSpace.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 20).isActive = true
        
        button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button2.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // §67.2 Center Constraints
        // センタリングできるってだけで、たいした話はしてない。
        
        // §67.3 Setting constraints programmatically
        // Anchor,NSLayoutConstraint, VFLを紹介しているだけ
        
        // §67.4 UILabel & Parentview size According to Text in UILabel
        
        // §67.5 UILabel Intrinsic Size
        // UILabelのコンテンツの長さに応じてUILabelを短くしたい場合は、親ビューのWidth制約の優先度を下げて、Content hugging priorityを上げる。 resitanceも上げる。
        
        // §67.6 Visual Format Language Basics: Constratints in Code!
        // TODO: 古いのでパス
        
        // §67.7 Resolve UILabel Priority Conflict
        // UILabelを３つ以上並べたときにエラーになる。Hugging Priorityを操作すればよい。
        
        // §67.8 How to animate with Auto Layout
        // アニメーションにできること (layoutIfNeededを呼ぶ)
        // 1. 制約の定数の変更
        // 2. 制約の変更
        // 3. 制約の優先度の変更
        // 4. すべての制約を削除して、Autosizing Maskを使う
        // 5. アニメーションに干渉しない制約を使う
        // 6. ContainerViewを使う
        // 7. Layerの変更はAutoLayoutには関係ない
        // 8. layoutSubviewsをオーバーライドする。
        // 9. viewDidLayoutSubviewsでフレームを変更する。
        //    layoutSubviewsは１度だけ呼ばれる。
        // 10. AutoLayoutからオプトアウトする
        
        // §67.9 NSLayoutConstraint: Constraints in code!
        // TODO: 古いのでパス
        // §67.10 Proportional Layout
        // §67.11 Mixed usage of Auto Layout with non-Auto Layout
        // TODO:
        // §67.12 How to use Auto Layout
        
        
    }
    
    @IBAction func addTextIncreasedSizeTapped(_ sender: Any) {
        label1.font = label1.font.withSize(label1.font.pointSize + 1)
        label2.font = label2.font.withSize(label2.font.pointSize + 1)
    }
    

}

