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
    
    
    static func savaData(param:[AnyObject]){
        let array = param as NSArray
        array.writeToFile(dataFilePath() as String, atomically: true);
    }
    
    static func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        print("documentsDirectory = \(documentsDirectory)")
        return documentsDirectory.stringByAppendingPathComponent("wxhot.plist") as String
    }
    
    static func readData()-> [String]{
        let array = NSArray(contentsOfFile: "wxhot.plist") as! [String]
        return array as [String];
    }
}
