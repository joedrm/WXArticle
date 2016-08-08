//
//  NSDate+WDY.h
//  WDYSettingDemo
//
//  Created by wangdongyang on 16/6/24.
//  Copyright © 2016年 WDY. All rights reserved.
//

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (WDY)
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger nanosecond;
@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger weekOfYear;
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger quarter;
@property (nonatomic, readonly) BOOL isLeapMonth;// 是否是闰月
@property (nonatomic, readonly) BOOL isLeapYear; //是否是闰年
@property (nonatomic, readonly) BOOL isToday; //是否是今天
@property (nonatomic, readonly) BOOL isYesterday; //是否是昨天

- (nullable NSDate *)dateByAddingYears:(NSInteger)years;
- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;
- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;
- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;


#pragma mark - Date Format
- (nullable NSString *)stringWithFormat:(NSString *)format;
- (nullable NSString *)stringWithFormat:(NSString *)format
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;
- (nullable NSString *)stringWithISOFormat;
+ (nullable NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;
+ (nullable NSDate *)dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(nullable NSTimeZone *)timeZone
                             locale:(nullable NSLocale *)locale;
+ (nullable NSDate *)dateWithISOFormatString:(NSString *)dateString;

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

#pragma mark - 比较日期
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;//比较两个日期是否相同（忽略时间）
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;

-(BOOL)isLaterThanOrEqual:(NSDate *)date;
-(BOOL)isLaterThan:(NSDate *)date;
-(BOOL)isEarlierOrEqual:(NSDate *)date;
-(BOOL)isEarlierThan:(NSDate *)date;
-(BOOL)isEqualTo:(NSDate *)date;
-(NSDate *)formatDateByComponent:(NSDate *)date;

// 是否是周末
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

/**
 *  时间线的描述
 *
 *  @return 如：刚刚  昨天 20：12
 */
- (NSString *)stringWithTimelineDate;
@end
NS_ASSUME_NONNULL_END

