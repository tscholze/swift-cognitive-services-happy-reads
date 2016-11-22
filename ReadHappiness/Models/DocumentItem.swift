//
//  DocumentItem.swift
//  ReadHappiness
//
//  Created by Tobias Scholze on 06.11.16.
//  Copyright © 2016 Tobias Scholze. All rights reserved.
//

import Foundation
import ObjectMapper


class DocumentItem
{
    // MARK: - Internal properties -
    
    /// Unique ID
    var id: String!
    
    /// Language identifier of the text
    var language: String?
    
    // Text
    var text: String?
    
    // Sentiment score
    var score: Double?
    
    
    // MARK: - Life cycle -
    
    init()
    {
        
    }
    
    
    convenience init(_ article: ArticleItem, withLanguage: String = "en")
    {
        self.init()
        
        id          = article.id
        language    = withLanguage
        text        = article.content
    }
    
    /// Inits an item filled by a map
    required init?(map: Map)
    {
        
    }
}


// MARK: - Mappable -

extension DocumentItem: Mappable
{
    func mapping(map: Map)
    {
        id          <- map["id"]
        language    <- map["language"]
        text        <- map["text"]
        score       <- map["score"]
    }
}


// MARK: - CustomStringConvertible -

extension DocumentItem: CustomStringConvertible
{
    var description: String
    {
        guard let _id = id else
        {
            return "Object with missing id"
        }
        
        guard let _score = score else
        {
            return "Id: \(_id)"
        }
        
        return "Id: \(_id), score: \(_score)"
    }
}
