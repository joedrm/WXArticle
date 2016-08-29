//
//  AppDelegate.swift
//  Reading
//
//  Created by wangdongyang on 16/6/30.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit
import SDWebImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setupUI();
        
        return true
    }
    
    func setupUI() {
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor  = UIColor.whiteColor()
        let curDate = NSDate.init()
        let laterDate1 = NSDate.init(string: "2016-8-16", format: "yyyy-MM-dd")
        let isEr =  curDate.isLaterThanOrEqual(laterDate1!) as Bool
//        if isEr {
            window?.rootViewController = RootNavigationController.init(rootViewController: WXMainViewController())
//        }else{
//            window?.rootViewController = RootNavigationController.init(rootViewController: WXHotViewController())
//        }
        window?.makeKeyAndVisible()
    }
    
    
    
    func setupConfig(){
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        SDImageCache.sharedImageCache().clearDisk()
    }
}

