//
//  Common.h
//  ViewController
//
//  Created by Austin on 15-3-26.
//  Copyright (c) 2015年 ViewController. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface UserCommon : NSObject

// 时间戳转换成生日
+(NSString*)sptimeToBirthday:(long)sptime;

// 生日转化为时间戳
+(long)birthdayToSptime:(NSString *)birthday;

// 时间转换成生日
+(NSString*)dateToBirthday:(NSDate *)date;

// 生日转化为时间
+(NSDate *)birthdayToDate:(NSString *)birthday;

// 获取当前时间戳
+(long)getCurrentSptime;

+ (int)birthdayToAge:(long)sptime;

+(long)changeTimeToTimeSp:(NSString *)timeStr;

+ (NSString *)getCurrentTime;

+ (NSString *)getTimeFromSp:(long )spTime;

+(NSString *)getTaskStringFromSptime:(long )spTime;

+ (NSString *)getTimeFromSpToStr:(long )spTime;

+ (NSString *)getTimeFromSec:(long)sec;

+ (NSString *)getCurrentDeviceModel;

+ (NSString *)MD5_16:(NSString *)str;


#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;


+ (NSString *)dealWithPhoneNumber:(NSString *)phone;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
