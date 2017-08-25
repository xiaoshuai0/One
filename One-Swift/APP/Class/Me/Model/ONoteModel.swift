//
//  ONoteModel.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/14.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import ObjectMapper

class ONoteModel: Mappable {
    required /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    init?(map: Map) {
        
    }
    
    init() {
        
    }

    var content: String = ""
    var picture: URL?
    var cropped_picture: URL?
    var input_date: Date?
    var feed: Feeds?
    
    
    func mapping(map: Map) {
        content <- map["content"]
        picture <- (map["picture"], transfromOfURLAndString())
        cropped_picture <- (map["cropped_picture"], transfromOfURLAndString())
        input_date <- (map["input_date"], transfromOfDateAndString())
        feed <- map["feeds_data"]
    }
}

class Feeds: Mappable {
    
    required init?(map: Map) {
        
    }
    var title: String = ""
    var forward: String = ""
    var img_url: URL?
    var pic_info: String = ""
    var word_info: String = ""
    var share_url: URL?
    var weather: Weather?
    
    func mapping(map: Map) {
        title <- map["title"]
        forward <- map["forward"]
        img_url <- (map["img_url"], transfromOfURLAndString())
        pic_info <- map["pic_info"]
        word_info <- map["words_info"]
        share_url <- map["share_url"]
        weather <- map["weather"]
    }
}


class Weather: Mappable {
    required init?(map: Map) {
        
    }
    var city_name: String = ""
    var date: String = ""
    var temperature: String = ""
    var humidity: String = ""
    var climate: String = ""
    var wind_rirection: String = ""
    var hurricane: String = ""
    var icons: [String: String]?
    
    func mapping(map: Map) {
        city_name <- map["city_name"]
        date <- map["date"]
        temperature <- map["temperature"]
        humidity <- map["humidity"]
        climate <- map["climate"]
        wind_rirection <- map["wind_direction"]
        hurricane <- map["hurricane"]
        icons <- map["icons"]
    }
}












////将"yyyy-MM-dd"格式的string转成date
//func transfromOfDateString() -> TransformOf<String , String>{
//    return TransformOf<String , String>.init(fromJSON: { (JSONString) -> String? in
//        if let str = JSONString{
//            return NSDate(fromStringOrNumber:(str as AnyObject)).standardChinaTimeDescription()
//        }
//        return nil
//    }, toJSON: { (date) -> String? in
//        if let date = date{
//            return date
//        }
//        return nil
//    })
//}

////将"yyyy-MM-dd"格式的string转成date
//func transfromOfDateStringCustom() -> TransformOf<String , String>{
//    return TransformOf<String , String>.init(fromJSON: { (JSONString) -> String? in
//        if let str = JSONString{
//            return NSDate(fromStringOrNumber:(str as AnyObject)).customTimeDescription()
//        }
//        return nil
//    }, toJSON: { (date) -> String? in
//        if let date = date{
//            return date
//        }
//        return nil
//    })
//}
//
//将"yyyy-MM-dd"格式的string转成date
func transfromOfDateAndString() -> TransformOf<Date , String>{
    return TransformOf<Date , String>.init(fromJSON: { (JSONString) -> Date? in
        if let str = JSONString{
//            return DateFormatter.default().date(from: str)!
            
            return DateFormatter.defaultDateFormatter().date(from: str)
        }
        return nil
    }, toJSON: { (date) -> String? in
        if let date = date{
            return DateFormatter.defaultDateFormatter().string(from: date as Date)
        }
        return nil
    })
}

//将str转成url
func transfromOfURLAndString() -> TransformOf<URL, String>{
    return TransformOf<URL, String>.init(fromJSON: { (JSONString) -> URL? in
        if let str = JSONString{
            return URL.init(string: str)
        }
        return nil
    }, toJSON: { (url) -> String? in
        if let url = url {
            return url.absoluteString
        }
        return nil
    })
}
