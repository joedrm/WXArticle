//
//  UIView+WDY.m
//  WDYSettingDemo
//
//  Created by wangdongyang on 16/6/24.
//  Copyright © 2016年 WDY. All rights reserved.
//

#import "UIView+WDY.h"
#import <objc/runtime.h>
// Very helpful function

float radiansForDegrees(int degrees) {
    return degrees * M_PI / 180;
}

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;

@implementation UIView (WDY)

#pragma mark - 常见操作

- (void)setCorner
{
    self.layer.masksToBounds = YES;
    
    [[self layer] setBorderWidth:2.0];//画线的宽度
    [[self layer] setBorderColor:[UIColor blueColor].CGColor];//颜色
    [[self layer] setCornerRadius:15.0];//圆角
}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size
{
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer* maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}



- (void)setShadow
{
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 0.80;
}

- (UIViewController*)getControllerHasMe
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            UIViewController *controller = (UIViewController*)nextResponder;
            
            return controller;
        }
    }
    return nil;
}


#pragma mark - UIView  封装了对其子视图层次管理，提供了将控件移到最前面或者最后面，也可以随意调整一个控件的z轴方向的位置。

-(NSUInteger)getSubviewIndex
{
    return [self.superview.subviews indexOfObject:self];
}

-(void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}

-(void)sendToBack
{
    [self.superview sendSubviewToBack:self];
}

-(void)bringOneLevelUp
{
    int currentIndex = (int)[self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

-(void)sendOneLevelDown
{
    int currentIndex = (int)[self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

-(BOOL)isInFront
{
    return ([self.superview.subviews lastObject]==self);
}

-(BOOL)isAtBack
{
    return ([self.superview.subviews objectAtIndex:0]==self);
}

-(void)swapDepthsWithView:(UIView*)swapView
{
    [self.superview exchangeSubviewAtIndex:[self getSubviewIndex] withSubviewAtIndex:[swapView getSubviewIndex]];
}

#pragma mark - 截屏
-(UIImage*)wdy_screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0f);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (instancetype)wdy_loadInstanceFromNib
{
    return [self wdy_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)wdy_loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self wdy_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)wdy_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self wdy_loadInstanceFromNibWithName:nibName owner:nil bundle:[NSBundle mainBundle]];
}
+ (instancetype)wdy_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    NSArray *nibViews = [bundle loadNibNamed:nibName owner:owner options:nil];
    UIView *curMainView = nil;
    for (id curObj in nibViews) {
        if ([curObj isKindOfClass:[self class]]) {
            curMainView = curObj;
            break;
        }
    }
    return curMainView;
}

#pragma mark- block gesture
- (void)addTapActionWithBlock:(GestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
- (void)addLongPressActionWithBlock:(GestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

#pragma mark-  border
#pragma mark complete border

- (void)addOneRetinaPixelBorder {
    double retinaPixelSize = 1./[UIScreen mainScreen].scale;
    [self addOneRetinaPixelBorderWithColor:self.defaultBorderColor andRadius:retinaPixelSize];
}

- (void)addOneRetinaPixelBorderWithColor:(UIColor*)color andRadius:(CGFloat)radius{
    double retinaPixelSize = 1./[UIScreen mainScreen].scale;
    [self addBorderWithColor:color andWidth:retinaPixelSize andRadius:radius];
}

- (void)addBorderWithColor:(UIColor *)color andWidth:(float)lineWidth andRadius:(CGFloat)radius{
    self.layer.borderWidth = lineWidth;
    self.layer.borderColor = color.CGColor;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

/**
 *  添加边框
 */

static UIColor* _defaultBorderColor;

- (void)setDefaultBorderColor:(UIColor *)defaultBorderColor {
    _defaultBorderColor = defaultBorderColor;
}

- (UIColor *)defaultBorderColor {
    if (!_defaultBorderColor) {
        if ([self respondsToSelector:@selector(tintColor)]) {
            return self.tintColor;
        } else {
            return [UIColor blueColor];
        }
    } else {
        return _defaultBorderColor;
    }
}

#pragma mark  single side border

- (void)addOneRetinaPixelLineAtPosition:(enum JSBorderPosition)position {
    [self addOneRetinaPixelLineWithColor:self.defaultBorderColor atPosition:position];
}

- (void)addOneRetinaPixelLineWithColor:(UIColor*)color atPosition:(enum JSBorderPosition)position {
    
    double retinaPixelSize = 1./[UIScreen mainScreen].scale;
    [self addLineWithColor:color andWidth:retinaPixelSize atPosition:position];
}

- (void)addLineWithWidth:(float)lineWidth atPosition:(enum JSBorderPosition)position {
    [self addLineWithColor:self.defaultBorderColor andWidth:lineWidth atPosition:position];
}

- (void)addLineWithColor:(UIColor*)color andWidth:(float)lineWidth atPosition:(enum JSBorderPosition)position {
    
    // min lineweight is one logical device pixel
    double retinaPixelSize = 1./[UIScreen mainScreen].scale;
    lineWidth = MAX(retinaPixelSize, lineWidth);
    
    CALayer *border = [CALayer layer];
    switch (position) {
        case JSBorderPositionTop:
            border.frame = CGRectMake(0, 0, self.frame.size.width, lineWidth);
            break;
            
        case JSBorderPositionBottom:
            border.frame = CGRectMake(0, self.frame.size.height-lineWidth, self.frame.size.width, lineWidth);
            break;
            
        case JSBorderPositionLeft:
            border.frame = CGRectMake(0, 0, lineWidth, self.frame.size.height);
            break;
            
        case JSBorderPositionRight:
            border.frame = CGRectMake(self.frame.size.width-lineWidth, 0, lineWidth, self.frame.size.height);
            break;
    }
    
    border.backgroundColor = color.CGColor;
    
    [self removeBorderAtPosition:position];
    [border setValue:@([self tagForPosition:position]) forKey:@"tag"];
    [self.layer addSublayer:border];
}


- (int)tagForPosition:(enum JSBorderPosition)position {
    
    int tag = 32147582;
    
    switch (position) {
        case JSBorderPositionTop:    return tag;
        case JSBorderPositionBottom: return tag + 1;
        case JSBorderPositionLeft:   return tag + 2;
        case JSBorderPositionRight:  return tag + 3;
    }
    
    NSAssert(NO, @"invalid position");
    return 0;
}

- (void)removeBorderAtPosition:(enum JSBorderPosition)position {
    
    int tag = [self tagForPosition:position];
    
    __block CALayer *toRemove;
    
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer *layer, NSUInteger idx, BOOL *stop) {
        if ([[layer valueForKey:@"tag"] intValue] == tag) {
            *stop = YES;
            toRemove = layer;
        }
    }];
    
    [toRemove removeFromSuperlayer];
}

- (void)removeAllBorders {
    
    [self removeBorderAtPosition:JSBorderPositionTop];
    [self removeBorderAtPosition:JSBorderPositionBottom];
    [self removeBorderAtPosition:JSBorderPositionLeft];
    [self removeBorderAtPosition:JSBorderPositionRight];
}




#pragma mark - View的动画


#pragma mark - Moves

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option {
    [self moveTo:destination duration:secs option:option delegate:nil callback:nil];
}

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                             
                         }
                     }];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack {
    [self raceTo:destination withSnapBack:withSnapBack delegate:nil callback:nil];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method {
    CGPoint stopPoint = destination;
    if (withSnapBack) {
        // Determine our stop point, from which we will "snap back" to the final destination
        int diffx = destination.x - self.frame.origin.x;
        int diffy = destination.y - self.frame.origin.y;
        if (diffx < 0) {
            // Destination is to the left of current position
            stopPoint.x -= 10.0;
        } else if (diffx > 0) {
            stopPoint.x += 10.0;
        }
        if (diffy < 0) {
            // Destination is to the left of current position
            stopPoint.y -= 10.0;
        } else if (diffy > 0) {
            stopPoint.y += 10.0;
        }
    }
    
    // Do the animation
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.frame = CGRectMake(stopPoint.x, stopPoint.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (withSnapBack) {
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
                                              }
                                              completion:^(BOOL finished) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                                  [delegate performSelector:method];
#pragma clang diagnostic pop
                                                  
                                              }];
                         } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                         }
                     }];
}


#pragma mark - Transforms

- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(degrees));
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                         }
                     }];
}

- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformScale(self.transform, scaleX, scaleY);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                         }
                     }];
}

- (void)spinClockwise:(float)secs {
    [UIView animateWithDuration:secs/4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(90));
                     }
                     completion:^(BOOL finished) {
                         [self spinClockwise:secs];
                     }];
}

- (void)spinCounterClockwise:(float)secs {
    [UIView animateWithDuration:secs/4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(270));
                     }
                     completion:^(BOOL finished) {
                         [self spinCounterClockwise:secs];
                     }];
}


#pragma mark - Transitions

- (void)curlDown:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setAlpha:1.0]; }
                    completion:nil];
}

- (void)curlUpAndAway:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self setAlpha:0]; }
                    completion:nil];
}

- (void)drainAway:(float)secs {
    self.tag = 20;
    [NSTimer scheduledTimerWithTimeInterval:secs/50 target:self selector:@selector(drainTimer:) userInfo:nil repeats:YES];
}

- (void)drainTimer:(NSTimer*)timer {
    CGAffineTransform trans = CGAffineTransformRotate(CGAffineTransformScale(self.transform, 0.9, 0.9),0.314);
    self.transform = trans;
    self.alpha = self.alpha * 0.98;
    self.tag = self.tag - 1;
    if (self.tag <= 0) {
        [timer invalidate];
        [self removeFromSuperview];
    }
}

#pragma mark - Effects

- (void)changeAlpha:(float)newAlpha secs:(float)secs {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = newAlpha;
                     }
                     completion:nil];
}

- (void)pulse:(float)secs continuously:(BOOL)continuously {
    [UIView animateWithDuration:secs/2
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // Fade out, but not completely
                         self.alpha = 0.3;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:secs/2
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              // Fade in
                                              self.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished) {
                                              if (continuously) {
                                                  [self pulse:secs continuously:continuously];
                                              }
                                          }];
                     }];
}
#pragma mark - add subview

- (void)addSubviewWithFadeAnimation:(UIView *)subview {
    
    CGFloat finalAlpha = subview.alpha;
    
    subview.alpha = 0.0;
    [self addSubview:subview];
    [UIView animateWithDuration:0.2 animations:^{
        subview.alpha = finalAlpha;
    }];
}


@end
