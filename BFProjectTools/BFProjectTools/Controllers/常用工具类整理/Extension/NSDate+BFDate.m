//
//  NSDate+BFDate.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "NSDate+BFDate.h"

@implementation NSDate (BFDate)

- (NSDate *)monthDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self];
    [comp setDay:1];
    NSDate *date = [gregorian dateFromComponents:comp];
    return date;
}

- (int)weekday
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:self];
    int weekday = (int)[comps weekday];
    return weekday;
}

- (BOOL)isSameDay:(NSDate *)anotherDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    NSDateComponents* components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
}


// 比date要早
- (BOOL)isEarlyFromDate:(NSDate *)date
{
    return ([self compare:date] == NSOrderedAscending);
}

// 比targetDate要晚
- (BOOL)isLateFromDate:(NSDate *)targetDate
{
    return ([self compare:targetDate] == NSOrderedDescending);
}


- (NSInteger)daysBetweenDate:(NSDate *)date
{
    NSTimeInterval time = [self timeIntervalSinceDate:date];
    return ((fabs(time) / (60.0 * 60.0 * 24.0)) + 0.5);
}

- (BOOL)isToday{
    return [self isSameDay:[NSDate date]];
}

- (NSDate *)dateByAddingDays:(NSUInteger)days
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

- (NSDate *)dateByAddingMonthes:(NSUInteger)monthes
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.month = monthes;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

- (NSDate *)dateByAddingWeeks:(NSUInteger)weeks
{
    return [self dateByAddingDays:(weeks * 7)];
}


+ (NSDate *)dateWithDatePart:(NSDate *)aDate andTimePart:(NSDate *)aTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *datePortion = [dateFormatter stringFromDate:aDate];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *timePortion = [dateFormatter stringFromDate:aTime];
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *dateTime = [NSString stringWithFormat:@"%@ %@",datePortion,timePortion];
    return [dateFormatter dateFromString:dateTime];
}

- (NSString *)monthString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setDateFormat:@"MMM"];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)yearMonthString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy"
                                                               options:0
                                                                locale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)dayValue
{
    TKDateInformation inf = [self dateInformation];
    return [NSString stringWithFormat:@"%02ld",(long)inf.day];
}

- (NSString *)hourString
{
    TKDateInformation inf = [self dateInformation];
    return [NSString stringWithFormat:@"%02ld:00",(long)inf.hour];
}

- (NSInteger)hourIndex {
    TKDateInformation inf = [self dateInformation];
    return inf.hour;
}

- (NSInteger)minuteIndex {
    TKDateInformation inf = [self dateInformation];
    return inf.minute;
}

- (NSInteger)secondIndex {
    TKDateInformation inf = [self dateInformation];
    return inf.second;
}
//
//
//- (NSInteger)daysFromMonth:(NSInteger)month;
//{
//    NSCalendar *firstCal = [NSCalendar currentCalendar];
//    NSInteger day = 0;
//    NSRange currentRange = [firstCal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
//    NSInteger currentDays = currentRange.length;
//
//    day += (currentDays - self.dayValue.integerValue - 1);
//
//    NSDate *currentDate = self;
//    for (int i = 0 ; i < month; i ++) {
//        NSCalendar *cal = [NSCalendar currentCalendar];
//        NSDate *date = [currentDate nextMonth];
//        NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
//        day += range.length;
//        currentDate = date;
//    }
//
//    return day;
//}

- (TKDateInformation)dateInformationWithTimeZone:(NSTimeZone *)tz
{
    TKDateInformation info;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:tz];
    NSDateComponents *comp = [gregorian components:(NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitYear |
                                                    NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitSecond)
                                          fromDate:self];
    info.day = [comp day];
    info.month = [comp month];
    info.year = [comp year];
    
    info.hour = [comp hour];
    info.minute = [comp minute];
    info.second = [comp second];
    
    info.weekday = [comp weekday];
    
    return info;
    
}

- (NSInteger)monthIndex
{
    TKDateInformation info = [self dateInformation];
    return info.month;
}


- (TKDateInformation)dateInformation
{
    TKDateInformation info;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:[NSTimeZone systemTimeZone]];
    NSDateComponents *comp = [gregorian components:(NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitYear |
                                                    NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitSecond)
                                          fromDate:self];
    info.day = (int)[comp day];
    info.month = (int)[comp month];
    info.year = (int)[comp year];
    
    info.hour = (int)[comp hour];
    info.minute = (int)[comp minute];
    info.second = (int)[comp second];
    
    info.weekday = (int)[comp weekday];
    
    return info;
}

+ (NSDate *)dateFromDateInformation:(TKDateInformation)info timeZone:(NSTimeZone *)tz
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:tz];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setDay:info.day];
    [comp setMonth:info.month];
    [comp setYear:info.year];
    [comp setHour:info.hour];
    [comp setMinute:info.minute];
    [comp setSecond:info.second];
    [comp setTimeZone:tz];
    
    return [gregorian dateFromComponents:comp];
}

+ (NSDate *)dateFromDateInformation:(TKDateInformation)info
{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:[NSTimeZone systemTimeZone]];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setYear:info.year];
    [comp setDay:info.day];
    [comp setMonth:info.month];
    [comp setHour:info.hour];
    [comp setMinute:info.minute];
    [comp setSecond:info.second];
    NSDate *date = [gregorian dateFromComponents:comp];
    
    return date;
}

- (NSDate *)firstOfMonth
{
    TKDateInformation info = [self dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    info.day = 1;
    info.minute = 0;
    info.second = 0;
    info.hour = 0;
    return [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
}

- (NSDate *) nextMonth
{
    TKDateInformation info = [self dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    info.month++;
    if(info.month>12){
        info.month = 1;
        info.year++;
    }
    info.minute = 0;
    info.second = 0;
    info.hour = 0;
    
    return [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
}

- (NSDate *)previousMonth
{
    TKDateInformation info = [self dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    info.month--;
    if(info.month<1){
        info.month = 12;
        info.year--;
    }
    
    info.minute = 0;
    info.second = 0;
    info.hour = 0;
    return [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
}

- (NSString *)weekString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"eee"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithDateFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:self];
}

+ (NSDate *)dateFromString:(NSString *)string dateFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];    
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:string];
}



+ (NSDate *)dateStartOfWeek:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:date options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                        fromDate: beginningOfWeek];
    
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

+ (BOOL)isAweek:(NSDate *)date compareDate:(NSDate *)comDate
{
    // 一周的周一
    NSDate *weekStart = [NSDate dateStartOfWeek:date];
    
    // 一周的周日
    NSDate *weekEnd = [weekStart dateByAddingDays:7];
    
    
    // 如果比较的日期在周一到周日之间
    if ([comDate isEarlyFromDate:weekStart]) {
        return NO;
    }
    
    if ([comDate isLateFromDate:weekEnd]) {
        return NO;
    }
    
    return YES;
}


/**
 *  判断目标月是否是当前月份的上个月
 *
 *  @param date 目标月
 *
 *  @return YES：是，NO：不是
 */
- (BOOL)isPreviousMonth:(NSDate *)date
{
    NSDate *previousDate = [self previousMonth];
    if ([previousDate isSameMonth:date]) {
        return YES;
    }
    
    return NO;
}

// 是否是下一个月
- (BOOL)isNextMonth:(NSDate *)date
{
    NSDate *nextDate = [self nextMonth];
    if ([nextDate isSameMonth:date]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isSameMonth:(NSDate *)anotherDate
{
    if (anotherDate == nil) {
        return NO;
    }
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    NSDateComponents* components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month]);
}

- (NSInteger)daysInThisMonth {
    NSInteger year = self.yearMonthString.integerValue;
    NSInteger month = self.monthIndex;
    if (month == 2) {
        if ((year % 4 == 0 && year % 100 != 0) || year %  400 == 0) {//是闰年
            return 29;
        } else {
            return 28;
        }
    }
    if (month == 4 || month == 6 || month ==9 || month == 11) {
        return 30;
    }
    return 31;
}


@end
