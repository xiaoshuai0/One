//
//  OAuthorHeaderView.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/24.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OAuthorHeaderView: UIView {

    fileprivate var avatar: UIImageView!
    fileprivate var nameLabel: UILabel!
    fileprivate var summaryLabel: UILabel!
    fileprivate var descLabel: UILabel!
    fileprivate var attentionBtn: UIButton!
    fileprivate var countLabel: UILabel!
    fileprivate var author: OHotAuthor!
    
    init(frame: CGRect, author: OHotAuthor) {
        super.init(frame: frame)
        self.author = author
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        
        self.backgroundColor = UIColor.white
        
        avatar = UIImageView()
        avatar.frame = CGRect(x: self.zs_centerX - 35, y: kMargin * 3, width: 70, height: 70)
        avatar.kf.setImage(with: author.web_url, placeholder: UIImage(named: "authorDefault")) { (image, error, type, url) in
            self.avatar.image = image?.zs_circleImage()
        }
        self.addSubview(avatar)
        
        nameLabel = UILabel.createLabel(.zero, font: FONT15, textColor: .black, textAlignment: .center, text: author.user_name)
        nameLabel.sizeToFit()
        nameLabel.zs_x = 0
        nameLabel.zs_y = avatar.zs_bottom + kMargin
        nameLabel.zs_width = kScreenWidth
        self.addSubview(nameLabel)
        
        summaryLabel = UILabel.createLabel(.zero, font: FONT10, textColor: kRGBA(170, g: 170, b: 170, a: 1), textAlignment: .center, text: author.summary)
        summaryLabel.numberOfLines = 0
        let summaryHeight: CGFloat = author.summary.getSize(attribute: nil, font: FONT10, maxSize: CGSize(width: kScreenWidth - 8 * kMargin, height: 1000)).height
        summaryLabel.frame = CGRect(x: kMargin * 4.0, y: nameLabel.zs_bottom + kMargin, width: kScreenWidth - 8 * kMargin, height: summaryHeight)
        self.addSubview(summaryLabel)
        
        if author.desc == author.summary {
            author.desc = ""
        }
        descLabel = UILabel.createLabel(.zero, font: FONT10, textColor: .black, textAlignment: .center, text: author.desc)
        descLabel.numberOfLines = 0
        let descHeight = author.desc.getSize(attribute: nil, font: FONT10, maxSize: CGSize(width: kScreenWidth - 8 * kMargin, height: 1000)).height
        descLabel.frame = CGRect(x: summaryLabel.zs_x, y: summaryLabel.zs_bottom + kMargin / 2.0, width: summaryLabel.zs_width, height: descHeight)
        self.addSubview(descLabel)
            
        attentionBtn = UIButton(type: .custom)
        attentionBtn.cornerRadius = 5
        if author.is_settled == "1" {
            attentionBtn.setTitle("已关注", for: .normal)
            attentionBtn.backgroundColor = kRGBA(85, g: 85, b: 85, a: 1)
            attentionBtn.borderWidth = 0
            attentionBtn.setTitleColor(UIColor.white, for: .normal)
        } else {
            attentionBtn.setTitle("关注", for: .normal)
            attentionBtn.backgroundColor = UIColor.white
            attentionBtn.borderColor = kRGBA(85, g: 85, b: 85, a: 1)
            attentionBtn.borderWidth = 0.5
            attentionBtn.setTitleColor(kRGBA(85, g: 85, b: 85, a: 1), for: .normal)
        }
        attentionBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        attentionBtn.titleLabel?.font = FONT12
        attentionBtn.sizeToFit()
        attentionBtn.zs_centerX = self.zs_centerX
        attentionBtn.zs_y = descLabel.zs_bottom + kMargin
        self.addSubview(attentionBtn)
        
        countLabel = UILabel.createLabel(.zero, font: FONT10, textColor: kColorFromHexA(999999), textAlignment: .center, text: "\(author.fans_total)关注")
        countLabel.sizeToFit()
        countLabel.zs_centerX = self.zs_centerX
        countLabel.zs_y = attentionBtn.zs_bottom + kMargin
        self.addSubview(countLabel)
        
        self.zs_height = countLabel.frame.maxY + kMargin
        
    }

}
