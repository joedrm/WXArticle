//
//  UIView+WDY.h
//  WDYSettingDemo
//
//  Created by wangdongyang on 16/6/24.
//  Copyright © 2016年 WDY. All rights reserved.
//

#import <UIKit/UIKit.h>

float radiansForDegrees(int degrees);

@interface UIView (WDY)

#pragma mark - View常见操作
/** 圆角 */
- (void)setCorner;
/** View任意角度的圆角 */
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size;
/** 阴影 */
- (void)setShadow;
/** 获取属于的控制器 */
- (UIViewController*)getControllerHasMe;

//封装了对其子视图层次管理，提供了将控件移到最前面或者最后面，也可以随意调整一个控件的z轴方向的位置。
-(NSUInteger)getSubviewIndex;
-(void)bringToFront;
-(void)sendToBack;
-(void)bringOneLevelUp;
-(void)sendOneLevelDown;
-(BOOL)isInFront;
-(BOOL)isAtBack;
-(void)swapDepthsWithView:(UIView*)swapView;

// 截屏
-(UIImage*)imageByRenderingView;


#pragma mark - View动画

// 位移
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// 形变
/**
 *   旋转
 */
- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
/**
 *  缩放
 */
- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;

/**
 *  顺时针旋转
 *
 *  @param secs 动画执行时间
 */
- (void)spinClockwise:(float)secs;

/**
 *  逆时针旋转
 *
 *  @param secs 动画执行时间
 */
- (void)spinCounterClockwise:(float)secs;


/**
 *  反翻页效果
 *
 *  @param secs 动画执行时间
 */
- (void)curlDown:(float)secs;

/**
 *  视图翻页后消失
 *
 *  @param secs 动画执行时间
 */
- (void)curlUpAndAway:(float)secs;

/**
 *  旋转缩放到一点后消失
 *
 *  @param secs 动画执行时间
 */
- (void)drainAway:(float)secs;

/**
 *  将视图改变到一定透明度
 *
 *  @param newAlpha alpha
 *  @param secs     动画执行时间
 */
- (void)changeAlpha:(float)newAlpha secs:(float)secs;


/**
 *  改变透明度结束动画后还原
 *
 *  @param secs         alpha
 *  @param continuously 是否循环
 */
- (void)pulse:(float)secs continuously:(BOOL)continuously;


/**
 *  以渐变方式添加子控件
 *
 *  @param subview 需要添加的子控件
 */
- (void)addSubviewWithFadeAnimation:(UIView *)subview;
@end
