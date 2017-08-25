//
//  OQuestionCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/16.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OQuestionCell: UITableViewCell {

    fileprivate var collectionView: UICollectionView!
    var datas: [OAllCommonModel] = [] {
        didSet {
            collectionView.reloadData()
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
        
        let nameLabel = UILabel().then {
            $0.text = "所有人问所有人"
            $0.textColor = kRGBA(115, g: 115, b: 155, a: 1)
            $0.textAlignment = .left
            $0.font = FONT12
        }
        bgView.addSubview(nameLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = kMargin / 2.0
        layout.itemSize = CGSize(width: kScreenWidth * 0.55, height: 110)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OQuestionCollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
        bgView.addSubview(collectionView)
        
        
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
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(bgView)
            make.top.equalTo(nameLabel.snp.bottom)
            make.height.equalTo(110)
        }
    }
}

extension OQuestionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as? OQuestionCollectionViewCell
        cell?.model = datas[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 100)
    }
}
