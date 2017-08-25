//
//  OHomeItemModel.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/22.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import ObjectMapper

class OHomeItemModel: Mappable {

    var audio_platform: Int = 0
    var audio_url: URL?
    var author: OHotAuthor?
    //0: 顶部cell     1:故事        2:连载        3:问答        4:音乐        5: 影视       8影视
    var category: String = ""
    var content_bgcolor: String = ""
    var content_id: String = ""
    var display_category: Int = 0
    var forward: String = ""
    var has_reading: Bool?
    var id: String = ""
    var img_url: URL?
    var item_id: String = ""
    var last_update_date: Date?
    var like_count: Int = 0
    var movie_story_id: Int = 0
    var number: Int = 0
    var pic_info: String = ""
    var post_date: Date?
    var serial_id: Int = 0
    var share_list: ShareList?
    var title: String = ""
    var video_url: URL?
    var volume: Int = 0
    var words_info: String = ""
    
    var titleHeight: CGFloat {
        get{
            let height = title.getSize(attribute: nil, font: UIFont.systemFont(ofSize: 20, weight: UIFontWeightThin), maxSize: CGSize(width: kScreenWidth - kMargin * 4, height: 1000)).height
            return height
        }
    }
    
    var descHeight: CGFloat {
        get {
            let height = forward.getSize(attribute: nil, font: FONT14, maxSize: CGSize(width: kScreenWidth - kMargin * 4, height: 1000)).height
            kLog("\(forward)------------\(height)")
            return height
        }
    }
    
    var firstDescHeight: CGFloat {
        get {
            let height = forward.getSize(attribute: nil, font: FONT12, maxSize: CGSize(width: kScreenWidth - kMargin * 8, height: 1000)).height
            return height
        }
    }
    var height: CGFloat {
        get {
            return titleHeight + descHeight + kMargin + 15 + kMargin + kMargin + 15 + (kScreenWidth - kMargin * 4) / 2.0 + kMargin + kMargin * 5 + 15
        }
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        audio_platform <- map["audio_platform"]
        audio_url <- (map["audio_url"], transfromOfURLAndString())
        author <- map["author"]
        category <- map["category"]
        content_bgcolor <- map["content_bgcolor"]
        content_id <- map["content_id"]
        display_category <- map["display_category"]
        forward <- map["forward"]
        has_reading <- map["has_reading"]
        id <- map["id"]
        img_url <- (map["img_url"], transfromOfURLAndString())
        item_id <- map["item_id"]
        last_update_date <- (map["last_update_date"], transfromOfDateAndString())
        like_count <- map["like_count"]
        movie_story_id <- map["movie_story_id"]
        number <- map["number"]
        pic_info <- map["pic_info"]
        post_date <- (map["post_date"], transfromOfDateAndString())
        serial_id <- map["serial_id"]
        share_list <- map["share_list"]
        title <- map["title"]
        video_url <- map["video_url"]
        volume <- map["volume"]
        words_info <- map["words_info"]
    }
}


class Menu: Mappable {
    var list: [MenuItem]?
    var vol: String = ""
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        list <- map["list"]
        vol <- map["vol"]
    }
}

class MenuItem: Mappable {
    var content_id: String = ""
    var content_type: String = ""
    var title: String = ""
    var tag: Tag?
    var serial_list: [String]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        content_id <- map["content_id"]
        content_type <- map["content_type"]
        title <- map["title"]
        tag <- map["tag"]
        serial_list <- map["serial_list"]
    }
}

class Tag: Mappable {
    var id: String = ""
    var title: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
    }
}
