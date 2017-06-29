//
//  Common.m
//  ViewController
//
//  Created by Austin on 15-3-26.
//  Copyright (c) 2015年 ViewController. All rights reserved.
//

#import "UserCommon.h"
#import "sys/utsname.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UserCommon

+(NSString*)sptimeToBirthday:(long)sptime{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sptime];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}

// 生日转化为时间戳
+(long)birthdayToSptime:(NSString *)birthday{
    long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    NSDate *fromdate=[format dateFromString:birthday];
    time= (long)[fromdate timeIntervalSince1970];
    return time;
}

// 时间转换成生日
+(NSString*)dateToBirthday:(NSDate *)formdate{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日"];
    NSString* string=[dateFormat stringFromDate:formdate];
    return string;
}

// 生日转化为时间
+(NSDate *)birthdayToDate:(NSString *)birthday{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    NSDate *fromdate=[format dateFromString:birthday];
    return fromdate;
}

+ (int)birthdayToAge:(long)sptime{
    NSDate *birthDate = [NSDate dateWithTimeIntervalSince1970:sptime];
    NSTimeInterval dateDiff = [birthDate timeIntervalSinceNow];
    int age=trunc(-dateDiff/(60*60*24))/365;
    return age;
}

+(long)getCurrentSptime{
    long time;
    NSDate *fromdate=[NSDate date];
    time=(long)[fromdate timeIntervalSince1970];
    return time;
}

+ (NSString *)getCurrentTime{
    //现在的时间
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit| NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)
                       fromDate:date];
    NSString* nowTime =[NSString stringWithFormat:@"%ld年%02ld月%02ld日 %02ld:%02ld:%02ld",(long)[comps year],(long)[comps month], (long)[comps day], (long)[comps hour], (long)[comps minute], (long)[comps second]];
    return nowTime;
}

+ (NSString *)getTimeFromSp:(long )spTime{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:spTime];
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *confromTimespStr = [df stringFromDate:confromTimesp];
    return confromTimespStr;
}

//将时间戳转换成NSDate
+(NSDate *)changeSpToTime:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    return confromTimesp;
}
//将时间戳转换成NSDate,加上时区偏移
+(NSDate*)zoneChange:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSString*)nsdateToString:(NSDate *)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}

//将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
+(long)changeTimeToTimeSp:(NSString *)timeStr{
    long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:timeStr];
    time= (long)[fromdate timeIntervalSince1970];
    return time;
}

+(NSString *)getTaskStringFromSptime:(long )spTime{
    NSDate *fileTimeDate = [NSDate dateWithTimeIntervalSince1970:spTime];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日HH:mm"];
    NSString *timeString = [outputFormatter stringFromDate:fileTimeDate];
    return timeString;
}


+(NSString *)getTimeFromSpToStr:(long )spTime{
    NSDate *fileTimeDate = [NSDate dateWithTimeIntervalSince1970:spTime];
    //现在的时间
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit| NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)
                       fromDate:date];
    NSString* nowTime =[NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d:%02d",(int)[comps year],(int)[comps month], (int)[comps day], (int)[comps hour], (int)[comps minute], (int)[comps second]];
    
    NSString* nowTime2 =[NSString stringWithFormat:@"%d-%02d-%02d 23:59:59",(int)[comps year],(int)[comps month], (int)[comps day]];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];//Asia/beijing
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* dat = [inputFormatter dateFromString:nowTime];
    NSTimeInterval late=[fileTimeDate timeIntervalSince1970]*1;
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSTimeInterval cha=now-late;
    
    NSDate* dat2 = [inputFormatter dateFromString:nowTime2];
    NSTimeInterval now2=[dat2 timeIntervalSince1970]*1;
    NSTimeInterval cha2=now2-late;
    long minute=60;
    long hour=60*minute;
    long day=24*hour;
    NSString *timeString=@"";
    
    if (cha/hour < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/minute];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num= [timeString intValue];
        
        if (num <= 1) {
            timeString = [NSString stringWithFormat:@"刚刚..."];
        }else{
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
        }
        
        // austin add
//        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//        [outputFormatter setDateFormat:@"MM月dd日 HH:mm"];
//        timeString = [outputFormatter stringFromDate:fileTimeDate];
        return timeString;
    }
    
    if (cha/hour > 1 && cha2/day < 1) { //
        
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
        // austin add
//        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//        [outputFormatter setDateFormat:@"MM月dd日 HH:mm"];
//        timeString = [outputFormatter stringFromDate:fileTimeDate];
        return timeString;
    }
    
    if (cha2/day > 1)
        
    {
        
        timeString = [NSString stringWithFormat:@"%f", cha2/86400];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num = [timeString intValue];
        
        if (num < 2) {
            
            timeString = [NSString stringWithFormat:@"昨天"];
            
        }else if(num == 2){
            
            timeString = [NSString stringWithFormat:@"前天"];
            
        }else if (num > 2 && num <7){
            //星期几
            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
            [outputFormatter setDateFormat:@"EEEE"];
            timeString = [outputFormatter stringFromDate:fileTimeDate];
//            timeString = [NSString stringWithFormat:@"%@天前", timeString];
            
        }else if (num >= 7 && num <= 10) {
            //年月日
            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
            [outputFormatter setDateFormat:@"yy年MM月dd日"];
            timeString = [outputFormatter stringFromDate:fileTimeDate];
            //timeString = [NSString stringWithFormat:@"1周前"];
            
        }else if(num > 10){
            //年月日
            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
            [outputFormatter setDateFormat:@"yy年MM月dd日"];
            timeString = [outputFormatter stringFromDate:fileTimeDate];
            //timeString = [NSString stringWithFormat:@"n天前"];
            
        }else{
            
            timeString = [NSString stringWithFormat:@"1天前"];
        }
        // austin add
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"MM月dd日 HH:mm"];
        timeString = [outputFormatter stringFromDate:fileTimeDate];
        return timeString;
        
    }
    if(cha<0){
        timeString = [NSString stringWithFormat:@"刚刚发布"];
    }
    return timeString;
}



+ (NSString *)getTimeFromSec:(long)sec
{
    int seconds = sec % 60;
    int minutes = (sec / 60) % 60;
    int hours = (int)sec / 3600;
//    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    if (minutes>=1) {
        return [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    }
    else if (hours>=1) {
        return [NSString stringWithFormat:@"%d:%d分%d秒",hours, minutes, seconds];
    }else{
        return [NSString stringWithFormat:@"%d秒", seconds];
    }
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}


//MD5 16位加密
+ (NSString *)MD5_16:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}


#pragma 正则匹配用户身份证号15或18位

+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}


+ (NSString *)dealWithPhoneNumber:(NSString *)phone
{
    NSString *newPhone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return newPhone;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestphs evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return YES; //暂时不做检查
    }
}


@end
