//
//  CALayer+WDY.m
//  IOS_Animations
//
//  Created by wangfang on 16/5/10.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import "CALayer+WDY.h"
@implementation CALayer (WDY)

#pragma mark Frame

- (CGPoint)viewOrigin {
    
    return self.frame.origin;
}

- (void)setViewOrigin:(CGPoint)newOrigin {
    
    CGRect newFrame = self.frame;
    newFrame.origin = newOrigin;
    self.frame      = newFrame;
}

- (CGSize)viewSize {
    
    return self.frame.size;
}

- (void)setViewSize:(CGSize)newSize {
    CGRect newFrame = self.frame;
    newFrame.size   = newSize;
    self.frame      = newFrame;
}

#pragma mark Frame Origin

- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)newX {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.x = newX;
    self.frame        = newFrame;
}

- (CGFloat)y {
    
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.y = newY;
    self.frame        = newFrame;
}

#pragma mark Frame Size

- (CGFloat)height {
    
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newHeight {
    
    CGRect newFrame      = self.frame;
    newFrame.size.height = newHeight;
    self.frame           = newFrame;
}

- (CGFloat)width {
    
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newWidth {
    
    CGRect newFrame     = self.frame;
    newFrame.size.width = newWidth;
    self.frame          = newFrame;
}

#pragma mark Frame Borders

- (CGFloat)left {
    
    return self.x;
}

- (void)setLeft:(CGFloat)left {
    
    self.x = left;
}

- (CGFloat)right {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    
    self.x = right - self.width;
}

- (CGFloat)top {
    
    return self.y;
}

- (void)setTop:(CGFloat)top {
    
    self.y = top;
}

- (CGFloat)bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    
    self.y = bottom - self.height;
}

#pragma mark Center Point

#if !IS_IOS_DEVICE
- (CGPoint)center {
    
    return CGPointMake(self.left + self.middleX, self.top + self.middleY);
}

- (void)setCenter:(CGPoint)newCenter {
    
    self.left = newCenter.x - self.middleX;
    self.top  = newCenter.y - self.middleY;
}
#endif

- (CGFloat)centerX {
    
    return self.center.x;
}

- (void)setCenterX:(CGFloat)newCenterX {
    
    self.center = CGPointMake(newCenterX, self.center.y);
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (void)setCenterY:(CGFloat)newCenterY {
    
    self.center = CGPointMake(self.center.x, newCenterY);
}

#pragma mark Middle Point

- (CGPoint)middlePoint {
    
    return CGPointMake(self.middleX, self.middleY);
}

- (CGFloat)middleX {
    
    return self.width / 2;
}

- (CGFloat)middleY {
    
    return self.height / 2;
}


#pragma mark - Animation

/**
 *  颤抖效果
 */
-(CAAnimation *)shakeFunction{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    [self addAnimation:shake forKey:nil];
    return shake;
}

/**
 *  渐显效果
 */
-(CATransition*)fadeFunction{
    return [self fadeFunction:0.4];
}

/**
 *  渐显效果 效果时间
 */
-(CATransition*)fadeFunction:(CGFloat)time{
    CATransition *animation = [CATransition animation];
    [animation setDuration:time];
    [animation setType: kCATransitionFade];
    [animation setSubtype: kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self addAnimation:animation forKey:nil];
    return animation;
}

/**
 *  缩放效果
 */
-(CAKeyframeAnimation *)transformScaleFunction{
    CAKeyframeAnimation *transformscale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    transformscale.values = @[@(0),@(0.5),@(1.08)];
    transformscale.keyTimes = @[@(0.0),@(0.2),@(0.3)];
    transformscale.calculationMode = kCAAnimationLinear;
    [self addAnimation:transformscale forKey:nil];
    return transformscale;
}

/**
 *  简3D动画吧
 */
-(CAAnimation *)anim_revers:(AnimReverDirection)direction duration:(NSTimeInterval)duration isReverse:(BOOL)isReverse repeatCount:(NSUInteger)repeatCount{
    NSString *key = @"reversAnim";
    if([self animationForKey:key]!=nil){
        [self removeAnimationForKey:key];
    }
    NSString *directionStr = nil;
    if(AnimReverDirectionX == direction)directionStr=@"x";
    if(AnimReverDirectionY == direction)directionStr=@"y";
    if(AnimReverDirectionZ == direction)directionStr=@"z";
    //创建普通动画
    CABasicAnimation *reversAnim = [CABasicAnimation animationWithKeyPath:[NSString stringWithFormat:@"transform.rotation.%@",directionStr]];
    //起点值
    reversAnim.fromValue=@(0);
    //终点值
    reversAnim.toValue = @(M_PI_2);
    //时长
    reversAnim.duration = duration;
    //自动反转
    reversAnim.autoreverses = isReverse;
    //完成删除
    reversAnim.removedOnCompletion = YES;
    //重复次数
    reversAnim.repeatCount = repeatCount;
    //添加
    [self addAnimation:reversAnim forKey:key];
    
    return reversAnim;
}


@end
