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
-(void)wdy_setKeyWords:(NSArray *)keyWords
              font:(UIFont *)keyWordfont
             color:(UIColor *)keyWordColor;

/**
 *  根据文本计算Label的高度
 *
 *  @return 文本的高度
 */
- (CGFloat)wdy_calculateHeight;

/**
 *  根据文本计算Label的尺寸
 *
 *  @return 文本的尺寸
 */
- (CGSize)wdy_calculateSize;

/**
 *  为UILabel添加中划线
 *
 *  @param lineColor     划线颜色
 *  @param lineTextColor 划线文本颜色
 *  @param range         划线范围
 */
- (void)wdy_addHorizontalLineWithColor:(UIColor *)lineColor lineTextColor:(UIColor *)lineTextColor range:(NSRange)range;
@end
