//
//  NSObject+JSONTool.m
//  Pods
//
//  Created by wangdongyang on 16/7/28.
//
//

#import "NSObject+JSONTool.h"

@implementation NSObject (JSONTool)

- (NSData *)JSONData{
    return [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
}

- (NSString *)JSONString{
    if (![NSJSONSerialization isValidJSONObject:self]) {
        return @"";
    }
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

+ (id)objectFromJSONString:(NSString *)jsonString{
    return [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
}

+ (nullable id)objectFromJSONData:(nullable NSData *)jsonData{
    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
}


@end
