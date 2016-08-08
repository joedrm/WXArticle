//
//  UILabel+WDY.m
//  IOS_Animations
//
//  Created by wangfang on 16/5/11.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import "UILabel+WDY.h"
#import "WDYCategoryHeader.h"

@implementation UILabel (WDY)

-(void)wdy_setKeyWords:(NSArray *)keyWords font:(UIFont *)keyWordfont color:(UIColor *)keyWordColor {
    
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

- (CGFloat)wdy_calculateHeight
{
    return [self.text heightWithFont:self.font constrainedToWidth:self.wdy_width];
}

- (CGSize)wdy_calculateSize
{
    return [self.text sizeWithFont:self.font constrainedToWidth:self.wdy_width];
}

- (void)wdy_addHorizontalLineWithColor:(UIColor *)lineColor lineTextColor:(UIColor *)lineTextColor range:(NSRange)range
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    UIColor *textColor = nil;
    lineTextColor == nil ? (textColor = self.textColor) : (textColor = lineTextColor);
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    [attributedString addAttribute:NSStrikethroughColorAttributeName value:lineColor range:range];
    self.attributedText = attributedString;
}
@end
