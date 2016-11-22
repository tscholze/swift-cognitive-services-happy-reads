//
//  Articles.swift
//  ReadHappiness
//
//  Created by Tobias Scholze on 06.11.16.
//  Copyright © 2016 Tobias Scholze. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import XMLDictionary


/// Data provider for articles
/// Use `sharedInstance` property
class Articles
{
    // MARK: - Internal properties -
    
    /// Shared instance of the class
    static let sharedInstance = Articles()
    
    
    // MARK: - Private properties -
    
    /// Contains the already cached articles
    fileprivate var cachedArticles = [ArticleItem]()
    
    /// Contains the url to the top news rss feed
    fileprivate let topNewsUrl = "https://rss.dw.com/rdf/rss-en-top"
    
    
    // MARK: - Life cycle -
    
    private init()
    {
        
    }
    
    
    /// Gets all happy (happiness score >= 50%) articles
    ///
    /// callback: List of happy articles
    func getHappyArticles(callback: @escaping (_ articles: [ArticleItem]) -> ())
    {
        get { (allArticles) in
            let positives = allArticles.filter({ (article) -> Bool in
                
                guard let _score = article.score else
                {
                    return false
                }
                
                return _score >= 0.5
            })
            
            callback(positives)
        }
    }
    
    
    /// Gets all unhappy (happiness score < 50%) articles
    ///
    /// callback: List of sad articles
    func getUnhappyArticles(callback: @escaping (_ articles: [ArticleItem]) -> ())
    {
        get { (allArticles) in
            let positives = allArticles.filter({ (article) -> Bool in
                
                guard let _score = article.score else
                {
                    return false
                }
                
                return _score < 0.49
            })
            
            callback(positives)
        }
    }
    
    
    /// Gets all available artices
    /// Will return cached articles if cache is not empty
    ///
    /// callback: List of found articles
    func get(callback: @escaping (_ articles: [ArticleItem]) -> ())
    {
        guard cachedArticles.isEmpty == true else
        {
            callback(cachedArticles)
            return
        }
        
        load { (articles) in
            
            CognitiveService.sharedInstance.enrichArticles(articles, callback: {[weak self] (enrichedArticles) in
                
                guard let _self = self else
                {
                    return
                }
                
                _self.cachedArticles = articles
                callback(articles)
            })
        }
    }
    
    
    // MARK: - Private methods -
    
    /// Private method to load feed and parse it into articles
    ///
    /// callback: List of found articles
    fileprivate func load(callback: @escaping (_ articles: [ArticleItem]) -> ())
    {
        Alamofire.request(topNewsUrl).responseString { response in
            
            guard response.response?.statusCode == 200 else
            {
                fatalError("Could not load feed from url: \(self.topNewsUrl)")
            }
            
            guard let jsonString = response.result.value,
                  let json = XMLDictionaryParser().dictionary(with: jsonString),
                  let items = json["item"]  as? [[String : Any]] else
            {
                fatalError("No response value provides for \(self.topNewsUrl)")
            }
    
            guard let articles = Mapper<ArticleItem>().mapArray(JSONArray: items) else
            {
                callback([])
                return
            }
            
            self.cachedArticles = articles
            callback(articles)
        }
    }
}
