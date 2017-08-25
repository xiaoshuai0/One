//
//  OBannerModel.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/15.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import ObjectMapper

class OAllCommonModel: Mappable {
    required init?(map: Map) {
        
    }
    var id: Int = 0
    var cover: URL?
    var title: String = "" {
        didSet {
            topicHeight = title.getSize(attribute: nil, font: FONT14, maxSize: CGSize(width: kScreenWidth - kMargin * 10, height: 1000)).height
        }
    }
    var category: Int = 0
    var content_id: String = ""
    var is_stick: Bool = false
    var link_url: URL?
    
    var topicHeight: CGFloat = 0
    
    func mapping(map: Map) {
        id <- map["id"]
        cover <- (map["cover"], transfromOfURLAndString())
        title <- map["title"]
        category <- map["category"]
        content_id <- map["content_id"]
        is_stick <- map["is_stick"]
        link_url <- (map["link_url"], transfromOfURLAndString())
    }
}
