//
//  OArticleViewModel.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/17.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class OArticleViewModel: NSObject {

    //http://v3.wufazhuce.com:8000/api/topic/htmlcontent/7?platform=ios&sign=ebd966342a93374cfa7927a616a99265&source=banner&source_id=38&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.1
    let disposeBag = DisposeBag()
    let provider = RxMoyaProvider<ApiManager>()
    var detailDatas: Variable<OTopicDetailModel?> = Variable(nil)
    init(category: String?, id: String?, content_id: String?) {
        guard let id = id, let content_id = content_id, let category = category else {
            return
        }
        let detail = provider.request(.topicDetail(category, id, content_id)).mapModel(OTopicDetailModel.self)
        detail.bind(to: detailDatas).disposed(by: disposeBag)
    }
    
    
    
    
}
