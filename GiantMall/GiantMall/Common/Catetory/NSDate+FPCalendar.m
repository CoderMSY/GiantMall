//
//  NSDate+FPCalendar.m
//  FPAccount
//
//  Created by Simon Miao on 2025/10/31.
//

#import "NSDate+FPCalendar.h"

@implementation NSDate (FPCalendar)

#pragma mark - 私有工具方法
/// 获取日历组件
- (NSDateComponents *)dateComponents {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone systemTimeZone]; // 使用系统时区
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unitFlags fromDate:self];
}

/// 私有方法：获取共享的NSDateFormatter（优化性能）
+ (NSDateFormatter *)sharedDateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        // 设置固定区域，避免不同地区对日期格式的影响
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        // 使用系统时区，确保转换符合本地时间
        formatter.timeZone = [NSTimeZone systemTimeZone];
    });
    return formatter;
}

#pragma mark - 获取日期组件
- (NSInteger)fp_year {
    return [self dateComponents].year;
}

- (NSInteger)fp_month {
    return [self dateComponents].month;
}

- (NSInteger)fp_day {
    return [self dateComponents].day;
}

- (NSInteger)fp_hour {
    return [self dateComponents].hour;
}

- (NSInteger)fp_minute {
    return [self dateComponents].minute;
}

- (NSInteger)fp_second {
    return [self dateComponents].second;
}

#pragma mark - 日期比较
- (BOOL)fp_isSameDayWithDate:(NSDate *)otherDate {
    if (!otherDate) return NO;
    
    return [self fp_year] == [otherDate fp_year] &&
           [self fp_month] == [otherDate fp_month] &&
           [self fp_day] == [otherDate fp_day];
}

- (BOOL)fp_isSameMonthWithDate:(NSDate *)otherDate {
    if (!otherDate) return NO;
    
    return [self fp_year] == [otherDate fp_year] &&
           [self fp_month] == [otherDate fp_month];
}

- (BOOL)fp_isSameYearWithDate:(NSDate *)otherDate {
    if (!otherDate) return NO;
    
    return [self fp_year] == [otherDate fp_year];
}

#pragma mark - 日期转换
- (NSString *)fp_yyyyMMddString {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatter = [NSDate sharedDateFormatter]; //NSDateFormatter创建有性能消耗，所以此处采用单例
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]; // 避免地区格式影响
    formatter.timeZone = [NSTimeZone systemTimeZone];
    return [formatter stringFromDate:self];
}

- (NSString *)fp_stringWithFormat:(NSString *)format {
    if (!format || format.length == 0) {
        NSLog(@"⚠️ 日期格式不能为空");
        return @"";
    }
    
    NSDateFormatter *formatter = [NSDate sharedDateFormatter];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

+ (NSDate *)fp_dateFromFormat:(NSString *)format string:(NSString *)string {
    if (!format || format.length == 0) {
        NSLog(@"⚠️ 日期格式不能为空");
        return nil;
    }
    NSDateFormatter *formatter = [self sharedDateFormatter];
    formatter.dateFormat = format;
    
    NSDate *date = [formatter dateFromString:string];
    
    return date;
}

#pragma mark - 月份切换

/// 获取上一个月的第一天（如当前是2025-03-15，返回2025-02-01）
- (NSDate *)fp_firstDayOfPreviousMonth {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone systemTimeZone];
    
    // 1. 先获取上一个月的任意一天（用修复后的previousMonthDate确保年份正确）
    NSDate *previousMonthAnyDay = [self fp_previousMonthDate];
    // 2. 提取上一个月的“年、月”，将“日”设为1
    NSDateComponents *previousComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:previousMonthAnyDay];
    previousComponents.day = 1;
    previousComponents.hour = 0;
    previousComponents.minute = 0;
    previousComponents.second = 0;
    
    return [calendar dateFromComponents:previousComponents];
}

/// 获取当前日期的上一个月的同一天（自动处理月份边界）
- (NSDate *)fp_previousMonthDate {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone systemTimeZone]; // 固定时区
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]; // 固定地区，避免计算偏差
    
    // 1. 提取当前日期的完整组件（年、月、日、时、分、秒）
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *currentComponents = [calendar components:unitFlags fromDate:self];
    
    // 2. 月份减1（核心逻辑）
    currentComponents.month -= 1;
    // 当月份从1变为0时，NSCalendar会自动将年份减1，月份重置为12（如2026年1月→2025年12月）
    
    // 3. 用调整后的组件生成日期（确保年份正确递减）
    NSDate *previousMonthDate = [calendar dateFromComponents:currentComponents];
    
    // 兜底：若生成失败，用“添加组件”方式二次计算
    if (!previousMonthDate) {
        NSDateComponents *minusComponents = [[NSDateComponents alloc] init];
        minusComponents.month = -1;
        previousMonthDate = [calendar dateByAddingComponents:minusComponents toDate:self options:0];
    }
    
    return previousMonthDate;
}

/// 获取当前日期的下个月的同一天（自动处理月份边界）
- (NSDate *)fp_nextMonthDate {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone systemTimeZone];
    // 关键：设置日历计算时“严格遵循逻辑”，避免自动回滚年份
        calendar.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    
    // 1. 先获取当前日期的“年、月、日、时、分、秒”完整组件
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *currentComponents = [calendar components:unitFlags fromDate:self];
    
    // 2. 月份加1（核心逻辑）
    currentComponents.month += 1;
    // 无需手动处理年份：当月份从12变为13时，NSCalendar会自动将年份+1，月份重置为1
    
    // 3. 用调整后的组件重新生成日期（确保年份正确递增）
    NSDate *nextMonthDate = [calendar dateFromComponents:currentComponents];
    
    // 兜底：若直接生成失败，用“添加组件”方式二次计算（双重保障）
    if (!nextMonthDate) {
        NSDateComponents *addComponents = [[NSDateComponents alloc] init];
        addComponents.month = 1;
        nextMonthDate = [calendar dateByAddingComponents:addComponents toDate:self options:0];
    }
    
    return nextMonthDate;
}

/// 获取下个月的第一天（如当前是2025-02-15，返回2025-03-01）
- (NSDate *)fp_firstDayOfNextMonth {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone systemTimeZone];
    
    // 1. 先获取下个月的任意一天（用修复后的nextMonthDate确保年份正确）
    NSDate *nextMonthAnyDay = [self fp_nextMonthDate];
    // 2. 提取下个月的“年、月”组件，将“日”设为1
    NSDateComponents *nextMonthComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:nextMonthAnyDay];
    nextMonthComponents.day = 1;
    nextMonthComponents.hour = 0;
    nextMonthComponents.minute = 0;
    nextMonthComponents.second = 0;
    
    return [calendar dateFromComponents:nextMonthComponents];
}


@end
