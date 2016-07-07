//
//  UIWebView+WDYWebView.h
//  Youka
//
//  Created by wangfang on 16/5/10.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (WDYWebView)
/**
 *  @brief  读取一个网页地址
 *
 *  @param URLString 网页地址
 */
- (void)loadHttpURL:(NSString*)URLString;
/**
 *  @brief  读取bundle中的webview
 *
 *  @param htmlName webview名称
 */
- (void)loadLocalHtml:(NSString*)htmlName;
/**
 *  @brief  清空cookie
 */
- (void)clearCookies;
@end
