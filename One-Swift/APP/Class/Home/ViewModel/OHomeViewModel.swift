//
//  OHomeViewModel.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/7.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import SwiftyJSON
import Moya
import ObjectMapper
enum DataError {
    case none
    case noMoreData
    case jsonError
}
class OHomeViewModel {

    
    var content_list: [OHomeItemModel] = []
    var menu: Menu?
    var weather: String = ""
    var date: String = ""
    func loadNewData(_ completed: @escaping (_ error: DataError)-> Void){
        let url = "http://v3.wufazhuce.com:8000/api/channel/one/0/北京市?platform=ios&sign=96fdd1425950625d286125cab4db758a&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.0"
        
        NetworkUtil.shared.getForJSON(url: url, paramters: nil) { [weak self](json, error) in
            
            guard let result = json?.dictionaryObject, let dict = result["data"] as? [String: Any] else {
                completed(.jsonError)
                return
            }
            (result as NSDictionary).write(toFile: "/Users/zhaoshuai/Desktop/ShareSDK.plist", atomically: true)
            if let content_list = dict["content_list"] as? [[String: Any]] {
                let array = Mapper<OHomeItemModel>().mapArray(JSONArray: content_list)
                kLog(array.count)
                self?.content_list.append(contentsOf: array)
            } else {
                completed(.noMoreData)
                return
            }
            
            if let menu = dict["menu"] as? [String: Any] {
                let menuList = Menu(JSON: menu)
                kLog(menuList)
                self?.menu = menuList
            }
            
            if let weather = dict["weather"] as? [String : Any] {
                let w = Weather(JSON: weather)
                kLog(w)
                if w != nil {
                    self?.weather = "\(w!.city_name)    \(w!.climate)    \(w!.temperature)°C"
                }
                
            }
            
            if let date = dict["date"] as? String {
                let dfm = DateFormatter()
                dfm.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let time = dfm.date(from: date)
                dfm.dateFormat = "yyyy  /  MM  /  dd"
                self?.date = dfm.string(from: time!)
            }
            completed(.none)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
