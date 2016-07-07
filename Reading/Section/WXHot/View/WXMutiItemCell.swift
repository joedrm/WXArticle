//
//  WXMutiItemCell.swift
//  Reading
//
//  Created by wangdongyang on 16/7/2.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit
import WDYLibrary

class WXMutiItemCell: UITableViewCell {

    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        contentLabel.font = UIFont.systemFontOfSize(14)
        picImageView.layer.cornerRadius = 3.0
        picImageView.clipsToBounds = true
    }

    var articile : WXArticleItem?
        {
        didSet{
            if let art = articile {
                let picUrl = NSURL.init(string: art.contentImg!, relativeToURL: nil)
                picImageView.sd_setImageWithURL(picUrl, fadeAnimation: true)
                contentLabel.text = art.title!
                userNameLabel.text = "来自:"+art.userName!
                
                let mdate = NSDate.init(string: art.date!, format:"yyyy-MM-dd HH:mm:ss")
                createDateLabel.text = mdate!.stringWithTimelineDate()
            }
        }
    }
    
}
