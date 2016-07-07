//
//  UILabel+WDY.h
//  IOS_Animations
//
//  Created by wangfang on 16/5/11.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WDY)

/**
 *  将关键字设定为制定的颜色和字体
 *
 *  @param keyWords     关键字列表
 *  @param keyWordfont  字体
 *  @param keyWordColor 颜色
 */
-(void)setKeyWords:(NSArray *)keyWords
              font:(UIFont *)keyWordfont
             color:(UIColor *)keyWordColor;

@end
