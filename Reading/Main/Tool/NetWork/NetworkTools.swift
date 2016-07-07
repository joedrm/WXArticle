//
//  NetworkTools.swift
//  Reading
//
//  Created by wangdongyang on 16/6/30.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkTools: NSObject {
    
        /// 网络请求工具类
    static let sharedInstance = NetworkTools()
    
        /// 网络请求回调闭包 success:是否成功 result:字典数据 error:错误信息
    typealias NetworkSuccess = (result: [String: AnyObject]?, error: NSError?) ->()
    typealias NetworkFailed = (error: NSError?) ->()
}

extension NetworkTools
{
    /**
     GET请求
     
     - parameter URLString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    func get(APIString: String, parameters: [String : AnyObject]?, success: NetworkSuccess, failed: NetworkFailed) {
        
        var urlString = ""
        if APIString.hasPrefix("http") {
            urlString = APIString
        } else {
            urlString = "\(APIString)"
        }
        Alamofire.request(.GET, urlString, parameters: parameters).responseJSON { (response) -> Void in
            if let data = response.data {
                let json = JSON(data: data).object
//                print("json\(json)")
////                print("json: \((json as! [String: AnyObject])["showapi_res_body"]!["ret_code"]!!)")
//                
//                if (json as! [String: AnyObject])["showapi_res_body"]!["ret_code"]!! as! NSObject == 0 {
//
////                    print("json: \(json)")
//                    success(result: (json as! [String : AnyObject]), error: nil)
//                } else {
                    success(result: (json as! [String : AnyObject]), error: response.result.error)
//                }
            } else {
                failed(error: response.result.error)
            }
        }
        
    }

    
    /**
     POST请求
     
     - parameter URLString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    func post(APIString: String, parameters: [String : AnyObject]?, success: NetworkSuccess, failed: NetworkFailed) {
        
        var urlString = ""
        if APIString.hasPrefix("http") {
            urlString = APIString
        } else {
            urlString = "\(KWXHotApi)\(APIString)"
        }
        Alamofire.request(.POST, urlString, parameters: parameters).responseJSON { (response) -> Void in
            
            if let data = response.data {
                let json = JSON(data: data).object
                
                print("json: \(json)")
                success(result: (json as! [String : AnyObject]), error: response.result.error)
            } else {
                failed(error: response.result.error)
            }
        }
        
    }

}



