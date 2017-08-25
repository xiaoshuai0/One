//
//  OAllCategoryCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/16.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OAllCategoryCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
        self.contentView.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
        self.selectionStyle = .none
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        self.contentView.addSubview(bgView)
        
        let nameLabel = UILabel().then {
            $0.text = "分类导航"
            $0.textColor = kRGBA(115, g: 115, b: 155, a: 1)
            $0.textAlignment = .left
            $0.font = FONT12
        }
        bgView.addSubview(nameLabel)
        
        let icon = UIImageView().then {
            $0.contentMode = .scaleToFill
            $0.kf.setImage(with: URL(string: "http://image.wufazhuce.com/alltab-toc.png?v=4.3.0.10"), placeholder: UIImage(named:"center_diary_placeholder"))
        }
        bgView.addSubview(icon)
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.top.equalTo(self.contentView.snp.top).offset(kMargin)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(kMargin * 1.5)
            make.top.equalTo(bgView.snp.top)
            make.height.equalTo(30)
            make.right.equalTo(bgView.snp.right).offset(-kMargin * 1.5)
        }
        
        icon.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom)
            make.bottom.equalTo(bgView.snp.bottom).offset(-kMargin * 2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
