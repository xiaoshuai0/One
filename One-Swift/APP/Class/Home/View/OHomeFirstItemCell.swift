//
//  OHomeFirstItemCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/23.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OHomeFirstItemCell: UITableViewCell {

    fileprivate var icon: UIImageView!
    fileprivate var authorLabel: UILabel!
    fileprivate var descLabel: UILabel!
    fileprivate var titleLabel: UILabel!
    fileprivate var noteBtn: UIButton!
    fileprivate var likeBtn: UIButton!
    fileprivate var collectionBtn: UIButton!
    fileprivate var shareBtn: UIButton!
    
    var model: OHomeItemModel? {
        didSet {
            guard let model = self.model else {
                return
            }
            icon.kf.setImage(with: model.img_url)
            authorLabel.text = "\(model.title) | \(model.pic_info)"
            descLabel.text = model.forward
            titleLabel.text = model.words_info
            likeBtn.setTitle("\(model.like_count)", for: .normal)
            descLabel.snp.updateConstraints { (make) in
                make.height.equalTo(model.firstDescHeight)
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
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        
        self.selectionStyle = .none
        let superView = self.contentView
        
        icon = UIImageView().then {
            $0.contentMode = .scaleToFill
        }
        contentView.addSubview(icon)
        
        authorLabel = UILabel.createLabel(.zero, font: FONT12, textColor: kRGBA(214, g: 214, b: 214, a: 1), textAlignment: .center, text: "")
        superView.addSubview(authorLabel)
        
        descLabel = UILabel.createLabel(.zero, font: FONT12, textColor: UIColor.black, textAlignment: .left, text: "")
        descLabel.numberOfLines = 0
        superView.addSubview(descLabel)
        
        titleLabel = UILabel.createLabel(.zero, font: FONT12, textColor: kRGBA(214, g: 214, b: 214, a: 1), textAlignment: .center, text: "")
        superView.addSubview(titleLabel)
        
        noteBtn = UIButton(type: .custom).then {
            $0.setImage(UIImage(named: "note_gray_mini"), for: .normal)
            $0.setTitle("小记", for: .normal)
            $0.setTitleColor(kRGBA(214, g: 214, b: 214, a: 1), for: .normal)
            $0.titleLabel?.font = FONT10
            $0.sizeToFit()
        }
        superView.addSubview(noteBtn)
        
        likeBtn = UIButton(type: .custom).then {
            $0.setImage(UIImage(named: "like_dark"), for: .normal)
            $0.titleEdgeInsets = UIEdgeInsets(top: -kMargin, left: 0, bottom: kMargin, right: 0)
            $0.setTitle("11812", for: .normal)
            $0.titleLabel?.font = FONT10
            $0.setTitleColor(kRGBA(171, g: 171, b: 171, a: 1), for: .normal)
            $0.sizeToFit()
        }
        superView.addSubview(likeBtn)
        
        collectionBtn = UIButton().then {
            $0.setImage(UIImage(named: "collect_gray_mini"), for: .normal)
            $0.sizeToFit()
        }
        superView.addSubview(collectionBtn)
        
        shareBtn = UIButton(type: .custom).then {
            $0.setImage(UIImage(named: "share_dark"), for: .normal)
            $0.sizeToFit()
        }
        superView.addSubview(shareBtn)
        
        icon.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(superView)
            make.height.equalTo(400)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(icon)
            make.top.equalTo(icon.snp.bottom).offset(kMargin)
            make.height.equalTo(15)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(superView.snp.left).offset(kMargin * 4)
            make.right.equalTo(superView.snp.right).offset(-kMargin * 4)
            make.top.equalTo(authorLabel.snp.bottom).offset(kMargin * 2)
            make.height.equalTo(0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(descLabel)
            make.top.equalTo(descLabel.snp.bottom).offset(kMargin * 2)
            make.height.equalTo(15)
        }
        
        noteBtn.snp.makeConstraints { (make) in
            make.left.equalTo(superView.snp.left).offset(kMargin * 2)
            make.bottom.equalTo(superView.snp.bottom).offset(-kMargin)
        }
        
        likeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(noteBtn.snp.centerY)
            make.right.equalTo(collectionBtn.snp.left).offset(-kMargin)
        }
        
        collectionBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(noteBtn.snp.centerY)
            make.right.equalTo(shareBtn.snp.left).offset(-kMargin * 2)
        }
        
        shareBtn.snp.makeConstraints { (make) in
            make.right.equalTo(superView.snp.right).offset(-kMargin * 2)
            make.centerY.equalTo(noteBtn.snp.centerY)
        }
    }
}
