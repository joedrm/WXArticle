//
//  WXHotViewController.swift
//  Reading
//
//  Created by wangdongyang on 16/6/30.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit
import WDYLibrary
import MJExtension
import SwiftyJSON
import MJRefresh

private let WXHotReuseIdentifier = "WXHotReuseIdentifier"

class WXHotViewController: RootViewController, UITableViewDataSource, UITableViewDelegate {
    
    var hotNews: [WXHotItem]?
    var pageIndex: Int  = 1
    var tableView: UITableView?
    
    override func viewDidLoad() {
        title = "热门文章"
        
        tableView = UITableView.init(frame: self.view.bounds)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.tableFooterView = UIView()
        let nib = UINib.init(nibName: "WXHotCell", bundle: NSBundle.mainBundle())
        tableView?.registerNib(nib, forCellReuseIdentifier: WXHotReuseIdentifier)
        view.addSubview(tableView!)
        
        tableView!.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(WXHotViewController.loadNewData))
        tableView!.mj_header.beginRefreshing()
        tableView!.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(WXHotViewController.loadMoreData))
    }
    
    
    /**
     下拉刷新
     */
    func loadNewData(){
        pageIndex = 1
        var paramsDict : Dictionary<String, AnyObject>
        paramsDict = [
            "num":"10",
            "page"          :pageIndex,
            "showapi_appid" :KYiYuanAppID
        ];
        
        let sortResultString = CommonTool.sortWithParams(paramsDict, secretStr: KYiYuanAppSign)
        let dict = ["num":"10",
                    "page"          :pageIndex,
                    "showapi_appid" :KYiYuanAppID,
                    "showapi_sign":sortResultString.md5Str()]
//        NetworkTools.sharedInstance.get("", parameters: dict as? [String : AnyObject]) { (success, result, error) in
//            if success{
//                print("\((result! as [String: AnyObject])["showapi_res_body"]!["newslist"]!!)")
//                let resultArr = (result! as [String: AnyObject])["showapi_res_body"]!["newslist"]!! as! [[String: AnyObject]]
//                let models = WXHotItem.objectArrayWithKeyValuesArray(resultArr) as! [WXHotItem]
//                self.hotNews =  models
//                self.tableView?.reloadData()
//                self.tableView?.mj_header.endRefreshing()
//            }else{
//                self.tableView?.mj_header.endRefreshing()
//            }
//        }
    }
    
    /**
     加载更多
     */
    func loadMoreData()  {
        pageIndex += 1
        var paramsDict : Dictionary<String, AnyObject>
        paramsDict = [
            "num":"10",
            "page"          :pageIndex,
            "showapi_appid" :KYiYuanAppID
        ];
        
        let sortResultString = CommonTool.sortWithParams(paramsDict, secretStr: KYiYuanAppSign)
        let dict = ["num":"10",
                    "page"          :pageIndex,
                    "showapi_appid" :KYiYuanAppID,
                    "showapi_sign":sortResultString.md5Str()]
//        NetworkTools.sharedInstance.get("", parameters: dict as? [String : AnyObject]) { (success, result, error) in
//            if success{
//                let resultArr = (result! as [String: AnyObject])["showapi_res_body"]!["newslist"]!! as! [[String: AnyObject]]
//                let models = WXHotItem.objectArrayWithKeyValuesArray(resultArr) as! [WXHotItem]
//                self.hotNews =  self.hotNews! + models
//                self.tableView?.reloadData()
//                self.tableView?.mj_footer.endRefreshing()
//            }else{
//                self.tableView?.mj_footer.endRefreshing()
//            }
//        }
    }
    
    
}


extension WXHotViewController   {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hotNews?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let hotItem = hotNews![indexPath.row] as WXHotItem
        let cell = tableView.dequeueReusableCellWithIdentifier(WXHotReuseIdentifier)! as! WXHotCell
        cell.selectionStyle = .None
        cell.hotItem = hotItem
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hotItem = hotNews![indexPath.row] as WXHotItem
        let detailVC = WXHotDetailViewController()
        detailVC.hotItem = hotItem
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


