//
//  OAuthorServices.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/24.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import ObjectMapper

class OAttentionService {
    
    var authors: [OHotAuthor] = []
    var lastId: Int = 0
    func loadAuthors(completed: @escaping (_ error: DataError)-> Void) {
        let url = "http://v3.wufazhuce.com:8000/api/user/follow_list?last_id=\(lastId)&platform=ios&sign=3d57d5cee753f029e1dc0036cb678db7&uid=8225952&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.2"
        
        NetworkUtil.shared.getForJSON(url: url, paramters: nil) { [weak self](json, error) in
            kLog(json)
            guard let strong = self else { return }
            guard let json = json?.dictionaryObject, let data = json["data"] as? [[String: Any]], data.count > 0 else {
                completed(.jsonError)
                return
            }
            
            let temp = Mapper<OHotAuthor>().mapArray(JSONArray: data)
            kLog(temp.count)
            if strong.lastId == 0 {
                strong.authors = temp
            } else {
                strong.authors.append(contentsOf: temp)
            }
            if let last_id = json["last_id"] as? Int, last_id == -1 {
                completed(.noMoreData)
            } else {
                completed(.none)
            }
        }
    }
}


class AuthorService {
    /// 获取作者的文章详情
    ///
    /// - Parameters:
    ///   - page_num: 页数
    ///   - completed: 完成的回调
    var page_num: Int = 0
    var author_id:String = ""
    var ariticles: [OHomeItemModel] = []
    init(author_id: String) {
        self.author_id = author_id
    }
    
    func loadAuthorArticle(completed: @escaping (_ error: DataError)-> Void) {
        //作者文章
        //http://v3.wufazhuce.com:8000/api/author/works?author_id=4813510&page_num=1&platform=ios&sign=dd993d78126d09f097594e8b78c04c01&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.2
        
        let url = "http://v3.wufazhuce.com:8000/api/author/works?author_id=\(author_id)&page_num=\(page_num)&platform=ios&sign=dd993d78126d09f097594e8b78c04c01&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.2"
        
        NetworkUtil.shared.getForJSON(url: url, paramters: nil) {(json, error) in
            kLog(json)
            guard let json = json?.dictionaryObject, let data = json["data"] as? [[String: Any]], data.count > 0 else {
                completed(.jsonError)
                return
            }
            let temp = Mapper<OHomeItemModel>().mapArray(JSONArray: data)
            if self.page_num == 0 {
                self.ariticles = temp
            } else {
                self.ariticles.append(contentsOf: temp)
            }
            self.page_num += 1
            if temp.count == 0{
                completed(.noMoreData)
            } else {
                completed(.none)
            }
            
        }
    }
}
