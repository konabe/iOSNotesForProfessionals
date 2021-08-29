//
//  CustomTableViewCell.swift
//  Chapter14_UITableView
//
//  Created by 小鍋涼太 on 2021/08/29.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static var identifier: String {
        return "CustomTableViewCell"
    }
    
    var customLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        customLabel = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        customLabel.textAlignment = .center
        contentView.backgroundColor = .purple.withAlphaComponent(0.1)
        contentView.addSubview(customLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
