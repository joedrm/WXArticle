//
//  UIView+SetRect.m
//
//  BaseSettingCell.h
//  Youka
//
//  Created by wangfang on 15/11/24.
//  Copyright © 2015年 LeSheng. All rights reserved.
//

#import "UIView+SetRect.h"

@implementation UIView (SetRect)

#pragma mark Frame

- (CGPoint)wdy_viewOrigin {
    
    return self.frame.origin;
}

- (void)setWdy_viewOrigin:(CGPoint)wdy_viewOrigin {
    
    CGRect newFrame = self.frame;
    newFrame.origin = wdy_viewOrigin;
    self.frame      = newFrame;
}

- (CGSize)wdy_viewSize {
    
    return self.frame.size;
}

- (void)setWdy_viewSize:(CGSize)wdy_viewSize {
    CGRect newFrame = self.frame;
    newFrame.size   = wdy_viewSize;
    self.frame      = newFrame;
}

#pragma mark Frame Origin

- (CGFloat)wdy_x {
    
    return self.frame.origin.x;
}

- (void)setWdy_x:(CGFloat)wdy_x{
    
    CGRect newFrame   = self.frame;
    newFrame.origin.x = wdy_x;
    self.frame        = newFrame;
}

- (CGFloat)wdy_y {
    
    return self.frame.origin.y;
}

- (void)setWdy_y:(CGFloat)wdy_y {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.y = wdy_y;
    self.frame        = newFrame;
}

#pragma mark Frame Size

- (CGFloat)wdy_height {
    
    return self.frame.size.height;
}

- (void)setWdy_height:(CGFloat)wdy_height {
    
    CGRect newFrame      = self.frame;
    newFrame.size.height = wdy_height;
    self.frame           = newFrame;
}

- (CGFloat)wdy_width {
    
    return self.frame.size.width;
}

- (void)setWdy_width:(CGFloat)wdy_width {
    
    CGRect newFrame     = self.frame;
    newFrame.size.width = wdy_width;
    self.frame          = newFrame;
}

#pragma mark Frame Borders

- (CGFloat)wdy_left {
    
    return self.wdy_x;
}

- (void)setWdy_left:(CGFloat)wdy_left {
    
    self.wdy_x = wdy_left;
}

- (CGFloat)wdy_right {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWdy_right:(CGFloat)wdy_right{
    
    self.wdy_x = wdy_right - self.wdy_width;
}

- (CGFloat)wdy_top {
    
    return self.wdy_y;
}

- (void)setWdy_top:(CGFloat)wdy_top {
    
    self.wdy_y = wdy_top;
}

- (CGFloat)wdy_bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setWdy_bottom:(CGFloat)wdy_bottom {
    
    self.wdy_y = wdy_bottom - self.wdy_height;
}

#pragma mark Center Point

#if !IS_IOS_DEVICE
- (CGPoint)wdy_center {
    
    return CGPointMake(self.wdy_left + self.wdy_middleX, self.wdy_top + self.wdy_middleY);
}

- (void)setWdy_center:(CGPoint)wdy_center {
    
    self.wdy_left = wdy_center.x - self.wdy_middleX;
    self.wdy_top  = wdy_center.y - self.wdy_middleY;
}
#endif

- (CGFloat)wdy_centerX {
    
    return self.center.x;
}

- (void)setWdy_centerX:(CGFloat)wdy_centerX {
    
    self.center = CGPointMake(wdy_centerX, self.center.y);
}

- (CGFloat)wdy_centerY {
    
    return self.center.y;
}

- (void)setWdy_centerY:(CGFloat)wdy_centerY {
    
    self.center = CGPointMake(self.center.x, wdy_centerY);
}

#pragma mark Middle Point

- (CGPoint)wdy_middlePoint {
    
    return CGPointMake(self.wdy_middleX, self.wdy_middleY);
}

- (CGFloat)wdy_middleX {
    
    return self.wdy_width / 2;
}

- (CGFloat)wdy_middleY {
    
    return self.wdy_height / 2;
}

@end
