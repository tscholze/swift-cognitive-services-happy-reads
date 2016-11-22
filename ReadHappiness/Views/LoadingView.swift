//
//  LoadingView.swift
//  ReadHappiness
//
//  Created by Tobias Scholze on 21.11.16.
//  Copyright © 2016 Tobias Scholze. All rights reserved.
//

import UIKit
import SnapKit


class LoadingView: UIView
{
    // MARK: - Internal properties -
    
    /// Text that will be displayed while loading data
    /// Default value is nil
    var loadingText : String?
    
    
    // MARK: - Private properties -
    
    private var loadingContainer    : UIView!
    private var activityIndicator   : UIActivityIndicatorView!
    private var loadingLabel        : UILabel!
    
    
    // MARK: - Initialization & Setup -
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    
    /// Loading View initializer
    ///
    /// - parameter backgroundColor : The preferred backgroundcolor of the view
    /// - parameter loadingText     : Loading text, visible during loading
    convenience init(backgroundColor: UIColor, loadingText: String? = nil)
    {
        self.init(frame: CGRect())
        
        self.backgroundColor    = backgroundColor
        self.loadingText        = loadingText
        
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        setup()
    }
    
    
    // MARK: - Present / Dismiss -

    /// Presents the loading view on given base view
    ///
    /// - parameter view: Base view
    func present(onView view : UIView)
    {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations:
            {
                self.loadingContainer.alpha = 1
            })
        { (finished) in
            
        }
        
        guard self.superview == nil else
        {
            return
        }
        
        // Add view to base view and align it
        view.addSubview(self)
        
        self.snp.makeConstraints { make in
            make.top.height.equalTo(view)
            make.width.left.equalTo(view)
        }
    }
    
    
    /// Dismisses the loading view
    ///
    /// - parameter animated: If true, the view will have a fade out
    ///                       (default value: true)
    func dismiss(animated : Bool = true)
    {
        UIView.animate(withDuration: animated ? 0.25 : 0, delay: 0, options: .curveEaseOut, animations:
        {
            self.alpha = 0.0
        })
        { (finished) in
            self.removeFromSuperview()
            self.alpha = 1.0
        }
    }
  
    
    // MARK: - Privat helper -
    
    private func setup()
    {
        loadingContainer = UIView()
        addSubview(loadingContainer)
        
        loadingContainer.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.leading.equalTo(self).offset(20)
        }
        
        activityIndicator       = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.color = UIColor.orange
        activityIndicator.startAnimating()
        
        loadingLabel                = UILabel()
        loadingLabel.text           = loadingText
        loadingLabel.textColor      = UIColor.orange
        loadingLabel.textAlignment  = .center
        loadingLabel.numberOfLines  = 1
        loadingLabel.isHidden       = loadingText == nil
        
        adjustLoadingContainer()
    }
    
    
    private func adjustLoadingContainer()
    {
        loadingContainer.layoutSubviews()
        loadingContainer.addSubview(activityIndicator)
        
        guard loadingLabel.isHidden == false else
        {
            activityIndicator.snp.makeConstraints { (make) in
                make.edges.equalTo(loadingContainer)
            }
            
            return
        }
        
        loadingContainer.addSubview(loadingLabel)
        
        loadingLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(loadingContainer)
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.top.equalTo(loadingLabel.snp.bottom).offset(20)
            make.bottom.equalTo(loadingContainer)
            make.centerX.equalTo(loadingContainer)
        }
    }
}
