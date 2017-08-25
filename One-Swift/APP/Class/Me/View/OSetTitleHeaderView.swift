//
//  OSetTitleHeaderView.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/15.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OSetTitleHeaderView: UITableViewHeaderFooterView {

    var titleLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = kRGBA(238, g: 236, b: 243, a: 1)
        titleLabel = UILabel().then {
            $0.textColor = UIColor.black
            $0.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
            $0.textAlignment = .left
            $0.frame = CGRect(x: kMargin, y: 20, width: kScreenWidth - kMargin * 2.0, height: 20)
        }
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
