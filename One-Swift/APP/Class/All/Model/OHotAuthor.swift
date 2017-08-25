//
//  OHotAuthor.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/15.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import ObjectMapper

class OHotAuthor: Mappable {
    required init?(map: Map) {
        
    }
    
    var user_id: String = ""
    var user_name: String = ""
    var desc: String = ""
    var wb_name: String = ""
    var is_settled: String = ""
    var settled_type: String = ""
    var summary: String = ""
    var fans_total: String = ""
    var web_url: URL?
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        user_name <- map["user_name"]
        desc <- map["desc"]
        wb_name <- map["wb_name"]
        is_settled <- map["is_settled"]
        settled_type <- map["settled_type"]
        summary <- map["summary"]
        fans_total <- map["fans_total"]
        web_url <- (map["web_url"], transfromOfURLAndString())
        
    }
}
