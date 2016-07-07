//
//  DataService.swift
//  Reading
//
//  Created by wangdongyang on 16/7/1.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit

class DataService: NSObject {

    typealias NetworkFinished = (success: Bool, result: [String: AnyObject]?, error: NSError?) ->()
    
    
    // 拿到所有的分类数据
    class func loadAllCategrory(APIString: String, parameters: [String : AnyObject]?, finished: NetworkFinished) {
        NetworkTools.sharedInstance.get(APIString, parameters: parameters, success: { (result, error) in
            if (result)!["showapi_res_body"]!["ret_code"]!! as! NSObject == 0 {
                finished(success:true, result: (result! as [String : AnyObject]), error: nil)
            } else {
                finished(success:false, result: (result! as [String : AnyObject]), error: nil)
            }
            }) { (error) in
                finished(success:false, result: nil, error: error)
        }
        
    }
    
    class func queryByCategroryID (parameters: [String : AnyObject]?, finished: NetworkFinished){
        NetworkTools.sharedInstance.get(KWXQueryApi, parameters: parameters, success: { (result, error) in
            if (result)!["showapi_res_code"]! as! NSObject == 0 {
                finished(success:true, result: (result! as [String : AnyObject]), error: nil)
            } else {
                finished(success:false, result: (result! as [String : AnyObject]), error: nil)
            }
        }) { (error) in
            finished(success:false, result: nil, error: error)
        }
    }
}
