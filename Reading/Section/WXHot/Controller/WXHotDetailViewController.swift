//
//  WXHotDetailViewController.swift
//  Reading
//
//  Created by wangdongyang on 16/7/1.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit
import WDYLibrary

class WXHotDetailViewController: RootViewController,UIWebViewDelegate {

    var urlString: String?
    var indCar: UIActivityIndicatorView?
    var webView: UIWebView?
    var noti :UILabel?
    
    var hotItem : WXHotItem?
        {
        didSet{
            if let hot = hotItem {
                urlString = hot.url!
            }
        }
    }
    
    var articleItem : WXArticleItem?
        {
        didSet{
            if let art = articleItem {
                urlString = art.url!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "文章详情"
        view.backgroundColor  = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        print("\(urlString)")
        
        indCar = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        indCar!.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        indCar!.center = view.center
        indCar?.startAnimating()
        view.addSubview(indCar!)
        
        noti = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.wdy_width, height: 20))
        noti!.text = "网络好像出了一点问题！"
//        noti?.backgroundColor = UIColor.redColor()
        noti?.textAlignment = NSTextAlignment.Center
        noti!.textColor = UIColor.blackColor()
        noti!.font = UIFont.systemFontOfSize(14)
        noti!.center = view.center
        noti?.hidden = true
        view.addSubview(noti!)
        
        webView = UIWebView.init(frame: view.bounds)
        webView!.backgroundColor = UIColor.whiteColor()
        view.addSubview(webView!)
        webView?.delegate = self;
        webView?.hidden = true
        webView!.loadHttpURL(urlString)
    }
    
    // MARK: - 懒加载
    private lazy var menuBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "nav_back"), forState: .Normal)
        btn.frame.size = CGSize(width: 20, height: 20)
        btn.addTarget(self, action: #selector(WXHotDetailViewController.back), forControlEvents: .TouchUpInside)
        return btn
    }()
    
    func back() {
        navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func removeIndCar(){
        indCar?.stopAnimating()
        indCar?.removeFromSuperview()
    }
}

extension WXHotDetailViewController
{
    
    func webViewDidStartLoad(webView: UIWebView){
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView)
    {
        removeIndCar()
        webView.hidden = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?)
    {
        removeIndCar()
        webView.hidden = true
        noti?.hidden = false
    }
}








