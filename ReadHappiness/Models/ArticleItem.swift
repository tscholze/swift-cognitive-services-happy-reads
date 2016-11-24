//
//  ArticleItem.swift
//  ReadHappiness
//
//  Created by Tobias Scholze on 06.11.16.
//  Copyright © 2016 Tobias Scholze. All rights reserved.
//

import Foundation
import ObjectMapper


/// Model of an article
/// Is mappable from json
class ArticleItem
{
    // MARK: Internal properties -
    
    /// Unique feed item id
    var id: String!
    
    /// Title
    var title: String!
    
    /// Original content from feed item
    var originalContent: String!
    
    /// Post-processed content
    var content: String!
    
    /// Link to the article
    var link: String!
    
    /// Sentiment score
    var score: Double?
    
    
    // MARK: - Life cycle -
    
    /// Inits an item filled by a map
    required init?(map: Map)
    {
        let dict = map.JSON
        
        // Ensure that non optional values are present
        guard dict["title"] != nil &&
              dict["description"] != nil &&
              dict["dwsyn:contentID"] != nil &&
              dict["link"] != nil else
        {
            return nil
        }
    }
}


// MARK: - Mapable -

extension ArticleItem: Mappable
{
    func mapping(map: Map)
    {
        id              <- map["dwsyn:contentID"]
        title           <- map["title"]
        originalContent <- map["description"]
        link            <- map["link"]
        
        // Post processing
        content = originalContent.replacingOccurrences(of: "/", with: "")
    }
}


// MARK: - CustomStringConvertible -

extension ArticleItem: CustomStringConvertible
{
    var description: String
    {
        guard let _id = id,
              let _title = title else
        {
            return "`ArticleItem` object with missing id"
        }
        
        guard let _score = score else
        {
            return "Id: \(_id), title: \(_title)"
        }
        
        return "Id: \(_id), title: \(_title), score: \(_score)"
    }
}
