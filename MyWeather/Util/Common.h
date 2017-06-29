//
//  Common.h
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Common : NSObject

+ (UIView *)viewFromXibName:(NSString *)xibName;

// 验证手机号
+ (BOOL)isPhonenum:(NSString *)phoneNum;

// 验证邮箱
+ (BOOL)isValidateEmail:(NSString *)Email;

// 根据label宽度计算文字高度
+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;
// 根据label高度计算文字宽度
+ (CGFloat)getTextWidthWithText:(NSString *)text font:(UIFont *)font hight:(CGFloat)hight;

#pragma mark - 生成当前时间字符串
+ (NSString*)GetCurrentTimeString;
#pragma mark - 生成文件路径
+ (NSString*)GetPathByFileName:(NSString *)_fileName ofType:(NSString *)_type;
#pragma mark - 根据日期输出星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
#pragma mark - date转字符串
+(NSString *)dateToString:(NSDate *)date;
#pragma mark - 字符串转date
+(NSDate *)stringToDate:(NSString *)dateStr;
@end
