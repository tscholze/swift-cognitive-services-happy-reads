//
//  TableViewController.swift
//  ReadHappiness
//
//  Created by Tobias Scholze on 21.11.16.
//  Copyright © 2016 Tobias Scholze. All rights reserved.
//

import Foundation
import UIKit
import SafariServices


/// TableViewController to work with `ArticleTableViewCell`
///
/// - Provides a loading view
/// - Contains Inspectable flags for which kind of articles
///   should be displayed (happy, unhappy, all, none)
class TableViewController: UITableViewController
{
    // MARK: - Inspectable properties -
    
    @IBInspectable
    /// If true, the table view will contain
    /// postive aka happy articles
    ///
    /// Default value: false
    var showPositive: Bool = false
    
    @IBInspectable
    /// If true, the table view will contain
    /// negative aka unhappy articles
    ///
    /// Default value: false
    var showNegatives: Bool = false
    
    
    // MARK: - Private properties -
    
    /// View's loading view
    fileprivate var loadingView: LoadingView!
    
    
    /// List of `ArticleItem` that will be used
    /// as table view's data source.
    ///
    /// Default value: Empty list
    fileprivate var articles = [ArticleItem]()
    {
        didSet
        {
            tableView.reloadData()
        }
    }
    
    
    // MARK: - Life cycle -
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadingView = LoadingView(backgroundColor: UIColor.white,
                                  loadingText: "Checking for happiness\nPlease wait ...")
                
        tableView.register(UINib(nibName: ArticleTableViewCell.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: ArticleTableViewCell.cellIdentifier)
        
        tableView.tableFooterView       = UIView()
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.estimatedRowHeight    = ArticleTableViewCell.requiredHeight
        tableView.separatorColor        = UIColor.orange
        
        loadData()
    }
    
    
    // MARK: - Private helper -
    
    /// Loads data from the Service according to the
    /// setting of the `showPositive` and `showNegatives`
    /// flags.
    ///
    /// `showPositive && showNegatives`     -> all
    /// `showPositive`                      -> happy articles
    /// `showNegatives`                     -> unhappy articles
    /// `!showPositive && !showNegatives`   -> no articles
    private func loadData()
    {
        loadingView.present(onView: tableView)
        
        if showPositive && showNegatives
        {
            Articles.sharedInstance.get { [weak self]  (articles) in
                
                guard let _self = self else
                {
                    return
                }
                
                _self.articles = articles
                _self.loadingView.dismiss()
            }

        }
        
        else if showPositive
        {
            Articles.sharedInstance.getHappyArticles { [weak self]  (articles) in
                
                guard let _self = self else
                {
                    return
                }
                
                _self.articles = articles
                _self.loadingView.dismiss()
            }
        }
        
        else if showNegatives
        {
            Articles.sharedInstance.getUnhappyArticles { [weak self]  (articles) in
                
                guard let _self = self else
                {
                    return
                }
                
                _self.articles = articles
                _self.loadingView.dismiss()
            }

        }
        
        else
        {
            articles = []
            self.loadingView.dismiss()
        }
    }
    
    
    // MARK: - Actions -
    
    @IBAction func infoButtonTapped(_ sender: AnyObject)
    {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "InformationScene") else
        {
            return
        }
        
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
    }
}


// MARK: - UITableViewDelegate -

extension TableViewController
{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let articleUrl = URL(string: articles[indexPath.row].link) else
        {
            return
        }
        
        let safariVc = SFSafariViewController(url: articleUrl, entersReaderIfAvailable: true)
        
        safariVc.delegate                   = self
        safariVc.preferredBarTintColor      = UIColor.white
        safariVc.preferredControlTintColor  = UIColor.orange
        
        present(safariVc, animated: true, completion: nil)
    }
}


// MARK: - UITableViewDatasource -

extension TableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return articles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.cellIdentifier,
                                                 for: indexPath) as! ArticleTableViewCell
        
        cell.article = articles[indexPath.row]
        return cell
    }
}


// MARK: - SafariViewControllerDelegate -

extension TableViewController: SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}
