//
//  WXMainViewController.swift
//  Reading
//
//  Created by wangdongyang on 16/7/1.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit
import XYYSegmentControl

class WXMainViewController: UIViewController, XYYSegmentControlDelegate {

    var allVCs:[WXCategrory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订阅号"
        // 这个是必要的设置
        automaticallyAdjustsScrollViewInsets = false
        loadAllCategrories()
    }
    
    func setChildVcs() {
        
        var titles:[String] = []

        for i in 0 ..< allVCs.count {
            let cat = allVCs[i]

            titles.append(cat.name!)
        }
        
        let segment = XYYSegmentControl.init(frame: view.bounds, channelName: titles, source: self)
        segment.userInteractionEnabled = true
        segment.segmentControlDelegate = self
        segment.tabItemNormalFont = 13
        segment.tabItemSelectedFont = 13
        segment.tabItemSelectionIndicatorColor = UIColor.redColor()
        view.addSubview(segment)
    }
    
    /**
     拿到所有分类
     */
    func loadAllCategrories(){
        var paramsDict : Dictionary<String, AnyObject>
        paramsDict = [
            "showapi_appid" :KYiYuanAppID
        ];
        
        let sortResultString = CommonTool.sortWithParams(paramsDict, secretStr: KYiYuanAppSign)
        print("sortResultString = \(sortResultString)")
        print("sortResultString.md5Str() = \(sortResultString.md5Str())")
        paramsDict = [
                    "showapi_appid" :KYiYuanAppID,
                    "showapi_sign":"734235CB039597CE4305D472F684094D"] //sortResultString.md5Str()
       
        DataService.loadAllCategrory(KWXCategroryApi, parameters: paramsDict) { (success, result, error) in
            if success{
                let resultArr = (result! as [String: AnyObject])["showapi_res_body"]!["typeList"]!! as! [[String: AnyObject]]
                var mAll = [WXCategrory]()
                
                // 遍历为了重新排序
                for e in (WXCategrory.objectArrayWithKeyValuesArray(resultArr) as! [WXCategrory]).reverse().enumerate() {
                    mAll.append(e.element)
                }
                
                self.allVCs = mAll
                self.setChildVcs()
                
            }else{
                
            }
        }
    }
}

extension WXMainViewController
{
    func numberOfTab(view: XYYSegmentControl!) -> UInt {
        return UInt(allVCs.count) ?? 0
    }
    
    func slideSwitchView(view: XYYSegmentControl!, viewOfTab number: UInt) -> UIViewController! {
        let cat = allVCs[Int(number)]
        let mutiVC = WXMutiTypeViewController()
        mutiVC.categrery = cat
        return mutiVC
    }
    
    func slideSwitchView(view: XYYSegmentControl!, didselectTab number: UInt) {
        let vc = view.viewArray[Int(number)] as! WXMutiTypeViewController
        if (vc.isFristLoad == false) {
            vc.tableView?.mj_header.beginRefreshing()
            vc.isFristLoad = true
        }
    }
}


