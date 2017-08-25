//
//  MenuCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/23.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var menu: MenuItem? {
        didSet {
            guard let menu = self.menu else {
                return
            }
            switch menu.content_type {
            case "1":
                titleLabel.text = "苏更生专栏"
            case "2":
                titleLabel.text = "连载"
            case "3":
                titleLabel.text = "问答"
            case "4":
                titleLabel.text = "音乐"
            case "5":
                titleLabel.text = "影视"
            case "8":
                titleLabel.text = "电台"
            default:
                titleLabel.text = "ONE STORY"
            }
            descLabel.text = menu.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
