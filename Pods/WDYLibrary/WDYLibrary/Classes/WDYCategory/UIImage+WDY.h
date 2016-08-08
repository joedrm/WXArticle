//
//  UIImage+WDY.h
//  IOS_Animations
//
//  Created by wangfang on 16/5/10.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDYCategoryHeader.h"
#import <AssetsLibrary/AssetsLibrary.h>

static const void *CompleteBlockKey = &CompleteBlockKey;
static const void *FailBlockKey = &FailBlockKey;

@interface UIImage ()

@property (nonatomic,copy)  void(^CompleteBlock)();

@property (nonatomic,copy)  void(^FailBlock)();

@end

// 水印方向
typedef NS_ENUM(NSInteger, ImageWaterDirect) {
    ImageWaterDirectTopLeft = 0,//左上
    ImageWaterDirectTopRight,//右上
    ImageWaterDirectBottomLeft,//左下
    ImageWaterDirectBottomRight,//右下
    ImageWaterDirectCenter//正中
};

@interface UIImage (WDY)

// ------ 截屏/截部分视图
+ (UIImage *)captureWithView:(UIView *)view;
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

// ------ 纯色图片
+ (UIImage *)coloreImage:(UIColor *)color;
+ (UIImage *)coloreImage:(UIColor *)color size:(CGSize)size;

// ------ 按固定的最大比例压缩图片
- (UIImage *)allowMaxImg;
- (UIImage *)allowMaxImg_thum:(BOOL)thumbnail;

// ------ 图片要求的最大长宽
- (CGSize)reSetMaxWH:(CGFloat)WH;
- (UIImage *)resize_Rate:(CGFloat)rate; //按比例 重设图片大小
- (UIImage *)resize_Quality:(CGInterpolationQuality)quality Rate:(CGFloat)rate;//按比例 质量 重设图片大小

// ------ 保存到相册
// 保存到指定相册名字
- (void)savedToAlbum_AlbumName:(NSString *)AlbumName sucBlack:(void (^)())completeBlock failBlock:(void (^)())failBlock;
- (void)savedToAlbum:(void (^)())completeBlock failBlock:(void (^)())failBlock;//保存到相册

// ------ 给图片家水印
- (UIImage *)waterWithText:(NSString *)text
                 direction:(ImageWaterDirect)direction
                 fontColor:(UIColor *)fontColor
                 fontPoint:(CGFloat)fontPoint
                  marginXY:(CGPoint)marginXY;
- (UIImage *)waterWithWaterImage:(UIImage *)waterImage
                       direction:(ImageWaterDirect)direction
                       waterSize:(CGSize)waterSize
                        marginXY:(CGPoint)marginXY;

// ------ 调整图片
- (UIImage *)fixOrientation;
+ (UIImage *)resizedImageWithName:(NSString *)name; // 返回一张自由拉伸的图片
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

// ------ 根据颜色返回图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

// ------ 返回一张圆形图片
/**
 * 返回一张圆形图片
 */
- (UIImage*)circleImage;
+ (UIImage*)circleImageNamed:(NSString *)name;
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

// ------ 返回一张拉伸的图片
+ (UIImage *)resizableImageWithName:(NSString *)imageName;

// ------ 对图片尺寸进行压缩处理
-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
-(UIImage*)scaledToMaxSize:(CGSize )size;
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset;

// ------ 将image转90,180,270度的方法
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
@end
















