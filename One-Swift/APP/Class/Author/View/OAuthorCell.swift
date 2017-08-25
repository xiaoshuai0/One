//
//  OAuthorCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/16.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OAuthorCell: UITableViewCell {

    fileprivate var avatar: UIImageView!
    fileprivate var authorName: UILabel!
    fileprivate var desc: UILabel!
    var attentionBtn: UIButton!
    
    var author: OHotAuthor? {
        didSet {
            avatar.kf.setImage(with: author?.web_url, placeholder: UIImage(named: "userDefault")) { [weak self](image, error, cache, url) in
                self?.avatar.image = image?.zs_circleImage()
            }
            authorName.text = author?.user_name
            desc.text = author?.desc
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
        configUI()
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configUI() {
        avatar = UIImageView().then {
            $0.contentMode = .scaleToFill
        }
        self.contentView.addSubview(avatar)
        
        authorName = UILabel().then {
            $0.textColor = kRGBA(115, g: 115, b: 155, a: 1)
            $0.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
            $0.textAlignment = .left
        }
        self.contentView.addSubview(authorName)
        
        desc = UILabel().then {
            $0.textColor = kColorFromHexA(999999)
            $0.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightThin)
            $0.textAlignment = .left
        }
        self.contentView.addSubview(desc)
        
        attentionBtn = UIButton().then {
            $0.setTitle("关注", for: .normal)
            $0.setTitleColor(kRGBA(206, g: 206, b: 206, a: 1), for: .normal)
            $0.borderColor = kRGBA(173, g: 173, b: 173, a: 1)
            $0.borderWidth = 0.5
            $0.cornerRadius = 1
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightThin)
        }
        self.contentView.addSubview(attentionBtn)
        avatar.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(kMargin)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
        
        authorName.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(kMargin)
            make.top.equalTo(avatar.snp.top)
            make.height.equalTo(avatar.snp.height).dividedBy(2)
        }
        desc.snp.makeConstraints { (make) in
            make.left.right.equalTo(authorName)
            make.top.equalTo(authorName.snp.bottom)
            make.bottom.equalTo(avatar.snp.bottom)
        }
        attentionBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-kMargin)
            make.top.equalTo(avatar.snp.top).offset(kMargin / 2.0)
            make.bottom.equalTo(avatar.snp.bottom).offset(-kMargin / 2.0)
            make.width.equalTo(50)
            make.left.equalTo(authorName.snp.right).offset(kMargin)
        }
        
    }
}
