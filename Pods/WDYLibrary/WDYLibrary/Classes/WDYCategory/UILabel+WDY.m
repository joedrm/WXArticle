//
//  UILabel+WDY.m
//  IOS_Animations
//
//  Created by wangfang on 16/5/11.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import "UILabel+WDY.h"

@implementation UILabel (WDY)

-(void)setKeyWords:(NSArray *)keyWords font:(UIFont *)keyWordfont color:(UIColor *)keyWordColor {
    
    if (keyWords == nil) {
        return;
    }
    
    UIFont * currentFont = nil;
    if (keyWordfont == nil) {
        currentFont = self.font;
    } else {
        currentFont = keyWordfont;
    }
    
    UIColor * currentColor = nil;
    if (keyWordColor == nil) {
        currentColor = self.textColor;
    } else {
        currentColor = keyWordColor;
    }
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSMutableArray *rangeArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [keyWords count]; i++) {
        NSString *keyString = [keyWords objectAtIndex:i];
        NSRange range = [self.text rangeOfString:keyString];
        NSValue *value = [NSValue valueWithRange:range];
        if (range.length > 0) {
            [rangeArray addObject:value];
        }
    }
    
    for (NSValue *value in rangeArray) {
        NSRange keyRange = [value rangeValue];
        [attributedString addAttribute:NSForegroundColorAttributeName value:currentColor range:keyRange];
        [attributedString addAttribute:NSFontAttributeName value:currentFont range:keyRange];
    }
    self.attributedText = attributedString;
    
    
}


@end
