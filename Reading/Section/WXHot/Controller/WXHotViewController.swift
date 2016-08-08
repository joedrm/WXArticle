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
    
    var hotNews: [WXArticleItem]?
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
    }
    
    
    /**
     下拉刷新
     */
    func loadNewData(){
        let aa = WXArticleItem.objectArrayWithFilename("wxhot.plist")
        hotNews = aa as? [WXArticleItem];
        tableView?.reloadData()
        tableView?.mj_header.endRefreshing();
    }
    
}


extension WXHotViewController   {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hotNews?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let hotItem = hotNews![indexPath.row] as WXArticleItem
        let cell = tableView.dequeueReusableCellWithIdentifier(WXHotReuseIdentifier)! as! WXHotCell
        cell.selectionStyle = .None
        cell.hotItem = hotItem
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let hotItem = hotNews![indexPath.row] as WXArticleItem
//        let detailVC = WXHotDetailViewController()
//        detailVC.hotItem = hotItem
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
}


