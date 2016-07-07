//
//  NSBundle+WDY.h
//  IOS_Animations
//
//  Created by wangfang on 16/5/10.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSBundle (WDY)

/**
 *  获得资源图片
 *
 *  @param name 图片名
 *
 *  @return 付汇图片
 */
+ (UIImage *)imageNamed:(NSString *)name;

/**
 *  获取沙盒文件
 *
 *  @param name    文件名
 *  @param owner   <#owner description#>
 *  @param options <#options description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray *)loadNibNamed:(NSString *)name
                    owner:(id)owner
                  options:(NSDictionary *)options;
@end
