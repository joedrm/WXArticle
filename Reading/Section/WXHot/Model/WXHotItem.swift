//
//  WXHotItem.swift
//  Reading
//
//  Created by wangdongyang on 16/6/30.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit

class WXHotItem: NSObject {
    
    
    
    internal override func finalize()
    {
        
    }

    
    internal override class func initialize()
    {
        WXHotItem.setupReplacedKeyFromPropertyName { () -> [NSObject : AnyObject]! in
            return ["des":"description"]
        }
    }
    /*
     "title" : "熄屏状态微信秒支付自拍大杀器vivoX7X7Plus发布",
     "ctime" : "2016-06-30",
     "description" : "好机友",
     "url" : "http:\/\/mp.weixin.qq.com\/s?__biz=MjM5MDYxMDA0MQ==&idx=1&mid=2651179165&sn=0d86f75d8e2c2208acd45a0c862cdf34",
     "picUrl" : "http:\/\/zxpic.gtimg.com\/infonew\/0\/wechat_pics_-6508858.jpg\/640"
     */
    
    var title: String?
    var ctime: String?
    var des: String?
    var url: String?
    var picUrl: String?
    
    
//    public class func initialize(){}
}


extension WXHotItem{

    
   
}
