//
//  ArticleTableViewCell.swift
//  ReadHappiness
//
//  Created by Tobias Scholze on 17.11.16.
//  Copyright © 2016 Tobias Scholze. All rights reserved.
//

import Foundation
import UIKit


class ArticleTableViewCell: UITableViewCell
{
    // MARK: - Static properties -
    
    /// Unique cell identifier
    static let cellIdentifier = "ArticleTableViewCell"
    
    /// Required cell's height
    static let requiredHeight = CGFloat(68)
    
    
    // MARK: - Outlets -
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var emojiLabel: UILabel!
    @IBOutlet private var scoreLabel: UILabel!
    
    
    // MARK: - Internal properties -
    
    /// `ArticleItem` object that is used as data
    /// source for the cell's content
    var article: ArticleItem?
    {
        didSet
        {
            setup()
        }
    }
    
    
    // MARK: - Life cycle -
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        preservesSuperviewLayoutMargins = false
        separatorInset                  = UIEdgeInsets.zero
        layoutMargins                   = UIEdgeInsets.zero
    }
    
    
    override func prepareForReuse()
    {
        super.prepareForReuse()

        reset()
    }
    
    
    // MARK: - Private helper -
    
    
    /// Fills the cell with `article` object data.
    private func setup()
    {
        reset()
        
        guard let _article = article else
        {
            return
        }
        
        titleLabel.text = _article.title
        
        guard let _score = _article.score else
        {
            return
        }
        
        if _score > 0.89
        {
            emojiLabel.text = "😀"
        }
        
        else if _score > 0.74
        {
            emojiLabel.text = "🙂"
        }
        
        else if _score > 0.29
        {
            emojiLabel.text = "😐"
        }
        
        else
        {
            emojiLabel.text = "😟"
        }
        
        scoreLabel.text = "Happiness Score: \(Int(_score * 100)) %"
    }
    
    
    /// Resets cell's content
    private func reset()
    {
        titleLabel.text = nil
        emojiLabel.text = nil
        scoreLabel.text = nil
    }
}
