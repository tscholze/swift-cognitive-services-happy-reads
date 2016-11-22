//
//  CognitiveServiceSentimentItem.swift
//  ReadHappiness
//
//  Created by Tobias Scholze on 03.11.16.
//  Copyright © 2016 Tobias Scholze. All rights reserved.
//

import Foundation
import ObjectMapper


class CognitiveServiceSentimentItem
{
    // MARK: - Private properties -
    
    var documents = [DocumentItem]()
    
    
    // MARK: - Life cycle -
    
    init()
    {
        
    }
    
    
    convenience init(_ documents: [DocumentItem])
    {
        self.init()
        self.documents = documents
    }
    
    /// Inits an item filled by a map
    required init?(map: Map)
    {

    }
}


// MARK: - Mappable -

extension CognitiveServiceSentimentItem: Mappable
{
    func mapping(map: Map)
    {
        documents <- map["documents"]
    }
}



