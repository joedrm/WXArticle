//
//  NSString+WDY.m
//  IOS_Animations
//
//  Created by wangfang on 16/5/10.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import "NSString+WDY.h"
#import "sys/utsname.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (WDY)

#pragma mark --------------------------------------- 字符串宽高 ---------------------------------
/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat) heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{ NSFontAttributeName: textFont,
                                      NSParagraphStyleAttributeName: paragraph };
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else /* if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000 */
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{ NSFontAttributeName: textFont,
                                  NSParagraphStyleAttributeName: paragraph };
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif /* if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000 */
    
    return ceil(textSize.height);
}

/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat) widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{ NSFontAttributeName: textFont,
                                      NSParagraphStyleAttributeName: paragraph };
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else /* if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000 */
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{ NSFontAttributeName: textFont,
                                  NSParagraphStyleAttributeName: paragraph };
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif /* if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000 */
    
    return ceil(textSize.width);
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize) sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{ NSFontAttributeName: textFont,
                                      NSParagraphStyleAttributeName: paragraph };
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else /* if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000 */
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{ NSFontAttributeName: textFont,
                                  NSParagraphStyleAttributeName: paragraph };
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif /* if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000 */
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize) sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{ NSFontAttributeName: textFont,
                                      NSParagraphStyleAttributeName: paragraph };
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else /* if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000 */
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{ NSFontAttributeName: textFont,
                                  NSParagraphStyleAttributeName: paragraph };
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif /* if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000 */
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

+ (NSString *) reverseString:(NSString *)strSrc {
    NSMutableString *reverseString = [[NSMutableString alloc] init];
    NSInteger charIndex = [strSrc length];
    
    while (charIndex > 0)
    {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[strSrc substringWithRange:subStrRange]];
    }
    return reverseString;
}

#pragma mark ----------------------------------------- 字符串验证 ---------------------------------
// 是否有效邮箱
+ (BOOL) isValidEmail:(NSString *)email {
    // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

- (BOOL) isValidEmail {
    // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

+ (BOOL) isPureInteger:(NSString *)integer {
    NSString *pureIntegerRegex = @"^[0-9]+$";
    NSPredicate *pureIntegerTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pureIntegerRegex];
    
    return [pureIntegerTest evaluateWithObject:integer];
}

- (BOOL) isPureInteger {
    NSString *pureIntegerRegex = @"^[0-9]+$";
    NSPredicate *pureIntegerTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pureIntegerRegex];
    
    return [pureIntegerTest evaluateWithObject:self];
}

+ (BOOL) isFloat:(NSString *)floatString {
    NSString *floatRegex = @"^(\\d*\\.)?\\d+$";
    NSPredicate *floatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", floatRegex];
    
    return [floatTest evaluateWithObject:floatString];
}

- (BOOL) isFloat {
    NSString *floatRegex = @"^(\\d*\\.)?\\d+$";
    NSPredicate *floatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", floatRegex];
    
    return [floatTest evaluateWithObject:self];
}

// 是否有效的HTTP
+ (BOOL) isValidHttpURL:(NSString *)httpurl {
    NSString *urlRegEx =
    @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    
    return [urlTest evaluateWithObject:httpurl];
}

- (BOOL) isValidHttpURL {
    NSString *urlRegEx =
    @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    
    return [urlTest evaluateWithObject:self];
}

/**
 * 手机号码
 * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
 * 联通：130,131,132,152,155,156,185,186
 * 电信：133,1349,153,180,189
 * 阿里：170
 */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
/**
 * 10         * 中国移动：China Mobile
 * 11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
 * 12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
/**
 * 15         * 中国联通：China Unicom
 * 16         * 130,131,132,152,155,156,185,186
 * 17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
/**
 * 20         * 中国电信：China Telecom
 * 21         * 133,1349,153,180,189
 * 22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
/**
 * 20         * 阿里通讯：虚拟运营商
 * 21         * 170
 * 22         */
//    NSString * ALI = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
/**
 * 25         * 大陆地区固话及小灵通
 * 26         * 区号：010,020,021,022,023,024,025,027,028,029
 * 27         * 号码：七位或八位
 * 28         */
// NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";

+ (BOOL) isValidPhoneNumber:(NSString *)phoneNumber {
    // 弱验证，只验证开头两位和总长度是11位
    NSString *COMMON = @"^1[3|4|5|7|8][0-9]{9}$";
    NSPredicate *regexTestPhone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", COMMON];
    
    if ([regexTestPhone evaluateWithObject:phoneNumber] == YES) {
        return YES;
    } else {
        return NO;
    }
}


- (BOOL) isValidPhoneNumber {
    // 弱验证，只验证开头两位和总长度是11位
    NSString *COMMON = @"^1[3|4|5|7|8][0-9]{9}$";
    
    NSPredicate *regexTestPhone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", COMMON];
    
    if ([regexTestPhone evaluateWithObject:self] == YES) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL) validateIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}


#pragma mark ----------------------------------------- 字符串版本号大小比较 ---------------------------------
- (NSComparisonResult) compareToVersion:(NSString *)version {
    NSComparisonResult result;
    
    result = NSOrderedSame;
    
    if (![self isEqualToString:version]) {
        NSArray *thisVersion = [self componentsSeparatedByString:@"."];
        NSArray *compareVersion = [version componentsSeparatedByString:@"."];
        
        for (NSInteger index = 0; index < MAX([thisVersion count], [compareVersion count]); index++) {
            NSInteger thisSegment =
            (index < [thisVersion count]) ? [[thisVersion objectAtIndex:index] integerValue] : 0;
            NSInteger compareSegment =
            (index < [compareVersion count]) ? [[compareVersion objectAtIndex:index] integerValue] : 0;
            
            if (thisSegment < compareSegment) {
                result = NSOrderedAscending;
                break;
            }
            
            if (thisSegment > compareSegment) {
                result = NSOrderedDescending;
                break;
            }
        }
    }
    
    return result;
}

- (BOOL) isOlderThanVersion:(NSString *)version {
    return ([self compareToVersion:version] == NSOrderedAscending);
}

- (BOOL) isNewerThanVersion:(NSString *)version {
    return ([self compareToVersion:version] == NSOrderedDescending);
}

- (BOOL) isEqualToVersion:(NSString *)version {
    return ([self compareToVersion:version] == NSOrderedSame);
}

- (BOOL) isEqualOrOlderThanVersion:(NSString *)version {
    return ([self compareToVersion:version] != NSOrderedDescending);
}

- (BOOL) isEqualOrNewerThanVersion:(NSString *)version {
    return ([self compareToVersion:version] != NSOrderedAscending);
}



#pragma mark ----------------------------------------- 字符串解析 ---------------------------------
- (id) JSONValue {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error != nil) {
        return nil;
    }
    
    return result;
}


#pragma mark ----------------------------------------- 字符串非空判断 和 清除空白字符串 ---------------------------------

- (NSString *)trimWhitespace
{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}

- (BOOL)isEmpty
{
    return [[self trimWhitespace] isEqualToString:@""];
}

// 清空字符串中的空白字符
- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)stringIsNull
{
    if (![self isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (!self || [self isKindOfClass:[NSNull class]] || self.length == 0 || [self isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark ----------------------------------------- 字符串编码、解码、加密 ---------------------------------
- (NSString *)URLEncoding
{
    NSString * result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
                                                                                              (CFStringRef)self,
                                                                                              NULL,
                                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                              kCFStringEncodingUTF8 ));
    return result;
}
- (NSString *)URLDecoding
{
    NSMutableString * string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (NSString *)md5Str
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString*) sha1Str
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


@end
