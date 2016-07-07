//
//  WXHotCell.swift
//  Reading
//
//  Created by wangdongyang on 16/7/1.
//  Copyright © 2016年 wdy. All rights reserved.
//

import UIKit
import WDYLibrary

class WXHotCell: UITableViewCell {

    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var contentLabelView: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabelView.font = UIFont.systemFontOfSize(14)
        picImageView.layer.cornerRadius = 3.0
        picImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var hotItem : WXHotItem?
        {
        didSet{
            if let art = hotItem {
                let picUrl = NSURL.init(string: art.picUrl!, relativeToURL: nil)
                picImageView.sd_setImageWithURL(picUrl, fadeAnimation: true)
                titleLabelView.text = art.title!
                contentLabelView.text = "来自："+art.des!
                timeLabel.text = art.ctime!
            }
        }
    }
    
}
