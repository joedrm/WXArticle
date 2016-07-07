//
//  UIImageView+WDY.m
//  Pods
//
//  Created by wangdongyang on 16/6/28.
//
//

#import "UIImageView+WDY.h"
#import "UIImage+ImageEffects.h"

CGFloat const kWDYBlurredImageDefaultBlurRadius            = 20.0;
CGFloat const kWDYBlurredImageDefaultSaturationDeltaFactor = 1.8;

@implementation UIImageView (WDY)

- (void)setImageToBlur:(UIImage *)image
       completionBlock:(WDYBlurredImageCompletionBlock)completion
{
    [self setImageToBlur:image
              blurRadius:kWDYBlurredImageDefaultBlurRadius
         completionBlock:completion];
}

- (void)setImageToBlur:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
       completionBlock:(WDYBlurredImageCompletionBlock) completion
{
    NSParameterAssert(image);
    blurRadius = (blurRadius <= 0) ? kWDYBlurredImageDefaultBlurRadius : blurRadius;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *blurredImage = [image applyBlurWithRadius:blurRadius tintColor:nil saturationDeltaFactor:kWDYBlurredImageDefaultSaturationDeltaFactor maskImage:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = blurredImage;
            if (completion) {
                completion();
            }
        });
    });
}

#pragma mark - 从网络加载图片



@end

//#import "UIImageView+AnimationForSDWebImage.h"
#import "UIView+WebCacheOperation.h"
#import "objc/runtime.h"

static char imageURLKey;
@implementation UIImageView (AnimationForSDWebImage)
- (void)sd_setImageWithURL:(NSURL *)url fadeAnimation:(BOOL)fadeAnimation{
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil fadeAnimation:fadeAnimation];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder fadeAnimation:(BOOL)fadeAnimation{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil fadeAnimation:fadeAnimation];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options fadeAnimation:(BOOL)fadeAnimation{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil fadeAnimation:fadeAnimation];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock fadeAnimation:(BOOL)fadeAnimation{
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock fadeAnimation:fadeAnimation];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock fadeAnimation:(BOOL)fadeAnimation{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock fadeAnimation:fadeAnimation];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock fadeAnimation:(BOOL)fadeAnimation{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock fadeAnimation:fadeAnimation];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock fadeAnimation:(BOOL)fadeAnimation{
    [self sd_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!(options & SDWebImageDelayPlaceholder)) {
        self.image = placeholder;
    }
    
    if (url) {
        __weak UIImageView *wself = self;
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (image) {
                    wself.image = image;
                    if (fadeAnimation == YES) {
                        if(image && cacheType == SDImageCacheTypeNone){
                            CATransition *transition = [CATransition animation];
                            transition.type = kCATransitionFade; // there are other types but this is the nicest
                            transition.duration = 0.34; // set the duration that you like
                            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                            [self.layer addAnimation:transition forKey:nil];
                        }
                    }
                    
                    [wself setNeedsLayout];
                } else {
                    if ((options & SDWebImageDelayPlaceholder)) {
                        wself.image = placeholder;
                        
                        if (fadeAnimation == YES) {
                            if(image && cacheType == SDImageCacheTypeNone){
                                CATransition *transition = [CATransition animation];
                                transition.type = kCATransitionFade; // there are other types but this is the nicest
                                transition.duration = 0.34; // set the duration that you like
                                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                                [self.layer addAnimation:transition forKey:nil];
                            }
                        }
                        
                        [wself setNeedsLayout];
                    }
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:@"SDWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}

- (void)sd_setImageWithPreviousCachedImageWithURL:(NSURL *)url andPlaceholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock fadeAnimation:(BOOL)fadeAnimation{
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    UIImage *lastPreviousCachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    [self sd_setImageWithURL:url placeholderImage:lastPreviousCachedImage ?: placeholder options:options progress:progressBlock completed:completedBlock fadeAnimation:fadeAnimation];
}

- (NSURL *)sd_imageURL {
    return objc_getAssociatedObject(self, &imageURLKey);
}

- (void)sd_setAnimationImagesWithURLs:(NSArray *)arrayOfURLs {
    [self sd_cancelCurrentAnimationImagesLoad];
    __weak UIImageView *wself = self;
    
    NSMutableArray *operationsArray = [[NSMutableArray alloc] init];
    
    for (NSURL *logoImageURL in arrayOfURLs) {
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:logoImageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                __strong UIImageView *sself = wself;
                [sself stopAnimating];
                if (sself && image) {
                    NSMutableArray *currentImages = [[sself animationImages] mutableCopy];
                    if (!currentImages) {
                        currentImages = [[NSMutableArray alloc] init];
                    }
                    [currentImages addObject:image];
                    
                    sself.animationImages = currentImages;
                    [sself setNeedsLayout];
                }
                [sself startAnimating];
            });
        }];
        [operationsArray addObject:operation];
    }
    
    [self sd_setImageLoadOperation:[NSArray arrayWithArray:operationsArray] forKey:@"UIImageViewAnimationImages"];
}

- (void)sd_cancelCurrentImageLoad {
    [self sd_cancelImageLoadOperationWithKey:@"UIImageViewImageLoad"];
}

- (void)sd_cancelCurrentAnimationImagesLoad {
    [self sd_cancelImageLoadOperationWithKey:@"UIImageViewAnimationImages"];
}

@end

