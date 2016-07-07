//
//  UIImageView+WDY.h
//  Pods
//
//  Created by wangdongyang on 16/6/28.
//
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImageCompat.h>
#import <SDWebImage/SDWebImageManager.h>

typedef void(^WDYBlurredImageCompletionBlock)(void);

extern CGFloat const kWDYBlurredImageDefaultBlurRadius;

@interface UIImageView (WDY)

// ------ 设置半透明模糊效果
- (void)setImageToBlur:(UIImage *)image blurRadius:(CGFloat)blurRadius completionBlock:(WDYBlurredImageCompletionBlock)completion;
- (void)setImageToBlur:(UIImage *)image completionBlock:(WDYBlurredImageCompletionBlock)completion;

@end

// ------ 从网络加载图片，各种动画效果
@interface UIImageView (AnimationForSDWebImage)

- (NSURL *)sd_imageURL;

- (void)sd_setImageWithURL:(NSURL *)url fadeAnimation:(BOOL)fadeAnimation;

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder fadeAnimation:(BOOL)fadeAnimation;

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options fadeAnimation:(BOOL)fadeAnimation;

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock fadeAnimation:(BOOL)fadeAnimation;

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock fadeAnimation:(BOOL)fadeAnimation;

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock fadeAnimation:(BOOL)fadeAnimation;

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock fadeAnimation:(BOOL)fadeAnimation;

- (void)sd_setImageWithPreviousCachedImageWithURL:(NSURL *)url andPlaceholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock fadeAnimation:(BOOL)fadeAnimation;

- (void)sd_setAnimationImagesWithURLs:(NSArray *)arrayOfURLs;

- (void)sd_cancelCurrentImageLoad;

- (void)sd_cancelCurrentAnimationImagesLoad;

@end
