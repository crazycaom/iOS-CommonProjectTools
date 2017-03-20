//
//  NSDate+BFDate.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//  NSDate 扩展Action

#import <Foundation/Foundation.h>

struct TKDateInformation {
    
    NSInteger day;
    NSInteger month;
    NSInteger year;
    
    NSInteger weekday;
    
    NSInteger minute;
    NSInteger hour;
    NSInteger second;
    
};
typedef struct TKDateInformation TKDateInformation;

@interface NSDate (BFDate)

//////

/**
 上一个月

 @return NSDate
 */
- (NSDate *)previousMonth;

/**
 下一个月

 @return NSDate
 */
- (NSDate *) nextMonth;

/**
 月份

 @return 月份
 */
- (NSInteger)monthIndex;

/**
 判断两个日期是否是同一天

 @param anotherDate 另一个日期

 @return YES：是同一天，NO：不是同一天
 */
- (BOOL)isSameDay:(NSDate *)anotherDate;

/**
 判断当前日期是否是今天

 @return YES：是今天，NO：不是今天
 */
- (BOOL)isToday;

/**
 两个日期之间相差的天数

 @param date 另一个日期

 @return 整型，天数
 */
- (NSInteger)daysBetweenDate:(NSDate *)date;

/**
 当前日期＋天数＝ 另一个日期

 @param days 天数

 @return 另一个日期
 */
- (NSDate *)dateByAddingDays:(NSUInteger)days;

/**
 几个月后的日期

 @param monthes 月数

 @return 另一个日期
 */
- (NSDate *)dateByAddingMonthes:(NSUInteger)monthes;

/**
 几周后的日期

 @param weeks 周数

 @return 另一个日期
 */
- (NSDate *)dateByAddingWeeks:(NSUInteger)weeks;

/**
 当前日期的月份

 @return 月份，例如：2015/08 中的08
 */
- (NSString *)monthString;

/**
 当前日期的年份

 @return 年份，例如：2015/08 中的2015
 */
- (NSString *)yearMonthString;

/**
 当前日期的日期

 @return 日期，例如：2015/08/01 中的01
 */
- (NSString *)dayValue;


/**
 当前日期的周次

 @return 周几
 */
- (NSString *)weekString;

/**
 当前时间的小时

 @return 小时，例如：2015/08/01 12:22 中的12:00
 */
- (NSString *)hourString;

// eg 12:22:30 中的 12
/**
 

 @return 小时 12
 */
- (NSInteger)hourIndex;


/**
 当前的分钟

 @return 分钟 22
 */
- (NSInteger)minuteIndex;


/**
 当前的秒数

 @return 秒数 30
 */
- (NSInteger)secondIndex;

/**
 当前日期是否早于目标日期

 @param date 目标日期

 @return YES：当前日期早于目标日期，NO：当前日期晚于或者等于目标日期
 */
- (BOOL)isEarlyFromDate:(NSDate *)date;

/**
 是否比targetDate要晚

 @param targetDate 要判断的日期

 @return YES: 比targetDate晚. NO: 比targetDate早.
 */
- (BOOL)isLateFromDate:(NSDate *)targetDate;

//

/**
 日期转换成字符串

 @param formatter 转换日期的格式

 @return 返回日期字符串
 */
- (NSString *)stringWithDateFormatter:(NSString *)formatter;

/**
 字符串转换日期

 @param string    要转换的字符串
 @param formatter 要转换的日期格式

 @return 转换后的日期
 */
+ (NSDate *)dateFromString:(NSString *)string
             dateFormatter:(NSString *)formatter;

/**
 比较两个日期是否在同一周

 @param date    比较的第一日期
 @param comDate 需要比较的第二个日期

 @return YES: 在同一周. NO: 不在同一周.
 */
+ (BOOL)isAweek:(NSDate *)date compareDate:(NSDate *)comDate;

/**
 判断一个日期是否是前一个月


 @param date 要判断的日期

 @return YES: 是前一个月. NO: 不是前一个月.
 */
- (BOOL)isPreviousMonth:(NSDate *)date;

//

/**
 判断一个日期是否是下一个月

 @param date 要判断的日期

 @return YES: 是下一个月.  NO: 不是下一个月.
 */
- (BOOL)isNextMonth:(NSDate *)date;

// 是同一个月

/**
 判断两个日期是否是在同一个月

 @param anotherDate 要判断的日期

 @return YES: 是在同一个月. NO: 不在同一个月
 */
- (BOOL)isSameMonth:(NSDate *)anotherDate;

/**
 返回某年某月的天数

 @return 天数
 */
- (NSInteger)daysInThisMonth;


@end
