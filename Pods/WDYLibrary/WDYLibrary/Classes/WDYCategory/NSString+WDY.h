//
//  NSString+WDY.h
//  IOS_Animations
//
//  Created by wangfang on 16/5/10.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (WDY)

// ------------ 根据字体返回字符串的宽高
- (CGFloat) heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGFloat) widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;
- (CGSize) sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGSize) sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

// ------------ 反转字符串
+ (NSString *) reverseString:(NSString *)strSrc;


// ------------ 字符串验证
// 是否有效邮箱
+ (BOOL) isValidEmail:(NSString *)email;
- (BOOL) isValidEmail;

// 是否有效的HTTP
+ (BOOL) isValidHttpURL:(NSString *)httpurl;
- (BOOL) isValidHttpURL;

// 是否是纯数字
+ (BOOL) isPureInteger:(NSString *)integer;
- (BOOL) isPureInteger;

// 是否是浮点数
+ (BOOL) isFloat:(NSString *)floatString;
- (BOOL) isFloat;

// 是否为合法手机号码
+ (BOOL) isValidPhoneNumber:(NSString *)phoneNumber;
- (BOOL) isValidPhoneNumber;

// 身份证号校验
- (BOOL) validateIdentityCard;

// ------------ 字符串版本号大小比较
- (NSComparisonResult)compareToVersion:(NSString *)version;
- (BOOL) isOlderThanVersion:(NSString *)version;
- (BOOL) isNewerThanVersion:(NSString *)version;
- (BOOL) isEqualToVersion:(NSString *)version;
- (BOOL) isEqualOrOlderThanVersion:(NSString *)version;
- (BOOL) isEqualOrNewerThanVersion:(NSString *)version;

// ------------ 字符串解析
- (id)JSONValue;

// ------------ 字符串非空判断 和 清除空白字符串
- (BOOL)isEmpty;//字符串非空判断
- (NSString *)trimString; //清除空白字符串
- (BOOL)stringIsNull;//判断字符串是否为null

// ------------ 字符串编码、解码、加密
- (NSString *)URLEncoding;
- (NSString *)URLDecoding;
- (NSString *)md5Str;
- (NSString *)sha1Str;
@end




