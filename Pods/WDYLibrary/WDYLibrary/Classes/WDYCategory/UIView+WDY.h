//
//  UIView+WDY.h
//  WDYSettingDemo
//
//  Created by wangdongyang on 16/6/24.
//  Copyright © 2016年 WDY. All rights reserved.
//

#import <UIKit/UIKit.h>

enum JSBorderPosition {
    JSBorderPositionTop,
    JSBorderPositionBottom,
    JSBorderPositionLeft,
    JSBorderPositionRight
};

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

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
-(UIImage*)wdy_screenshot;

// 从nib中加载View
+ (instancetype)wdy_loadInstanceFromNib;
+ (instancetype)wdy_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)wdy_loadInstanceFromNibWithName:(NSString *)nibName owner:(nullable id)owner;
+ (instancetype)wdy_loadInstanceFromNibWithName:(NSString *)nibName owner:(nullable id)owner bundle:(NSBundle *)bundle;


#pragma mark- block gesture

- (void)addTapActionWithBlock:(GestureActionBlock)block;
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;


#pragma mark- 边框
/**
 *  添加边框:四边
 */
- (void)addOneRetinaPixelBorder;
- (void)addOneRetinaPixelBorderWithColor:(UIColor*)color andRadius:(CGFloat)radius;
- (void)addBorderWithColor:(UIColor *)color andWidth:(float)lineWidth andRadius:(CGFloat)radius;
/**
 *  添加1px边框：一边
 *
 *  @param position 需要添加边框的一边
 */
- (void)addOneRetinaPixelLineAtPosition:(enum JSBorderPosition)position;
- (void)addOneRetinaPixelLineWithColor:(UIColor*)color atPosition:(enum JSBorderPosition)position;
/**
 *  添加边框：一边
 *
 *  @param position 需要添加边框的一边
 */
- (void)addLineWithWidth:(float)lineWidth atPosition:(enum JSBorderPosition)position;
- (void)addLineWithColor:(UIColor*)color andWidth:(float)lineWidth atPosition:(enum JSBorderPosition)position;
/**
 *  移除边框
 */
- (void)removeBorderAtPosition:(enum JSBorderPosition)position;
- (void)removeAllBorders;

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
