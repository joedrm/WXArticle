//
//  RootNavigationController.swift
//  Reading
//
//  Created by wangdongyang on 16/6/30.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {

    override func viewDidLoad() {
        
    }
    
    override class func initialize() {
        
        let navBar = UINavigationBar.appearance()
        navBar.translucent = false
        
        navBar.barTintColor = UIColor.redColor()
        
        var textAttrs = [String: AnyObject]();
        textAttrs[NSForegroundColorAttributeName] = UIColor.whiteColor();
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(15);
        
//        [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//        [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
        
//        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
//        disableTextAttrs[NSForegroundColorAttributeName] =  [UIColor whiteColor];
//        [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
        navBar.titleTextAttributes = textAttrs
    }
}
