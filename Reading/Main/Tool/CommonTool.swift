//
//  CommonTool.swift
//  Reading
//
//  Created by wangdongyang on 16/7/1.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit

class CommonTool: NSObject {

    // 对参数精选排序
    static func sortWithParams(params:[String: AnyObject], secretStr:String) -> String {
        
        let keys = params.keys;
        
        let sortArr = keys.sort { (obj1: String, obj2: String) -> Bool in
            return obj1<obj2;
        }
        var tempArr = [String]();
        for key:String in sortArr {
            
            let valueStr = params[key]! as AnyObject
            
            let formattedString = String(format: "\(key)\(valueStr)")
            
            tempArr.append("\(formattedString)")
        }
        let sss = tempArr.joinWithSeparator("")
        let finalString = sss.stringByAppendingString(secretStr);
        return String(finalString)
    }
    
}
