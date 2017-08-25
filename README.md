# One

这是一个练习Swift+RxSwift([参考资料](https://github.com/Joe0708/RxSwift-Tutorial)) 的项目, 该项目模仿"一个"APP的4.3.2版本

![项目的效果图](http://upload-images.jianshu.io/upload_images/1684666-f512c1d53abdca17.gif?imageMogr2/auto-orient/strip)

本Demo的接口使用'Charles'获取, 图片用的切图来自(itunes 下载APP),解压ipa包获取
[assets.car解压方法](http://www.jianshu.com/p/b21552301950)

![用到的三方库.png](http://upload-images.jianshu.io/upload_images/1684666-e51696c61ff86ad9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

本书的大部分网络请求时用的RxSwift+Moya+ObjectMapper将网络数据请求解析到model, 多个网络请求完成后刷新界面我用的是
<pre>
func loadNewData() {

    let author = provider.request(.hotAuthor).mapModelArray(OHotAuthor.self)
    let banner = provider.request(.allBannerUrl("0")).mapModelArray(OAllCommonModel.self)
    let question = provider.request(.allQuestionUrl("0")).mapModelArray(OAllCommonModel.self)
    let topic = provider.request(.allTopic("0")).mapModelArray(OAllCommonModel.self)


    author.bind(to: authorData).disposed(by: disposeBag)
    banner.bind(to: bannerData).disposed(by: disposeBag)
    question.bind(to: questionData).disposed(by: disposeBag)
    topic.bind(to: topicData).disposed(by: disposeBag)

    topicData.asObservable().subscribe(onNext: { [weak self](datas) in
        self?.lastTopicID = datas.last?.id
    }).addDisposableTo(disposeBag)

    Observable.zip(author, banner, question, topic) { authorD, bannerD, questionD, topicD -> Bool in
        return true
    }.bind(to: complete).disposed(by: disposeBag)
}
</pre>
当然也可以用DispatchGroup来实现, 大致的实现方式可以[参考](http://www.jianshu.com/p/8b52b9cff1f9)

我为一个Swift的小白, 可以给个星星鼓励一下
