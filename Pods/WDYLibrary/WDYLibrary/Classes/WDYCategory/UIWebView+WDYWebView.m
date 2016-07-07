//
//  UIWebView+WDYWebView.m
//  Youka
//
//  Created by wangfang on 16/5/10.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import "UIWebView+WDYWebView.h"

@implementation UIWebView (WDYWebView)

/**
 *  @brief  读取一个网页地址
 *
 *  @param URLString 网页地址
 */
- (void) loadHttpURL:(NSString *)URLString {
    NSString *encodedUrl = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                        (__bridge CFStringRef)URLString,
                                                                                        NULL, NULL,
                                                                                        kCFStringEncodingUTF8);
    NSURL *url = [NSURL URLWithString:encodedUrl];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [self loadRequest:req];
}

/**
 *  @brief  读取bundle中的webview
 *
 *  @param htmlName webview名称
 */
- (void) loadLocalHtml:(NSString *)htmlName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self loadRequest:request];
}

/**
 *  @brief  清空cookie
 */
- (void) clearCookies {
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    
    for (NSHTTPCookie *cookie in storage.cookies) {
        [storage deleteCookie:cookie];
    }
    
    [NSUserDefaults.standardUserDefaults synchronize];
}

@end
