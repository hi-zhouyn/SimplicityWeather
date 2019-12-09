//
//  Common.m
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import "Common.h"
#import "sys/utsname.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <Photos/Photos.h>

@implementation Common

+(UIView *)viewFromXibName:(NSString *)xibName
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
    UIView *view = [nibView objectAtIndex:0];
    return view;
}

+(CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width
{
    NSDictionary *stringAttribute = @{NSFontAttributeName:font};
    CGRect frame = [(NSString *)text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:stringAttribute context:nil];
    return frame.size.height;
}

+ (CGFloat)getTextHeightNotFontWithText:(UILabel *)label  width:(CGFloat)width
{
    //文字的高
    CGSize size = CGSizeMake(width, 10000);
    CGSize labelSize = [label sizeThatFits:size];
    return labelSize.height;
}

+ (CGFloat)getTextWidthNotFontWithText:(UILabel *)label  Height:(CGFloat)height
{
    //文字的高
    CGSize size = CGSizeMake(10000, height);
    CGSize labelSize = [label sizeThatFits:size];
    return labelSize.width;
}

+(CGFloat)getTextWidthWithText:(NSString *)text font:(UIFont *)font hight:(CGFloat)hight
{
    NSDictionary *stringAttribute = @{NSFontAttributeName:font};
    CGRect frame = [(NSString *)text boundingRectWithSize:CGSizeMake(10000, hight) options:NSStringDrawingTruncatesLastVisibleLine attributes:stringAttribute context:nil];
    return frame.size.width;
}

+ (void)editLabelStringWithLabel:(UILabel *)label allStr:(NSString *)string editStr:(NSString *)editStr color:(UIColor *)color isSetLine:(BOOL)isSetLine
{
    if (string.length == 0) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 调节行距大小
    if (isSetLine) {
        [paragraphStyle setLineSpacing:5];
    }
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,string.length)];
    if (editStr.length != 0) {
        // string为整体字符串, editStr为需要修改的字符串
        NSRange range = [string rangeOfString:editStr];
        // 设置属性修改字体颜色UIColor与大小UIFont
        [attributedString addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    }
    label.attributedText = attributedString;
}

+ (NSAttributedString *)strToAttriWithHtmlStr:(NSString *)htmlStr{
    
    NSMutableAttributedString *attrStr =  [[NSMutableAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                                                                  options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                                       documentAttributes:nil
                                                                                    error:nil];
    return attrStr;
}

/**
 根据label计算文字行数
 */
+ (NSUInteger )getTextLineCountNotFontWithText:(UILabel *)label
{
    CGFloat labelHeight = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)].height;
    NSNumber *count = @((labelHeight) / label.font.lineHeight);
    return [count integerValue];
}

+(NSString *)getCurrentTimeString
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [dateformat stringFromDate:[NSDate date]];
}

+(NSString *)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];;
    NSString *fileDirectory = [[[directory stringByAppendingPathComponent:_fileName]
                                stringByAppendingPathExtension:_type]
                               stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return fileDirectory;
}

+(void)setAddFindCache:(NSString *)ID Comment:(NSString *)comment
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults] objectForKey:@"FindCache"] ] ;
    [dict setValue:comment forKey:ID];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"FindCache"];
}

+(NSString *)getFindCache:(NSString *)ID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"FindCache"][ID];
}

+(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)imageWithColor:(UIColor *)color andHeight:(CGFloat)height
{
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+(NSDate *)datetimeStrToNSDate:(NSString *)timeStr;
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    NSDate *fromdate = [format dateFromString:timeStr];
    return fromdate;
}

+(NSDate *)datetimeStrToNSDate:(NSString *)timeStr dateFormat:(NSString *)dateF
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:dateF];
    NSDate *fromdate = [format dateFromString:timeStr];
    return fromdate;
}

+(NSInteger)sptimeToAge:(long)sptime
{
    NSDate *birthDate = [NSDate dateWithTimeIntervalSince1970:sptime];
    NSTimeInterval dateDiff = [birthDate timeIntervalSinceNow];
    NSInteger age = trunc(-dateDiff/(60*60*24))/365;
    return age;
}

+(long)getCurrentSptimeWithMsec:(BOOL)isMsec
{
    NSDate *fromdate = [NSDate date];
    long time;
    if (isMsec) {
        time = (long)([fromdate timeIntervalSince1970]*1000);
    }else{
        time = (long)[fromdate timeIntervalSince1970];
    }
    
    return time;
}

+(NSString *)sptimeToDatetimeStr:(long)spTime dateFormat:(NSString *)dateF
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:spTime];
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:dateF];
    NSString *confromTimespStr = [df stringFromDate:confromTimesp];
    return confromTimespStr;
}

+(NSDate *)sptimeToNSDate:(NSString *)spString
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    return confromTimesp;
}

+(NSDate *)zoneSptimeToNSDate:(NSString *)spString
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSDate *)dateAddMinutes:(NSDate *)date addMinutes:(NSInteger)minutes
{
    NSTimeInterval interval = 60 * minutes;
    return [NSDate dateWithTimeInterval:interval sinceDate:date];
}

+(NSString *)nsdateToDateStrTZ:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    //NSTimeZone *GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:-interval];
    
    date = [date dateByAddingTimeInterval:-interval];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //[dateFormat setTimeZone:GTMzone];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.S'Z'"];
    NSString *string = [dateFormat stringFromDate:date];
    return string;
}

+(NSString *)nsdateToDateStrTZ:(NSDate *)date dateFormat:(NSString *)dateF
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    date = [date dateByAddingTimeInterval:-interval];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:dateF];
    NSString *string = [dateFormat stringFromDate:date];
    return string;
}


+(NSString *)nsdateToDateStr:(NSDate *)date dateFormat:(NSString *)dateF
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:dateF];
    NSString *string = [dateFormat stringFromDate:date];
    return string;
}


+(long)datetimeStrToSptime:(NSString *)timeStr dateFormat:(NSString *)dateF
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:dateF];
    NSDate *fromdate = [format dateFromString:timeStr];
    long time = (long)[fromdate timeIntervalSince1970];
    
    return time;
}

+(long)dateStrTZToSptime:(NSString *)timeStr
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.S'Z'"];
    NSDate *fromdate=[format dateFromString:timeStr];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    fromdate = [fromdate dateByAddingTimeInterval:interval];
    
    long time = (long)[fromdate timeIntervalSince1970];
    
    return time;
}

+(NSString *)dateStrTZToDateStr:(NSString *)timeStr dateFormat:(NSString *)dateF
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.S'Z'"];
    NSDate *fromdate = [format dateFromString:timeStr];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    fromdate = [fromdate dateByAddingTimeInterval:interval];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:dateF];
    NSString *string = [dateFormat stringFromDate:fromdate];
    
    return string;
}

+(NSString *)dateStrToDateStrTZ:(NSString *)timeStr dateFormat:(NSString *)dateF
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:dateF];
    NSDate *fromdate = [format dateFromString:timeStr];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    fromdate = [fromdate dateByAddingTimeInterval:-interval];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.S'Z'"];
    NSString *string = [dateFormat stringFromDate:fromdate];
    
    return string;
}

+(NSString *)getOffsetTimeStrWithZero:(BOOL)zero data:(NSDate *)date
{
    //现在的时间
    NSDate *date1 = [NSDate date];
    if (!date) {
        date = date1;
    }
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSDateComponents *comps;
    comps =[calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond) fromDate:date];
    NSString *nowTime1 = [NSString stringWithFormat:@"%d-%02d-%02d 00:00:00 ",(int)[comps year],(int)[comps month],(int)[comps day]];
    NSString *nowTime2 = [NSString stringWithFormat:@"%d-%02d-%02d 23:59:59 ",(int)[comps year],(int)[comps month],(int)[comps day]];
    nowTime1 = [self nsdateToDateStrTZ:[self datetimeStrToNSDate:nowTime1 dateFormat:@"yyyy-MM-dd HH:mm:ss"]];
    nowTime2 = [self nsdateToDateStrTZ:[self datetimeStrToNSDate:nowTime2 dateFormat:@"yyyy-MM-dd HH:mm:ss"]];
    return zero ? nowTime1 : nowTime2;
}

+(NSString *)getOffsetTimeStrWithStart:(BOOL)start year:(NSInteger)year
{
    NSString *nowTime1 = [NSString stringWithFormat:@"%ld-01-01 00:00:00",(long)year];
    NSString *nowTime2 = [NSString stringWithFormat:@"%ld-12-31 23:59:59",(long)year];
    nowTime1 = [self nsdateToDateStrTZ:[self datetimeStrToNSDate:nowTime1 dateFormat:@"yyyy-MM-dd HH:mm:ss"]];
    nowTime2 = [self nsdateToDateStrTZ:[self datetimeStrToNSDate:nowTime2 dateFormat:@"yyyy-MM-dd HH:mm:ss"]];
    return start ? nowTime1 : nowTime2;
}


/**
 时间推移计算 偏移多少月 跨度为一个月 以originDate月份为起点月份
 */
+(NSString *)getOffsetTimeStrWithStart:(BOOL)start offictMonth:(NSInteger)offictMonth originDate:(NSDate *)originDate
{
    NSString *nowTime1 = [NSString string];
    NSString *nowTime2 = [NSString string];
    
    if (!originDate || offictMonth) {
        originDate = [NSDate date];
    }
    
    if (offictMonth>0 || offictMonth < 0) {
        
        NSDate *date = originDate;
        NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
        calendar.timeZone = destinationTimeZone;
        NSDateComponents *offsetcomponents = [[NSDateComponents alloc] init];
        
        [offsetcomponents setMonth:offictMonth];
        date = [calendar dateByAddingComponents:offsetcomponents toDate:date options:0];
        
        NSString *yearAndM = [self nsdateToDateStr:date dateFormat:@"yyyy-MM"];
        NSString *startTimeStr = [NSString stringWithFormat:@"%@-01 00:00:00",yearAndM];
        
        nowTime1 = [self nsdateToDateStrTZ:[self datetimeStrToNSDate:startTimeStr dateFormat:@"yyyy-MM-dd HH:mm:ss"]];
        
        NSInteger dayNum = [self getNumberOfDaysInMonth:date];
        NSString *endTimeStr = [NSString stringWithFormat:@"%@-%2ld 23:59:59",yearAndM,dayNum];
        nowTime2 = [self nsdateToDateStrTZ:[self datetimeStrToNSDate:endTimeStr dateFormat:@"yyyy-MM-dd HH:mm:ss"]];
        
    }else{
        NSString *yearAndM = [self nsdateToDateStr:originDate dateFormat:@"yyyy-MM"];
        nowTime1 = [NSString stringWithFormat:@"%@-01 00:00:00",yearAndM];
        NSInteger dayNum = [self getNumberOfDaysInMonth:originDate];
        nowTime2 = [NSString stringWithFormat:@"%@-%2ld 23:59:59",yearAndM,(long)dayNum];
        
        nowTime1 = [self nsdateToDateStrTZ:[self datetimeStrToNSDate:nowTime1 dateFormat:@"yyyy-MM-dd HH:mm:ss"]];
        nowTime2 = [self nsdateToDateStrTZ:[self datetimeStrToNSDate:nowTime2 dateFormat:@"yyyy-MM-dd HH:mm:ss"]];
    }
    return start ? nowTime1 : nowTime2;
}

+(NSString *)getOffsetComponentsTimeStr:(NSInteger)index
{
    NSDate *date = [NSDate date];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSDateComponents *offsetcomponents = [[NSDateComponents alloc] init];
    if (index == 0) {
        [offsetcomponents  setYear:-20];
    }else if (index == 1)
    {
        [offsetcomponents  setDay:-1];
    }else if (index == 2)
    {
        [offsetcomponents  setDay:1];
    }else if (index == 3)
    {
        [offsetcomponents  setDay:7];
    }else if (index == 4)
    {
        [offsetcomponents  setDay:-7];
    }else if (index == 5)
    {
        [offsetcomponents  setMonth:-1];
    }else if (index == 6)
    {
        [offsetcomponents  setMonth:1];
    }else if (index == 7)
    {
        [offsetcomponents  setMonth:-3];
    }else if (index == 8)
    {
        [offsetcomponents  setMonth:3];
    }else if (index == 9)
    {
        [offsetcomponents  setMonth:-6];
    }else if (index == 10)
    {
        [offsetcomponents  setMonth:6];
    }else if (index == 11)
    {
        [offsetcomponents  setYear:-1];
    }
    NSDate *endDate = [calendar dateByAddingComponents:offsetcomponents toDate:date options:0];
    return [self nsdateToDateStrTZ:endDate];
}

+(NSString *)getOffsetComponentsTimeStrWithOffsetDayCount:(NSInteger)offsetDayCount
{
    NSDate *date = [NSDate date];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSDateComponents *offsetcomponents = [[NSDateComponents alloc] init];
    [offsetcomponents  setDay:offsetDayCount];
    NSDate *endDate = [calendar dateByAddingComponents:offsetcomponents toDate:date options:0];
    return [self nsdateToDateStrTZ:endDate];
}

+(NSString *)getOffsetComponentsTimeStrWithStartTime:(NSString *)startTime  offsetDayCount:(NSInteger)offsetDayCount
{
    NSDate *date = [self datetimeStrToNSDate:startTime dateFormat:@"yyyy-MM-dd'T'HH:mm:ss.S'Z'"];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSDateComponents *offsetcomponents = [[NSDateComponents alloc] init];
    [offsetcomponents  setDay:offsetDayCount];
    NSDate *endDate = [calendar dateByAddingComponents:offsetcomponents toDate:date options:0];
    return [self nsdateToDateStrTZ:endDate dateFormat:@"yyyy-MM-dd"];
}

+(NSInteger )getIntWeekDayWithDate:(NSDate *)date
{
    //date = [self getNowDateFromatAnDate:date];
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    return [comps weekday];
}


//+(NSString *)getTimeFromSpToStr:(long)spTime
//{
//    NSDate *lateDate = [NSDate dateWithTimeIntervalSince1970:spTime];
//    NSTimeInterval late = [lateDate timeIntervalSince1970];
//    
//    //现在的时间
//    NSDate *date = [NSDate date];
//    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
//    calendar.timeZone = destinationTimeZone;
//    NSDateComponents *comps;
//    comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond) fromDate:date];
//    NSString *nowTime1 = [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d:%02d",(int)[comps year],(int)[comps month],(int)[comps day],(int)[comps hour],(int)[comps minute],(int)[comps second]];
//    
//    //当天最后时刻
//    NSString *nowTime2 = [NSString stringWithFormat:@"%d-%02d-%02d 23:59:59",(int)[comps year],(int)[comps month],(int)[comps day]];
//    
//    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
//    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];//Asia/beijing
//    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSDate *date1 = [inputFormatter dateFromString:nowTime1];
//    NSTimeInterval now1 = [date1 timeIntervalSince1970];
//    NSTimeInterval cha1 = now1 - late;
//    
//    NSDate *date2 = [inputFormatter dateFromString:nowTime2];
//    NSTimeInterval now2 = [date2 timeIntervalSince1970];
//    NSTimeInterval cha2 = now2 - late;
//    
//    long minute = 60;
//    long hour = 60*minute;
//    long day = 24*hour;
//    
//    NSString *timeString = @"";
//    
//    if (cha1 < 0)
//    {
//        timeString = [NSString stringWithFormat:@"刚刚"];
//        
//        return timeString;
//    }
//    else if (cha1/hour < 1)
//    {
//        timeString = [NSString stringWithFormat:@"%f", cha1/minute];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        
//        int num = [timeString intValue];
//        
//        if (num <= 1)
//        {
//            timeString = [NSString stringWithFormat:@"刚刚"];
//        }
//        else
//        {
//            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
//        }
//        
//        // austin add
//        //NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//        //[outputFormatter setDateFormat:@"MM月dd日 HH:mm"];
//        //timeString = [outputFormatter stringFromDate:fileTimeDate];
//        
//        return timeString;
//    }
//    else if (cha1/hour > 1 && cha2/day < 1)
//    {
//        timeString = [NSString stringWithFormat:@"%f", cha1/hour];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
//        
//        // austin add
//        //NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//        //[outputFormatter setDateFormat:@"MM月dd日 HH:mm"];
//        //timeString = [outputFormatter stringFromDate:fileTimeDate];
//        
//        return timeString;
//    }
//    else if (cha2/day > 1)
//    {
//        timeString = [NSString stringWithFormat:@"%f", cha2/day];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        
//        int num = [timeString intValue];
//        
//        if (num < 2)
//        {
//            timeString = [NSString stringWithFormat:@"昨天"];
//        }
//        else if(num == 2)
//        {
//            timeString = [NSString stringWithFormat:@"前天"];
//        }
//        else if (num > 2 && num <7)
//        {
//            //星期几
//            //NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//            //[outputFormatter setDateFormat:@"EEEE"];
//            //timeString = [outputFormatter stringFromDate:lateDate];
//            timeString = [NSString stringWithFormat:@"%@天前", timeString];
//        }
//        else if (num >= 7 && num <= 10)
//        {
//            //年月日
//            //NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//            //[outputFormatter setDateFormat:@"yy年MM月dd日"];
//            //timeString = [outputFormatter stringFromDate:lateDate];
//            timeString = [NSString stringWithFormat:@"1周前"];
//            
//        }
//        else if(num > 10)
//        {
//            //年月日
//            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//            [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
//            timeString = [outputFormatter stringFromDate:lateDate];
//            //timeString = [NSString stringWithFormat:@"n天前"];
//        }
//        else
//        {
//            //年月日
//            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//            [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
//            timeString = [outputFormatter stringFromDate:lateDate];
//        }
//        
//        // austin add
//        //NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//        //[outputFormatter setDateFormat:@"MM月dd日 HH:mm"];
//        //timeString = [outputFormatter stringFromDate:lateDate];
//        //return timeString;
//    }
//    else
//    {
//        //年月日
//        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//        [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
//        timeString = [outputFormatter stringFromDate:lateDate];
//    }
//    
//    return timeString;
//}

+(NSString *)getTimeFromSpToStr:(long)spTime
{
    NSDate *lateDate = [NSDate dateWithTimeIntervalSince1970:spTime];
    NSTimeInterval late = [lateDate timeIntervalSince1970];
    
    //现在的时间
    NSDate *date = [NSDate date];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSDateComponents *comps;
    comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond) fromDate:date];
    NSString *nowTime1 = [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d:%02d",(int)[comps year],(int)[comps month],(int)[comps day],(int)[comps hour],(int)[comps minute],(int)[comps second]];
    
    //当天最后时刻
    NSString *nowTime2 = [NSString stringWithFormat:@"%d-%02d-%02d 23:59:59",(int)[comps year],(int)[comps month],(int)[comps day]];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];//Asia/beijing
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date1 = [inputFormatter dateFromString:nowTime1];
    NSTimeInterval now1 = [date1 timeIntervalSince1970];
    NSTimeInterval cha1 = now1 - late;
    
    NSDate *date2 = [inputFormatter dateFromString:nowTime2];
    NSTimeInterval now2 = [date2 timeIntervalSince1970];
    NSTimeInterval cha2 = now2 - late;
    
    long minute = 60;
    long hour = 60*minute;
    long day = 24*hour;
    
    NSString *timeString = @"";
    
//    if (cha1 < 0)
//    {
//        timeString = [NSString stringWithFormat:@"刚刚"];
//
//        return timeString;
//    }
//    else if (cha1/hour < 1)
//    {
//        timeString = [NSString stringWithFormat:@"%f", cha1/minute];
//        timeString = [timeString substringToIndex:timeString.length-7];
//
//        int num = [timeString intValue];
//
//        if (num <= 1)
//        {
//            timeString = [NSString stringWithFormat:@"刚刚"];
//        }
//        else
//        {
//            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
//        }
//
//        return timeString;
//    }
//    else if (cha1/hour > 1 && cha2/day < 1)
    
    if (cha1/hour < 1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha1/minute];
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num = [timeString intValue];
        
        if (num <= 1)
        {
            timeString = [NSString stringWithFormat:@"刚刚"];
        }else
        {
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
        }
        return timeString;
    }
    if (cha2/day < 1)
    {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"HH:mm"];
        timeString = [outputFormatter stringFromDate:lateDate];
        
        return timeString;
    }
    else if (cha2/day > 1 && cha2/day < 2)
    {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"昨天 HH:mm"];
        timeString = [outputFormatter stringFromDate:lateDate];
    }
    else
    {
        //年月日
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"yyyy/MM/dd"];
        timeString = [outputFormatter stringFromDate:lateDate];
    }
    
    return timeString;
}

+ (NSInteger)compareDate:(NSDate*)aDate withDate:(NSDate*)bDate
{
    NSInteger aa = 0;
    NSComparisonResult result = [aDate compare:bDate];
    if (result == NSOrderedSame)
    {
        //相等  aa=0
        aa = 0;
    }else if (result==NSOrderedAscending)
    {
        //bDate比aDate大
        aa = 1;
    }else if (result == NSOrderedDescending)
    {
        //bDate比aDate小
        aa = -1;
    }
    return aa;
}

+(NSString *)getTimeFromDatetStrTZToStr:(NSString *)datetime
{
    long timeInterval = [self dateStrTZToSptime:datetime];
    return [self getTimeFromSpToStr:timeInterval];
}

+(NSString *)timeIntervalSinceDate:(NSString *)datetime isTeacher:(BOOL)isTeacher
{
    NSDate *nowDate = [NSDate date];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [formatter dateFromString:datetime];
    
    //创建日历
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:nowDate toDate:endDate options:0];
    //NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    if (cmps.year>0) {
        return [NSString stringWithFormat:@"距离上课%ld年%ld月%ld天", (long)cmps.year, (long)cmps.month, (long)cmps.day];
    }else if (cmps.month>0){
        return [NSString stringWithFormat:@"距离上课%ld月%ld天",(long)cmps.month,(long)cmps.day];
    }else if (cmps.day>0){
        return [NSString stringWithFormat:@"距离上课%ld天%ld小时",(long)cmps.day,(long)cmps.hour];
    }else if (cmps.hour>0){
        return [NSString stringWithFormat:@"距离上课%ld小时%ld分钟",(long)cmps.hour, (long)cmps.minute];
    }else if (cmps.minute>0){
        return [NSString stringWithFormat:@"距离上课%ld分钟",(long)cmps.minute];
    }else if (cmps.second>0){
        return [NSString stringWithFormat:@"即将开课"];
    }else{
        return isTeacher?@"已到上课时间":@"老师正在奔来途中";
    }
    return nil;
}

+(NSString *)timeIntervalSinceStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.S'Z'"];
    NSDate *nowDate = [formatter dateFromString:startTime];
    NSDate *endDate = [formatter dateFromString:endTime];
    
    //计算时间间隔（单位是秒）
    NSTimeInterval time = [endDate timeIntervalSinceDate:nowDate];
    NSUInteger timeCount;
    if (time>=60) {
        timeCount  = time / 60;
        return [NSString stringWithFormat:@"%ld分钟",(unsigned long)timeCount];
    }else{
        return [NSString stringWithFormat:@"%d秒",(int)time];
    }
    
}


+(NSString *)timeIntervalHastaken:(NSInteger)hasTaken
{
//    NSInteger Y = labs(hasTaken)/3600/24/365;
//    NSInteger M = (labs(hasTaken) - Y*365*30*24*3600)/3600/24/30;
//    NSInteger D = (labs(hasTaken) - M*30*24*3600)/3600/24;
    NSInteger seconds = hasTaken % 60;
    NSInteger minutes = (hasTaken / 60) % 60;
    NSInteger hours = hasTaken / 3600;
//    NSInteger h = (labs(hasTaken) - D*24*3600)/3600;
//    NSInteger m = (labs(hasTaken) - h*3600)/60;
//    NSInteger s = (labs(hasTaken) - h*3600)%60;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours,(long)minutes,(long)seconds];
}




+(NSInteger)intervalSinceNowFromTZ:(NSString *)datetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.S'Z'"];
    NSDate *endDate = [formatter dateFromString:datetime];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    endDate = [endDate dateByAddingTimeInterval:interval];
    
    NSTimeInterval late = [endDate timeIntervalSince1970];
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    
    NSTimeInterval cha = late - now;
    
    return cha/3600;
}

+(NSString *)getTimeFromSec:(long)sec
{
    int seconds = sec % 60;
    int minutes = (sec / 60) % 60;
    int hours = (int)sec / 3600;
    // return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    if (minutes>=1)
    {
        return [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    }
    else if (hours>=1)
    {
        return [NSString stringWithFormat:@"%d:%d分%d秒",hours, minutes, seconds];
    }else
    {
        return [NSString stringWithFormat:@"%d秒", seconds];
    }
}

+(NSString *)dateDecDays:(NSInteger)day currentDate:(NSDate *)cDate DateFormat:(NSString *)format
{
    NSTimeInterval nowtime = [cDate timeIntervalSince1970];
    double doub=(double)(nowtime-day*24*3600);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:doub];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];
}

+(NSString *)dateAddDays:(NSInteger)day currentDate:(NSDate *)cDate DateFormat:(NSString *)format
{
    NSTimeInterval nowtime = [cDate timeIntervalSince1970];
    double doub=(double)(nowtime+day*24*3600);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:doub];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];
}

+(BOOL)validateWithDatetime:(NSDate *)inputTime startTime:(NSDate *)startTime endTime:(NSDate *)endTime
{
    inputTime = [self getNowDateFromatAnDate:inputTime];
    startTime = [self getNowDateFromatAnDate:startTime];
    endTime = [self getNowDateFromatAnDate:endTime];
    
    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
//    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm"];
//    
//    NSDate *start = [dateFormat dateFromString:startTime];
//    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([inputTime compare:startTime] == NSOrderedDescending && [inputTime compare:endTime] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

+(BOOL)isSamePeriod:(NSDate *)date1 date2:(NSDate *)date2 compareType:(NSInteger)type
{
    //date1 = [self  getNowDateFromatAnDate:date1];
    //date2 = [self  getNowDateFromatAnDate:date2];
    
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    switch (type) {
        case 1://比较是否同一年
            return [comp1 year] == [comp2 year];
            break;
            
        case 2://比较是否同一月
            return [comp1 month] == [comp2 month] && [comp1 year] == [comp2 year];
            break;
            
        case 3://比较是否同一天
            return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year] == [comp2 year];
            break;
            
        default:
            return NO;
            break;
    }
}

// 判断和当前时间是否是在同一周

+(BOOL)isSameWeekWithDate:(NSDate *)date
{
    //date = [self getNowDateFromatAnDate:date];
    //NSDate *now = [self getNowDateFromatAnDate:[NSDate date]];
    NSDate *now = [NSDate date];

    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSInteger week1 = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:now];
    NSInteger week2 = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:date];
    
    if (week1 != week2) return NO;
    
    NSInteger interval = [now timeIntervalSinceDate:date];

    return (interval < 604800);
}


// 获取某月的天数
+(NSInteger)getNumberOfDaysInMonth:(NSDate *)date
{
    //date = [self getNowDateFromatAnDate:date];
    
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSGregorianCalendar - ios 8
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSDate * currentDate = date;
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay     //NSDayCalendarUnit - ios 8
                                   inUnit:NSCalendarUnitMonth   //NSMonthCalendarUnit - ios 8
                                  forDate:currentDate];
    return range.length;
}

/**
 *  获取指定的日期是星期几
 */
+(NSString *)getweekDayWithDate:(NSDate *)date
{
    //date = [self getNowDateFromatAnDate:date];
    
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    // 1 是周日，2是周一 3.以此类推
    
    switch ([comps weekday])
    {
        case 1:
            return @"周日";
            break;
            
        case 2:
            return @"周一";
            break;
            
        case 3:
            return @"周二";
            break;
            
        case 4:
            return @"周三";
            break;
            
        case 5:
            return @"周四";
            break;
            
        case 6:
            return @"周五";
            break;
            
        case 7:
            return @"周六";
            break;
            
        default:
            return @"";
            break;
    }
}

/**
 *  获取当月中所有天数
 */
+(NSArray *)getAllDaysWithCalender:(NSDate *)currentDate
{
    //currentDate = [self getNowDateFromatAnDate:currentDate];
    
    NSUInteger dayCount = [self getNumberOfDaysInMonth:currentDate]; //一个月的总天数

    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString * yearAndMonthStr = [formatter stringFromDate:currentDate];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableArray * allDaysArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= dayCount; i++)
    {
        NSString * dateStr = [NSString stringWithFormat:@"%@-%ld",yearAndMonthStr,(long)i];
        NSDate *suDate = [formatter dateFromString:dateStr];
        NSString *dayStr = [formatter stringFromDate:suDate ];
        [allDaysArray addObject:dayStr];
    }
    
    return allDaysArray;
}

//获取当前周中所有天数
+(NSArray *)getAllDaysWithWeek:(NSDate *)currentDate
{
    //NSDate *now = [self getNowDateFromatAnDate:currentDate];
    NSDate *now = currentDate;
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:now];
    //得到星期几 --- 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday];//得到星期几
    NSInteger day = [comp day];//得到几号
    
    //计算当前日期和这周开始日期(以本周星期日为开始日期)的相差天数
    NSInteger diff = [calendar firstWeekday] - weekDay;
    
    //在当前日期(去掉了时分秒)基础上加上差的天数,就是本周的开始日期
    [comp setDay:day + diff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:comp];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    NSMutableArray * allDaysArray = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<7; i++)
    {
        NSString * dateStr = [Common dateAddDays:i currentDate:firstDayOfWeek DateFormat:@"yyyy-MM-dd"];
        NSDate *suDate = [formater dateFromString:dateStr];
        [allDaysArray addObject:suDate];
    }
    
    return allDaysArray;
}

//获取当前周中所有天数
+(NSArray *)getAllDaysWithWeek:(NSDate *)currentDate dateFormat:(NSString *)format
{
    //NSDate *now = [self getNowDateFromatAnDate:currentDate];
    NSDate *now = currentDate;
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    calendar.timeZone = destinationTimeZone;
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:now];
    //得到星期几 --- 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday];//得到星期几
    NSInteger day = [comp day];//得到几号
    
    //计算当前日期和这周开始日期(以本周星期日为开始日期)的相差天数
    NSInteger diff = [calendar firstWeekday] - weekDay;
    
    //在当前日期(去掉了时分秒)基础上加上差的天数,就是本周的开始日期
    [comp setDay:day + diff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:comp];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:format];
    
    NSMutableArray * allDaysArray = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<7; i++)
    {
        NSString * dateStr;
        if (!i) {
            dateStr = [NSString stringWithFormat:@"%@ 00:00:00",[self nsdateToDateStr:firstDayOfWeek dateFormat:@"yyyy-MM-dd"]];
        }else if (i == 6){
            
            dateStr = [NSString stringWithFormat:@"%@ 23:59:59",[[Common dateAddDays:i currentDate:firstDayOfWeek DateFormat:format] substringToIndex:10]];
        }else{
            dateStr = [Common dateAddDays:i currentDate:firstDayOfWeek DateFormat:format];
        }
        dateStr = [self nsdateToDateStrTZ:[self datetimeStrToNSDate:dateStr dateFormat:format]];
//        NSDate *suDate = [formater dateFromString:dateStr];
        [allDaysArray addObject:dateStr];
    }
    
    return allDaysArray;
}

//系统时间转换为当前时区时间
+(NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}

//获得设备型号
+(NSString *)getCurrentDeviceModel
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

+(NSString *)MD5_16:(NSString *)str
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

+(BOOL)isPhoneNumber:(NSString *)phoneNum
{
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    return isMatch;
}

+(BOOL)checkPassword:(NSString *)password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

+(BOOL)checkUserName:(NSString *)userName
{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}

+(BOOL)checkUserIdCard:(NSString *)idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

+(BOOL)checkEmployeeNumber:(NSString *)number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

+(BOOL)checkURL:(NSString *)url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

+(NSString *)dealWithPhoneNumber:(NSString *)phone
{
    NSString *newPhone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return newPhone;
}

+(BOOL)isMobileNumber:(NSString *)mobileNum
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

+(BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

+(NSDictionary *)jsonStringToDictionary:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        return nil;
    }
    
    return dict;
}

+(UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+(NSString *)dictionaryToJsonString:(id)object
{
    NSError *error = nil;
    NSData *jsonData = nil;
    
    if (object == nil) {
        return nil;
    }
    
//    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
//    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        
//        NSString *keyString = nil;
//        NSString *valueString = nil;
//        
//        if ([key isKindOfClass:[NSString class]]) {
//            keyString = key;
//        }else{
//            keyString = [NSString stringWithFormat:@"%@",key];
//        }
//        
//        if ([obj isKindOfClass:[NSString class]]) {
//            valueString = obj;
//        }else{
//            valueString = [NSString stringWithFormat:@"%@",obj];
//        }
//        
//        [mdict setObject:valueString forKey:keyString];
//    }];
    
    jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] == 0 || error != nil) {
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}

//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

+(UIImage *)createViewImage:(UIView *)shareView
{
    UIGraphicsBeginImageContextWithOptions(shareView.bounds.size, NO, [UIScreen mainScreen].scale);
    [shareView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 按固定尺寸截图
+ (UIImage *)screenshotWithView:(UIView *)view Rect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        return nil;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    //[self layoutIfNeeded];
    if( [view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    }
    else
    {
        [view.layer renderInContext:context];
    }
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //NSData *imageData = UIImageJPEGRepresentation(image, 0.5); // convert to jpeg
    //image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
    return image;
}



//照片获取本地路径转换
+ (NSString *)getImagePath:(UIImage *)Image
{
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/%@",[self getCurrentTimeString]];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}

// 压缩视频并写入沙盒文件
+(void)compressedVideoWithURL:(id)url success:(void(^)(NSString *fileName))success failure:(void(^)())failure
{
    AVURLAsset *avAsset;
    if ([url isKindOfClass:[NSURL class]]) {
        avAsset = [AVURLAsset assetWithURL:url];
    }else if ([url isKindOfClass:[AVAsset class]]) {
        avAsset = (AVURLAsset *)url;
    }
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        NSString *fileName = @""; // 这里是自己定义的文件路径
        
        NSDate *nowDate = [NSDate date];
        NSString *dateStr = [NSString stringWithFormat:@"%ld", (long)[nowDate timeIntervalSince1970]];
        
        NSString *numStr = [NSString stringWithFormat:@"%d",arc4random()%10000];
        fileName = [fileName stringByAppendingString:dateStr];
        fileName = [fileName stringByAppendingString:numStr];
        
        // ````` 这里取的是时间加上一些随机数  保证每次写入文件的路径不一样
        fileName = [fileName stringByAppendingString:@".mp4"]; // 视频后缀
        NSString *fileName1 = [NSTemporaryDirectory() stringByAppendingString:fileName]; //文件名称
        exportSession.outputURL = [NSURL fileURLWithPath:fileName1];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            switch (exportSession.status) {
                case AVAssetExportSessionStatusCancelled:
                    break;
                case AVAssetExportSessionStatusCompleted:
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (success) {
                            success(fileName1);
                        }
                    });
                }
                    break;
                case AVAssetExportSessionStatusExporting:
                    break;
                case AVAssetExportSessionStatusFailed:
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (failure) {
                            failure();
                        }
                    });
                }
                    break;
                case AVAssetExportSessionStatusUnknown:
                    break;
                case AVAssetExportSessionStatusWaiting:
                    break;
                default:
                    break;
            }
        }];
    }
}



/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize
{
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    
    return imageData;
}


/**
 *  调整图片大小
 *
 *  @param sourceImage  原始图片
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxSizeWithKB:(CGFloat)maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;

    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(sourceImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(sourceImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}


/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat)maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}

+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

// 截取字符串方法封装
+ (NSString *)subString:(NSString *)sourceStr From:(NSString *)startStr to:(NSString *)endStr
{
    NSRange startRange = [sourceStr rangeOfString:startStr];
    NSRange endRange = [sourceStr rangeOfString:endStr];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [sourceStr substringWithRange:range];
}

//表情符号的判断
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f923)
                 {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3 || ls ==0xfe0f) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0x231a ) {
                 isEomji = YES;
             }
         }
         
     }];
    
    return isEomji;
}

//随机字符串
+ (NSString *)randomStringWithLength:(NSUInteger)lenght
{
    static char const possibleChars[] = "abcdefghijklmnopqrstuvwxyz0123456789";
    unichar characters[lenght];
    
    for (NSUInteger index = 0; index < lenght; ++index) {
        characters[index] = possibleChars[arc4random_uniform(sizeof(possibleChars) - 1)];
    }
    
    return [NSString stringWithCharacters:characters length:lenght];
}

//UIImage:去色功能的实现（图片灰色显示）
+ (UIImage *)grayImage:(UIImage *)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil, width, height,8,0, colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context ==NULL) {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0,0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

+(UIImage *)encodeQRImageWithContent:(NSString *)content withSize:(CGFloat)size
{
    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
    
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    UIColor *onColor = [UIColor blackColor];
    UIColor *offColor = [UIColor whiteColor];
    
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(CGSizeMake(size, size));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize
{
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    return imageData;
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)fitToSize:(UIImage *)img size:(CGSize)size{
    CGFloat contextRatio = size.width/size.height;
    CGFloat imgRatio = img.size.width/img.size.height;
    CGSize newImgSize = CGSizeZero;
    CGRect newImgRect = CGRectZero;
    UIGraphicsBeginImageContext(size);
    if (contextRatio >= imgRatio) {
        
        newImgSize = CGSizeMake(size.height*imgRatio, size.height);
        newImgRect = CGRectMake((size.width-size.height*imgRatio)/2.0, 0, size.height*imgRatio, size.height);
    }else{
        newImgSize = CGSizeMake(size.width, size.width/imgRatio);
        newImgRect = CGRectMake(0, (size.height-size.width/imgRatio)/2.0, size.width, size.width/imgRatio);
    }
    
    [img drawInRect:newImgRect];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//画水印
+(UIImage *)imageWithWaterMask:(UIImage*)maskImage inRect:(CGRect)rect originalImage:(UIImage*)originalImage
{
    UIGraphicsBeginImageContextWithOptions([originalImage size], NO, 0.0); // 0.0 for scale means "scale for device's main
    //原图
    [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width, originalImage.size.height)];
    //水印图
    [maskImage drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 画笔颜色
+(UIColor *)penColorWithStr:(NSString *)colorStr
{
    if ([colorStr isEqualToString:@"red"]) {
        return kSetHEXColor(0xf50600);
    }else if ([colorStr isEqualToString:@"yellow"]) {
        return kSetHEXColor(0xfdff00);
    }else if ([colorStr isEqualToString:@"green"]) {
        return kSetHEXColor(0x4bff00);
    }else if ([colorStr isEqualToString:@"lightblue"]) {
        return kSetHEXColor(0x53ffff);
    }else if ([colorStr isEqualToString:@"darkblue"]) {
        return kSetHEXColor(0x2209ff);
    }else if ([colorStr isEqualToString:@"purple"]) {
        return kSetHEXColor(0xf70fff);
    }else if ([colorStr isEqualToString:@"gray"]) {
        return kSetHEXColor(0xbfbfbf);
    }else if ([colorStr isEqualToString:@"white"]) {
        return kSetHEXColor(0xffffff);
    }else{
        return kSetHEXColor(0x000000);
    }
}

/**
 获取联系人首字母背景颜色
 *  @param textStr  标题首字母
 *
 *  @return 联系人首字母背景颜色
 */
+(UIColor *)textBGColorWithFirstTextStr:(NSString *)textStr
{
    if (!textStr.length) {
        return kSetHEXColor(0x7C68DF);
    }
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[A-Ea-e]+"] evaluateWithObject:textStr]) {
        return kSetHEXColor(0x6ED0AA);
    }else if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[F-Jf-j]+"] evaluateWithObject:textStr]){
        return kSetHEXColor(0x47BDF6);
    }else if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[K-Ok-o]+"] evaluateWithObject:textStr]){
        return kSetHEXColor(0xFF7841);
    }else if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[P-Up-u]+"] evaluateWithObject:textStr]){
        return kSetHEXColor(0xFF567E);
    }else if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[V-Zv-z]+"] evaluateWithObject:textStr]){
        return kSetHEXColor(0x89CC4F);
    }else {
        return kSetHEXColor(0x7C68DF);
    }
}


+(NSString *)digView:(UIView *)view
{
    if ([view isKindOfClass:[UITableViewCell class]]) return @"";
    // 1.初始化
    NSMutableString *xml = [NSMutableString string];
    
    // 2.标签开头
    [xml appendFormat:@"<%@ frame=\"%@\"", view.class, NSStringFromCGRect(view.frame)];
    if (!CGPointEqualToPoint(view.bounds.origin, CGPointZero)) {
        [xml appendFormat:@" bounds=\"%@\"", NSStringFromCGRect(view.bounds)];
    }
    
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scroll = (UIScrollView *)view;
        if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, scroll.contentInset)) {
            [xml appendFormat:@" contentInset=\"%@\"", NSStringFromUIEdgeInsets(scroll.contentInset)];
        }
    }
    
    // 3.判断是否要结束
    if (view.subviews.count == 0) {
        [xml appendString:@" />"];
        return xml;
    } else {
        [xml appendString:@">"];
    }
    
    // 4.遍历所有的子控件
    for (UIView *child in view.subviews) {
        NSString *childXml = [self digView:child];
        [xml appendString:childXml];
    }
    
    // 5.标签结尾
    [xml appendFormat:@"<!--%@-->", view.class];
    
    return xml;
}

/**
 获取本地版本号
 */
+(NSString *)getAppCurVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

@end

