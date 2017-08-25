//
//  OMeCollectionCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/14.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OMeCollectionCell: UITableViewCell {

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
        self.theme_backgroundColor = ["#fff", "#454545"]
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configUI() {
        
        let superView = self.contentView
        
        let titleLabel = UILabel().then {
            $0.text = "我的收藏"
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightThin)
            $0.sizeToFit()
        }
        superView.addSubview(titleLabel)
        
        let imageTextBtn = createButton("图文", imageName: "user_center_imagetext")
        superView.addSubview(imageTextBtn)
        
        let readBtn = createButton("文章", imageName: "user_center_read")
        superView.addSubview(readBtn)
        
        let musicBtn = createButton("音乐", imageName: "user_center_music")
        superView.addSubview(musicBtn)
        
        let filmBtn = createButton("影视", imageName: "user_center_film")
        superView.addSubview(filmBtn)
        
        let fmBtn = createButton("电台", imageName: "user_center_FM")
        superView.addSubview(fmBtn)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(superView.snp.left).offset(kMargin * 2)
            make.top.equalTo(superView.snp.top).offset(kMargin)
            make.height.equalTo(15)
        }
        
        imageTextBtn.snp.makeConstraints { (make) in
            make.left.equalTo(superView.snp.left).offset(kMargin)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(superView.snp.bottom).offset(kMargin)
            make.right.equalTo(readBtn.snp.left)
        }
        
        readBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(imageTextBtn)
            make.right.equalTo(musicBtn.snp.left)
        }
        
        musicBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(imageTextBtn)
            make.right.equalTo(filmBtn.snp.left)
        }
        
        filmBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(imageTextBtn)
            make.right.equalTo(fmBtn.snp.left)
        }
        
        fmBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(imageTextBtn)
            make.right.equalTo(superView.snp.right).offset(-kMargin)
            make.width.equalTo(filmBtn.snp.width)
            make.width.equalTo(musicBtn.snp.width)
            make.width.equalTo(readBtn.snp.width)
            make.width.equalTo(imageTextBtn.snp.width)
        }
    }
    
    private func createButton(_ title: String, imageName: String) -> UIButton {
        let button = UIButton().then {
            $0.setImage(UIImage(named: imageName), for: .normal)
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
            $0.sizeToFit()
            $0.zs_padding = kMargin
            $0.zs_buttonContentTypeStyle = .centerImageTop
            
        }
        return button
    }
}
