//
//  WXCategrory.swift
//  
//
//  Created by wangdongyang on 16/7/1.
//
//

import UIKit

class WXCategrory: NSObject {
    
    
    var idStr: String?
    var name: String?
    
    
    internal override class func initialize()
    {
        WXCategrory.setupReplacedKeyFromPropertyName { () -> [NSObject : AnyObject]! in
            return ["idStr":"id"]
        }
    }
}
