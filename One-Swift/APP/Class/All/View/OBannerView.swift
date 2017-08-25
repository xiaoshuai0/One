//
//  OBannerView.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/16.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import FSPagerView

class OBannerView: UIView {

    typealias ActionBlock = (OAllCommonModel) -> Void
    fileprivate var pagerView: FSPagerView!
    fileprivate var pageControl: FSPageControl!
    var selectedItem: ActionBlock?
    
    var datas: [OAllCommonModel] = []{
        didSet {
            pagerView.reloadData()
            pageControl.numberOfPages = datas.count
            pageControl.currentPage = 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        pagerView = FSPagerView(frame: self.bounds)
        pagerView.interitemSpacing = 0.0
        pagerView.itemSize = pagerView.bounds.size
        pagerView.automaticSlidingInterval = 4.0
        pagerView.isInfinite = true
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.scrollDirection = .horizontal
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(pagerView)
        
        pageControl = FSPageControl(frame: CGRect.init(x: 0, y: 0, width: pagerView.zs_width, height: 25))
        pageControl.contentHorizontalAlignment = .right
        pageControl.contentInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        pageControl.setFillColor(UIColor.white, for: .selected)
        pageControl.setFillColor(UIColor.clear, for: .normal)
        pageControl.setStrokeColor(UIColor.white, for: .normal)
        pageControl.itemSpacing = kMargin / 2.0
        self.addSubview(pageControl)
    }

}

extension OBannerView: FSPagerViewDelegate, FSPagerViewDataSource {
    /// Asks your data source object for the number of items in the pager view.
    @objc(numberOfItemsInPagerView:) func numberOfItems(in pagerView: FSPagerView) -> Int {
        return datas.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let model = datas[index]
        cell.imageView?.kf.setImage(with: model.cover, placeholder: UIImage(named:"center_diary_placeholder"))
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if selectedItem != nil {
            self.selectedItem!(datas[index])
        }
    }
}
