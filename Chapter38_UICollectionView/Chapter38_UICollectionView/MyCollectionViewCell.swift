//
//  MyCollectionViewCell.swift
//  Chapter38_UICollectionView
//
//  Created by 小鍋涼太 on 2021/09/11.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
    }

}
