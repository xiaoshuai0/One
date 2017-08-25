//
//  ToModelExtension.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import Moya
import HandyJSON
import SwiftyJSON
import ObjectMapper

extension ObservableType where E == Response {
    public func mapModelArray<T : Mappable>(_ type: T.Type) -> Observable<[T]> {
        
        return flatMap({ response -> Observable<[T]> in
            
            return Observable.just(response.mapModelArray(T.self))
        })
    }
    public func mapModel<T : Mappable>(_ type: T.Type) -> Observable<T> {
        
        return flatMap({ response -> Observable<T> in
            
            return Observable.just(response.mapModel(T.self))
        })
    }
}

extension Response {
    func mapModelArray<T: Mappable>(_ type: T.Type) -> [T] {
        
        guard let result = JSON(data).dictionaryObject, let array = result["data"] as? [[String: Any]] else {
            return []
        }
        let modelArr = Mapper<T>().mapArray(JSONArray: array)
        return modelArr
    }
    
    func mapModel<T: Mappable>(_ type: T.Type) -> T {
        
        guard let result = JSON(data).dictionaryObject, let dict = result["data"] as? [String: Any] else {
            fatalError()
        }
        let model = Mapper<T>().map(JSON: dict)
        return model!
    }
    
}

