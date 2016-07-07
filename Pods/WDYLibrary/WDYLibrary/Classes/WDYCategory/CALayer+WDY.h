//
//  CALayer+WDY.h
//  IOS_Animations
//
//  Created by wangfang on 16/5/10.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

/**
 *  反转方向
 */
typedef NS_ENUM(NSInteger, AnimReverDirection) {
    AnimReverDirectionX=0,
    AnimReverDirectionY,
    AnimReverDirectionZ,
};


@interface CALayer (WDY)

// Frame
@property (nonatomic) CGPoint viewOrigin;
@property (nonatomic) CGSize  viewSize;

// Frame Origin
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

// Frame Size
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

// Frame Borders
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;

// Center Point
#if !IS_IOS_DEVICE
@property (nonatomic) CGPoint center;
#endif
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

// Middle Point
@property (nonatomic, readonly) CGPoint middlePoint;
@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;

/** 颤抖效果 */
-(CAAnimation *)shakeFunction;

/** 渐显效果 */
-(CATransition*)fadeFunction;

/** 渐显效果 效果时间 */
-(CATransition*)fadeFunction:(CGFloat)time;

/** 缩放效果 */ 
-(CAKeyframeAnimation *)transformScaleFunction;

/**
 *  3D动画
 *
 *  @param direction   方向
 *  @param duration    持续时长
 *  @param isReverse   是否翻转
 *  @param repeatCount 重复次数
 *
 *  @return CAAnimation
 */
- (CAAnimation *)anim_revers:(AnimReverDirection)direction
                    duration:(NSTimeInterval)duration
                   isReverse:(BOOL)isReverse
                 repeatCount:(NSUInteger)repeatCount;


@end
