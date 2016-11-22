//
//  AppDelegate.swift
//  ReadHappiness
//
//  Created by Tobias Scholze on 06.11.16.
//  Copyright © 2016 Tobias Scholze. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder
{
    // MARK: - Internal properties -
    
    var window: UIWindow?
}


// MARK: - UIApplicationDelegate -

extension AppDelegate: UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        customizeAppearance()
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication)
    {

    }
    

    func applicationDidEnterBackground(_ application: UIApplication)
    {

    }
    

    func applicationWillEnterForeground(_ application: UIApplication)
    {

    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {

    }
    

    func applicationWillTerminate(_ application: UIApplication)
    {
        
    }
    
    
    // MARK: - Private helper -
    
    private func customizeAppearance()
    {
        window?.tintColor       = UIColor.orange
        window?.backgroundColor = UIColor.white
        
        if let topShadow = UIImage(named: "shadow-top")
        {
            UINavigationBar.appearance().shadowImage = topShadow.resizableImage(withCapInsets: UIEdgeInsets.zero)
        }
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().isTranslucent          = false
        UINavigationBar.appearance().titleTextAttributes    = [NSForegroundColorAttributeName: UIColor.orange]
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: UIControlState.normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: UIControlState.disabled)
        
        if let bottomShadow = UIImage(named: "shadow-bottom")
        {
            UITabBar.appearance().shadowImage = bottomShadow.resizableImage(withCapInsets: UIEdgeInsets.zero)
        }
        
        UITabBar.appearance().backgroundImage   = UIImage()
        UITabBar.appearance().tintColor         = UIColor.orange
        UITabBar.appearance().isTranslucent     = false
    }
}

