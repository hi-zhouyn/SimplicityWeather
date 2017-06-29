//
//  Common.m
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import "Common.h"

@implementation Common

//cell 使用 特殊情况
+ (UIView *)viewFromXibName:(NSString *)xibName{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
    UIView *view = [nibView objectAtIndex:0];
    return view;
}

+ (BOOL)isPhonenum:(NSString *)phoneNum
{
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phoneNum];
}

+ (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    NSDictionary *stringAttribute = @{NSFontAttributeName:font};
    CGRect frame = [(NSString *)text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:stringAttribute context:nil];
    return frame.size.height;
}

+ (CGFloat)getTextWidthWithText:(NSString *)text font:(UIFont *)font hight:(CGFloat)hight {
    NSDictionary *stringAttribute = @{NSFontAttributeName:font};
    CGRect frame = [(NSString *)text boundingRectWithSize:CGSizeMake(10000, hight) options:NSStringDrawingTruncatesLastVisibleLine attributes:stringAttribute context:nil];
    return frame.size.width;
}

#pragma mark - 生成当前时间字符串
+ (NSString*)GetCurrentTimeString{
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmssS"];
    return [dateformat stringFromDate:[NSDate date]];
}

#pragma mark - 生成文件路径
+ (NSString*)GetPathByFileName:(NSString *)_fileName ofType:(NSString *)_type{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];;
    NSString* fileDirectory = [[[directory stringByAppendingPathComponent:_fileName]
                                stringByAppendingPathExtension:_type]
                               stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return fileDirectory;
}
#pragma mark - 根据日期输出星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
+(NSString *)dateToString:(NSDate *)date {
    
    // 初始化时间格式控制器
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    // 设置设计格式
    [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
    // 进行转换
    NSString *dateStr = [matter stringFromDate:date];
    return dateStr;
}

+(NSDate *)stringToDate:(NSString *)dateStr {
    
    // 初始化时间格式控制器
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    // 设置设计格式
    [matter setDateFormat:@"yyyy-MM-dd"];
    // 进行转换
    NSDate *date = [matter dateFromString:dateStr];
    return date;
    
}






@end
