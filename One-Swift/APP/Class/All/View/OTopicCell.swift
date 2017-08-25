//
//  OTopicCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/16.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OTopicCell: UITableViewCell {

    fileprivate var icon: UIImageView!
    fileprivate var titleLabel: UILabel!
    var model: OAllCommonModel? {
        didSet {
            guard let model = model else {
                return
            }
            icon.kf.setImage(with: model.cover, placeholder: UIImage(named:"center_diary_placeholder"))
            titleLabel.text = model.title
//            titleLabel.sizeToFit()
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
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configUI() {
        self.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
        self.contentView.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
        self.selectionStyle = .none
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        self.contentView.addSubview(bgView)
        
        icon = UIImageView().then {
            $0.contentMode = .scaleToFill
        }
        bgView.addSubview(icon)
        
        titleLabel = UILabel().then {
            $0.textColor = kRGBA(14, g: 14, b: 14, a: 1)
            $0.numberOfLines = 0
            $0.font = FONT14
            $0.textAlignment = .left
        }
        bgView.addSubview(titleLabel)
        
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.top.equalTo(self.contentView.snp.top).offset(kMargin)
        }
        
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(kMargin * 1.5)
            make.top.equalTo(bgView.snp.top).offset(kMargin * 1.5)
            make.right.equalTo(bgView.snp.right).offset(-kMargin * 1.5)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(icon)
            make.top.equalTo(icon.snp.bottom).offset(kMargin * 2)
            make.bottom.equalTo(-kMargin * 2)
        }
    }
}
