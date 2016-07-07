//
//  BaseSettingCell.h
//  Youka
//
//  Created by wangfang on 15/11/24.
//  Copyright © 2015年 LeSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SetRect)

// Frame
@property (nonatomic) CGPoint wdy_viewOrigin;
@property (nonatomic) CGSize  wdy_viewSize;

// Frame Origin
@property (nonatomic) CGFloat wdy_x;
@property (nonatomic) CGFloat wdy_y;

// Frame Size
@property (nonatomic) CGFloat wdy_width;
@property (nonatomic) CGFloat wdy_height;

// Frame Borders
@property (nonatomic) CGFloat wdy_top;
@property (nonatomic) CGFloat wdy_left;
@property (nonatomic) CGFloat wdy_bottom;
@property (nonatomic) CGFloat wdy_right;

// Center Point
#if !IS_IOS_DEVICE
@property (nonatomic) CGPoint wdy_center;
#endif
@property (nonatomic) CGFloat wdy_centerX;
@property (nonatomic) CGFloat wdy_centerY;

// Middle Point
@property (nonatomic, readonly) CGPoint wdy_middlePoint;
@property (nonatomic, readonly) CGFloat wdy_middleX;
@property (nonatomic, readonly) CGFloat wdy_middleY;

@end
