//
//  OTopicDetailModel.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/17.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import ObjectMapper

class OTopicDetailModel: Mappable {
    var category: Int?
    var id: String = ""
    var title: String = ""
    var web_url: URL?
    var share_list: ShareList?
    var html_content: String = ""
    var enable_comment: Bool = true
    var bg_color: String = ""
    var font_color: String = ""
    var praisenum: Int?
    var commentnum: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        category <- map["category"]
        id <- map["id"]
        title <- map["title"]
        web_url <- map["web_url"]
        share_list <- map["share_list"]
        html_content <- map["html_content"]
        enable_comment <- map["enable_comment"]
        bg_color <- map["bg_color"]
        font_color <- map["font_color"]
        praisenum <- map["praisenum"]
        commentnum <- map["commentnum"]
    }
}


class ShareList: Mappable {
    
    var wx: Share?
    var wx_timeline: Share?
    var weibo: Share?
    var qq: Share?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        wx <- map["wx"]
        wx_timeline <- map["wx_timeline"]
        weibo <- map["weibo"]
        qq <- map["qq"]
    }
}

class Share: Mappable {
    var title: String = ""
    var desc: String = ""
    var link: URL?
    var imgUrl: URL?
    var audio:String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        desc <- map["desc"]
        link <- (map["link"], transfromOfURLAndString())
        imgUrl <- (map["imgUrl"], transfromOfURLAndString())
        audio <- map["audio"]
    }
}
