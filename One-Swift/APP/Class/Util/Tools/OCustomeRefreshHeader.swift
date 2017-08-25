//
//  OCustomeRefreshHeader.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/17.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import MJRefresh

class OCustomeRefreshHeader: MJRefreshNormalHeader {

    override func prepare() {
        super.prepare()
        self.lastUpdatedTimeLabel.isHidden = true
        self.setTitle("下拉可以刷新", for: .willRefresh)
        self.setTitle("松开立即刷新", for: .pulling)
        self.setTitle("正在刷新数据中...", for: .refreshing)
        self.setTitle("下拉可以刷新", for: .idle)
    }

}

class OCustomeRefreshFooter: MJRefreshAutoNormalFooter {
    override func prepare() {
        super.prepare()
        self.setTitle("上拉可以加载更多", for: .idle)
        self.setTitle("上拉可以加载更多", for: .willRefresh)
        self.setTitle("松开立即加载更多更多", for: .pulling)
        self.setTitle("正在加载更多数据", for: .refreshing)
        self.setTitle("已经全部加载完毕", for: .noMoreData)
    }
}
