//
//  OMeNomalCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/14.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OMeNomalCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
        self.textLabel?.textColor = kColorFromHexA(999999)
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
