//
//  WXMutiTypeViewController.swift
//  Reading
//
//  Created by wangdongyang on 16/7/1.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit
import MJRefresh
import WDYLibrary

private let WXHotReuseIdentifier = "WXHotReuseIdentifier"

class WXMutiTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var isFristLoad: Bool? = false
    var type: String?
    var tableView: UITableView?
    var hotNews: [WXArticleItem]?
    var pageIndex: Int  = 1
    
    var categrery : WXCategrory?
        {
        didSet{
            type = categrery!.idStr!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: self.view.bounds)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.tableFooterView = UIView()
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.showsVerticalScrollIndicator = false
        tableView?.backgroundColor = UIColor.init(red: 242, green: 243, blue: 239, alpha: 1)
        let nib = UINib.init(nibName: "WXMutiItemCell", bundle: NSBundle.mainBundle())
        tableView?.registerNib(nib, forCellReuseIdentifier: WXHotReuseIdentifier)
        view.addSubview(tableView!)
        
        tableView!.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(WXHotViewController.loadNewData))
        tableView!.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(WXHotViewController.loadMoreData))
        tableView?.mj_footer.automaticallyHidden = true
    }

    /**
     拿到当前分类的数据
     */
    func loadNewData(){
        pageIndex = 1
        var paramsDict : Dictionary<String, AnyObject>
        paramsDict = [
            "typeId":type!,
            "page":pageIndex,
            "showapi_appid" :KYiYuanAppID
        ];
        
        let sortResultString = CommonTool.sortWithParams(paramsDict, secretStr: KYiYuanAppSign)
//        print("sortResultString = \(sortResultString)")
        print("WXMutiTypeViewController sortResultString.md5Str() = \(sortResultString.md5Str())")
        paramsDict = [
            "typeId":type!,
            "page":pageIndex,
            "showapi_appid" :KYiYuanAppID,
            "showapi_sign":sortResultString.md5Str()]
        DataService.queryByCategroryID(paramsDict) { (success, result, error) in
//            print("\(result)")
            if success{
                let resultArr = (result! as [String: AnyObject])["showapi_res_body"]!["pagebean"]!!["contentlist"]!! as! [[String: AnyObject]]
                let models = WXArticleItem.objectArrayWithKeyValuesArray(resultArr) as! [WXArticleItem]
                self.hotNews = models
                self.tableView?.reloadData()
                self.tableView?.mj_header.endRefreshing()
            }else{
                self.tableView?.mj_header.endRefreshing()
            }
        }
    }
    
    func loadMoreData(){
        pageIndex += 1
        var paramsDict : Dictionary<String, AnyObject>
        paramsDict = [
            "typeId":type!,
            "page":pageIndex,
            "showapi_appid" :KYiYuanAppID
        ];
        
        let sortResultString = CommonTool.sortWithParams(paramsDict, secretStr: KYiYuanAppSign)
        //        print("sortResultString = \(sortResultString)")
        print("WXMutiTypeViewController sortResultString.md5Str() = \(sortResultString.md5Str())")
        paramsDict = [
            "typeId":type!,
            "page":pageIndex,
            "showapi_appid" :KYiYuanAppID,
            "showapi_sign":sortResultString.md5Str()]
        DataService.queryByCategroryID(paramsDict) { (success, result, error) in
            if success{
                let resultArr = (result! as [String: AnyObject])["showapi_res_body"]!["pagebean"]!!["contentlist"]!! as! [[String: AnyObject]]
                let models = WXArticleItem.objectArrayWithKeyValuesArray(resultArr) as! [WXArticleItem]
                self.hotNews = self.hotNews! + models
                self.tableView?.reloadData()
                self.tableView?.mj_footer.endRefreshing()
            }else{
                self.tableView?.mj_footer.endRefreshing()
            }
        }
    }
}

extension WXMutiTypeViewController   {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hotNews?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let hotItem = hotNews![indexPath.row] as WXArticleItem
        let cell = tableView.dequeueReusableCellWithIdentifier(WXHotReuseIdentifier)! as! WXMutiItemCell
        cell.articile = hotItem
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hotItem = hotNews![indexPath.row] as WXArticleItem
        let detailVC = WXHotDetailViewController()
        detailVC.articleItem = hotItem
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

