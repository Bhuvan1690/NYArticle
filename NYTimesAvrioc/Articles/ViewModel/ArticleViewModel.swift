//
//  ArticleViewModel.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 23/06/22.
//

import Foundation

protocol showLoader{
    func isLoading(loading : LoadingState)
}

class ArticleViewModel {
    
    var delegate : showLoader?
    private let networkLayer: Requestable    
    var articles: Box<[ArticleDto]> = Box([])
    var articleAPIError: Box<String?> = Box(nil)
    
    private var arrArticles: [ArticleDto]?
    
    init(networkLayer: Requestable = NetworkLayer()) {
        self.networkLayer = networkLayer
    }
    
    var totalCount: Int {
        articles.value.count
    }
    
    
    func articleInfo(index: Int) -> ArticleDto? {
        if articles.value.count > 0{
            return articles.value[index]
        }
        return nil
    }
    
    func reloadInfo() {
        articles.notifyListeners()
    }
    
    func getArticleCellModel(for index: Int) -> ArticleCellViewModel? {
        if let info = self.articleInfo(index: index){
            var imageUrl = ""
            if let imageMedia = info.media.filter({$0.type == "image"}).first{
                if let thumbImage = imageMedia.mediaMetadata.filter({$0.format == .standardThumbnail}).first{
                    imageUrl = thumbImage.url;
                }
            }
            return ArticleCellViewModel(image: imageUrl, title: info.title, id: info.id, publishDate: info.publishedDate, source: info.source);
        }
        return nil
    }
    
    func getArticleDetailModel(for index: Int) -> ArticleDetailViewModel? {
        if let info = self.articleInfo(index: index){
            var imageUrl = ""
            if let imageMedia = info.media.filter({$0.type == "image"}).first{
                if let thumbImage = imageMedia.mediaMetadata.filter({$0.format == .mediumThreeByTwo440}).first{
                    imageUrl = thumbImage.url;
                }
            }
            return ArticleDetailViewModel(image: imageUrl, title: info.title, id: info.id, publishDate: info.publishedDate, source: info.source,shortDescript: info.abstract,url: info.url);
        }
        return nil
    }
    
    func articleId(for index: Int) -> Int {
        return articles.value[index].id
    }
}

extension ArticleViewModel {
    
    func getArticles(endPoint : EndPointType) {
        delegate?.isLoading(loading: LoadingState.loading)
        networkLayer.responseData(endPoint: endPoint) { [weak self](response: Result<Response, Error>) in
            self?.delegate?.isLoading(loading: LoadingState.normal)
            switch response {
            case .success(let model):
                if model.fault == nil{
                    if model.status != "OK"{
                        self?.articleAPIError.value = NetworkError.BadRequest.rawValue
                        Logger.log(msg: NetworkError.BadRequest.rawValue)
                    }else{
                        if model.results.count == 0{
                            self?.articleAPIError.value = NetworkError.NoDataFound.rawValue
                        }else{
                            self?.articles.value = model.results
                        }
                    }
                }else{
                    self?.articleAPIError.value = model.fault!.faultstring
                    Logger.log(msg: model.fault!.faultstring)
                }
                
            case .failure(let error):
                self?.articleAPIError.value = error.localizedDescription
                Logger.log(msg: error)
            }
        }
    }
}
