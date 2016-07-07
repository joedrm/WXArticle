//
//  NSBundle+WDY.m
//  IOS_Animations
//
//  Created by wangfang on 16/5/10.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import "NSBundle+WDY.h"

@implementation NSBundle (WDY)

+ (UIImage *)imageNamed:(NSString *)name
{
    // First try with the main bundle
    UIImage * image = [UIImage imageNamed:name];
    
    if (image)
        return image;
    
    // Otherwise try with other bundles
    for (NSString * bundlePath in [[NSBundle mainBundle] pathsForResourcesOfType:@"bundle"
                                                                     inDirectory:nil])
    {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", bundlePath.lastPathComponent, name]];
        
        if (image)
            return image;
    }
    
//    NBULogWarn(@"No image found for name: %@", name);
    return nil;
}

+ (NSArray *)loadNibNamed:(NSString *)name
                    owner:(id)owner
                  options:(NSDictionary *)options
{
    // First try with the main bundle
    NSBundle * mainBundle = [NSBundle mainBundle];
    if ([mainBundle pathForResource:name
                             ofType:@"nib"])
    {
//        NBULogVerbose(@"Loading Nib named: '%@' from mainBundle...", name);
        return [mainBundle loadNibNamed:name
                                  owner:owner
                                options:options];
    }
    
    // Otherwise try with other bundles
    NSBundle * bundle;
    for (NSString * bundlePath in [mainBundle pathsForResourcesOfType:@"bundle"
                                                          inDirectory:nil])
    {
        bundle = [NSBundle bundleWithPath:bundlePath];
        if ([bundle pathForResource:name
                             ofType:@"nib"])
        {
//            NBULogVerbose(@"Loading Nib named: '%@' from bundle: '%@'...", name, bundle.bundleIdentifier);
            return [bundle loadNibNamed:name
                                  owner:owner
                                options:options];
        }
    }
    
//    NBULogError(@"Couldn't load Nib named: %@", name);
    return nil;
}

@end
