//
//  NSDate+FPCalendar.h
//  FPAccount
//
//  Created by Simon Miao on 2025/10/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (FPCalendar)

#pragma mark - 获取日期组件
/// 获取年份
- (NSInteger)fp_year;

/// 获取月份（1-12）
- (NSInteger)fp_month;

/// 获取日期（1-31）
- (NSInteger)fp_day;

/// 获取小时（0-23）
- (NSInteger)fp_hour;

/// 获取分钟（0-59）
- (NSInteger)fp_minute;

/// 获取秒钟（0-59）
- (NSInteger)fp_second;

#pragma mark - 日期比较
/// 判断与另一个日期是否是同一天
/// @param otherDate 另一个日期
- (BOOL)fp_isSameDayWithDate:(NSDate *)otherDate;

/// 判断与另一个日期是否是同一月
/// @param otherDate 另一个日期
- (BOOL)fp_isSameMonthWithDate:(NSDate *)otherDate;

/// 判断与另一个日期是否是同一年
/// @param otherDate 另一个日期
- (BOOL)fp_isSameYearWithDate:(NSDate *)otherDate;

#pragma mark - 日期转换
/// 转换为年月日字符串（yyyy-MM-dd）
- (NSString *)fp_yyyyMMddString;

/// 将NSDate转换为指定格式的字符串
/// @param format 日期格式（如@"yyyy-MM-dd HH:mm:ss"、@"MM-dd"、@"HH:mm"等）
- (NSString *)fp_stringWithFormat:(NSString *)format;

+ (NSDate *)fp_dateFromFormat:(NSString *)format string:(NSString *)string;

#pragma mark - 月份切换

/// 获取上一个月的第一天（如当前是2025-03-15，返回2025-02-01）
- (NSDate *)fp_firstDayOfPreviousMonth;
/// 获取下个月的第一天（如当前是2025-02-15，返回2025-03-01）
- (NSDate *)fp_firstDayOfNextMonth;

@end

NS_ASSUME_NONNULL_END
