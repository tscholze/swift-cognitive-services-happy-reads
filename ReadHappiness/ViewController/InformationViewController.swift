//
//  InformationViewController.swift
//  ReadHappiness
//
//  Created by Tobias Scholze on 22.11.16.
//  Copyright © 2016 Tobias Scholze. All rights reserved.
//

import Foundation
import UIKit


class InformationViewController: UIViewController
{
    // MARK: - Outlets -
    
    @IBOutlet var webView: UIWebView!
    
    
    // MARK: - Private properties -
    
    var loadingView: LoadingView!
    
    
    // MARK: - Life cycle -
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadingView         = LoadingView(backgroundColor: UIColor.white, loadingText: "Loading ...")
        webView.delegate    = self
        fillWebView()
    }
    
    
    // MARK: - Private helper -
    
    private func fillWebView()
    {
        loadingView.present(onView: webView.scrollView)
        
        defer
        {
            loadingView.dismiss()
        }
        
        guard let htmlFile = Bundle.main.path(forResource: "information", ofType: "html") else
        {
            return
        }
        
        do
        {
            let html = try String(contentsOfFile: htmlFile, encoding: String.Encoding.utf8)
            webView.loadHTMLString(html, baseURL: nil)
        }
            
        catch
        {
            // Ignore the error case
        }
    }
    
    
    // MARK: - Actions -
    
    @IBAction func closeButtonTapped(_ sender: AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: - UIWebViewDelegate -

extension InformationViewController: UIWebViewDelegate
{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        guard let url = request.url,
                  url.absoluteString != "about:blank",
                  UIApplication.shared.canOpenURL(url) == true else
        {
            return true
        }
        
        UIApplication.shared.open(url)
        return false
    }
}

