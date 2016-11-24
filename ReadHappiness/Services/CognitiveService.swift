//
//  CognitiveService.swift
//  ReadHappiness
//
//  Created by Tobias Scholze on 06.11.16.
//  Copyright © 2016 Tobias Scholze. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire


class CognitiveService
{
    // MARK: - Internal properties -
    
    /// Shared instance of the class
    static let sharedInstance = CognitiveService()
    
    
    // MARK: - Private properties -
    
    fileprivate static let ApiKey = "2049060041db4bc5960e0acf40391ae2"
    fileprivate static let ApiUrl = "https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment"
    
    
    // MARK: - Life cycle -
    
    private init()
    {
        
    }
    
    
    // MARK: - Internal methods -
    
    /// Enriches existing ArticleItem objects with Text API 
    /// calculated happiness sentiment.
    /// If an item in the list has already a sentiment, the object
    /// will be ignored.
    ///
    /// - parameter articles: Origin ArticleItem objects
    /// - callback          : List woth enriched original ArticleItem objects
    func enrichArticles(_ articles: [ArticleItem], callback: @escaping (_ articles: [ArticleItem]) -> ())
    {
        var documents                       = [DocumentItem]()
        var header                          = [String : String]()
        header["Ocp-Apim-Subscription-Key"] = CognitiveService.ApiKey
        header["Content-Type"]              = "application/json"
        header["Accept"]                    = "application/json"
        
        for article in articles
        {
            guard article.score == nil else
            {
                continue
            }
            
            documents.append(DocumentItem(article))
        }
        
        let model       = CognitiveServiceSentimentItem(documents)
        let parameters  = Mapper().toJSON(model)
        let request     = Alamofire.request(CognitiveService.ApiUrl,
                                            method: HTTPMethod.post,
                                            parameters: parameters,
                                            encoding: JSONEncoding.default,
                                            headers: header)
        
        request.responseJSON { (reponse) in
            guard let item = Mapper<CognitiveServiceSentimentItem>().map(JSONObject: reponse.result.value) else
            {
                assertionFailure("Could not parse CS reponse")
                return
            }
            
            for scoreDocument in item.documents
            {
                for article in articles
                {
                    if scoreDocument.id == article.id
                    {
                        article.score = scoreDocument.score
                        continue
                    }
                }
            }
            
            callback(articles)
        }
    }
}
