//
//  OMeViewModel.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/14.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class OMeViewModel: NSObject {
    
    var noteModel: Driver<ONoteModel>!
    override init() {
        super.init()
        noteModel = loadNoteData()
    }
    
    fileprivate func loadNoteData() -> Driver<ONoteModel> {
        
        return Observable.create { observer in
            NetworkUtil.shared.getForJSON(url: "http://v3.wufazhuce.com:8000/api/personal/diary?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1MDI2MzM0MzEsInVzZXJpZCI6IjgyMjU5NTIifQ.vGK_97ec_iNtKVexnoSsvHzdCXTlJamh-nshUTvwtfw&platform=ios&sign=4ce6c2ab1d2eb030d1e14efbba4fbc6f&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.0", paramters: nil, finished: { (json, error) in
                
                guard let json = json?.dictionaryObject, let data = json["data"] as? [[String: Any]], data.count > 0 else {
                    observer.onCompleted()
                    return
                }
                
                let model = ONoteModel(JSON: data[0])
                observer.onNext(model!)
                observer.onCompleted()
            })
            
            return Disposables.create()
        }.asDriver(onErrorJustReturn: ONoteModel())
    }
}


