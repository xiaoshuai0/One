//
//  OHomeItemCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/22.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OHomeItemCell: UITableViewCell {

    fileprivate var tagLabel: UILabel!
    fileprivate var titleLabel: UILabel!
    fileprivate var authorLabel: UILabel!
    fileprivate var icon: UIImageView!
    fileprivate var descLabel: UILabel!
    fileprivate var timeLabel: UILabel!
    fileprivate var likeBtn: UIButton!
    fileprivate var shareBtn: UIButton!
    
    var model: OHomeItemModel? {
        didSet {
            guard let model = self.model else {
                return
            }
            switch model.category {
            case "1":
                tagLabel.text = "- ONE STORY -"
            case "2":
                tagLabel.text = "- 连载 -"
            case "3":
                tagLabel.text = "- 问答 -"
            case "4":
                tagLabel.text = "- 音乐 -"
            case "5":
                tagLabel.text = "- 影视 -"
            case "8":
                tagLabel.text = "- 影视 -"
            default:
                tagLabel.text = "- ONE STORY -"
            }
            titleLabel.text = model.title
            authorLabel.text = "文 / \(String(describing: model.author?.user_name ?? ""))"
            icon.kf.setImage(with: model.img_url, placeholder: UIImage(named:"center_diary_placeholder"))
            descLabel.text = model.forward
            timeLabel.text = model.post_date?.dateCompare()
            likeBtn.setTitle("\(model.like_count)", for: .normal)
            
            titleLabel.snp.updateConstraints { (make) in
                make.height.equalTo(model.titleHeight)
            }
            
            descLabel.snp.updateConstraints { (make) in
                make.height.equalTo(model.descHeight)
            }
            
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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        let superView = UIView()
        superView.backgroundColor = UIColor.white
        self.contentView.addSubview(superView)
        
        superView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.top.equalTo(self.contentView.snp.top).offset(kMargin)
        }
        self.contentView.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
        tagLabel = UILabel.createLabel(.zero, font: UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin), textColor: kRGBA(214, g: 214, b: 214, a: 1), textAlignment: .center, text: "")
        tagLabel.sizeToFit()
        superView.addSubview(tagLabel)
        
        titleLabel = UILabel.createLabel(.zero, font: UIFont.systemFont(ofSize: 20, weight: UIFontWeightThin), textColor: .black, textAlignment: .left, text: "")
        titleLabel.numberOfLines = 2
        superView.addSubview(titleLabel)
        
        authorLabel = UILabel.createLabel(.zero, font: FONT12, textColor: kRGBA(214, g: 214, b: 214, a: 1), textAlignment: .left, text: "")
        authorLabel.sizeToFit()
        superView.addSubview(authorLabel)
        
        icon = UIImageView().then {
            $0.contentMode = .scaleToFill
        }
        superView.addSubview(icon)
        
        descLabel = UILabel.createLabel(.zero, font: FONT14, textColor: kRGBA(171, g: 171, b: 171, a: 1), textAlignment: .left, text: " ")
        descLabel.numberOfLines = 0
        descLabel.sizeToFit()
        superView.addSubview(descLabel)
        
        timeLabel = UILabel.createLabel(.zero, font: FONT12, textColor: kRGBA(171, g: 171, b: 171, a: 1), textAlignment: .left, text: "今天")
        timeLabel.sizeToFit()
        superView.addSubview(timeLabel)
        
        likeBtn = UIButton(type: .custom).then {
            $0.setImage(UIImage(named: "like_dark"), for: .normal)
            $0.titleEdgeInsets = UIEdgeInsets(top: -kMargin, left: 0, bottom: kMargin, right: 0)
            $0.setTitle("11812", for: .normal)
            $0.titleLabel?.font = FONT10
            $0.setTitleColor(kRGBA(171, g: 171, b: 171, a: 1), for: .normal)
            $0.sizeToFit()
        }
        superView.addSubview(likeBtn)
        
        shareBtn = UIButton(type: .custom).then {
            $0.setImage(UIImage(named: "share_dark"), for: .normal)
            $0.sizeToFit()
        }
        superView.addSubview(shareBtn)
        
        tagLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(superView.snp.centerX)
            make.top.equalTo(superView.snp.top).offset(kMargin)
            make.width.equalTo(superView.snp.width)
            make.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(superView).offset(2.0 * kMargin)
            make.right.equalTo(superView).offset(-kMargin * 2.0)
            make.top.equalTo(tagLabel.snp.bottom).offset(kMargin)
            make.height.equalTo(50)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(kMargin)
            make.height.equalTo(15)
        }
        
        icon.snp.makeConstraints { (make) in
            make.left.right.equalTo(authorLabel)
            make.top.equalTo(authorLabel.snp.bottom).offset(kMargin)
            make.height.equalTo(icon.snp.width).dividedBy(2)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(icon)
            make.top.equalTo(icon.snp.bottom).offset(kMargin)
            make.height.equalTo(33.6)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(descLabel.snp.left)
            make.bottom.equalTo(superView.snp.bottom).offset(-kMargin)
            make.width.equalTo(superView.snp.width).dividedBy(3)
        }
        
        likeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.right.equalTo(shareBtn.snp.left).offset(-kMargin)
        }
        
        shareBtn.snp.makeConstraints { (make) in
            make.right.equalTo(descLabel.snp.right)
            make.centerY.equalTo(timeLabel.snp.centerY)
        }
    }
}
