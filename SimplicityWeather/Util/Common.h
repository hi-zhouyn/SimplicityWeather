//
//  Common.h
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Common : NSObject

/**
 cell 使用
 */
+ (UIView *)viewFromXibName:(NSString *)xibName;

//*************************************************label************************************************************

/**
 根据label宽度计算文字高度
 */
+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

/**
 根据label计算文字高度
 */
+ (CGFloat)getTextHeightNotFontWithText:(UILabel *)label  width:(CGFloat)width;

/**
 根据label计算文字高度
 */
+ (CGFloat)getTextWidthNotFontWithText:(UILabel *)label  Height:(CGFloat)height;

/**
 根据label高度计算文字宽度
 */
+ (CGFloat)getTextWidthWithText:(NSString *)text font:(UIFont *)font hight:(CGFloat)hight;

/**
 修改Label中不同文字颜色及行间距
 */
+ (void)editLabelStringWithLabel:(UILabel *)label allStr:(NSString *)string editStr:(NSString *)editStr color:(UIColor *)color isSetLine:(BOOL) isSetLine;

/**
 加载h5标签
 */
+ (NSAttributedString *)strToAttriWithHtmlStr:(NSString *)htmlStr;

/**
 根据label计算文字行数
 */
+ (NSUInteger )getTextLineCountNotFontWithText:(UILabel *)label;


//*************************************************文件路径************************************************************

/**
 生成文件路径
 */
+ (NSString *)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type;

//*************************************************缓存************************************************************

/**
 添加缓存
 */
+(void)setAddFindCache:(NSString *)ID Comment:(NSString *)comment;

/**
 获取缓存
 */
+(NSString *)getFindCache:(NSString *)ID;

//*************************************************日期时间************************************************************

/**
 获取当前时间戳
 */
+(long)getCurrentSptimeWithMsec:(BOOL)isMsec;

/**
 时间字符串转换时间戳(yyyy-MM-dd HH:mm:ss)
 */
+(long)datetimeStrToSptime:(NSString *)timeStr dateFormat:(NSString *)dateF;

/**
 时间字符串转换时间戳(yyyy-MM-dd'T'HH:mm:ss.S'Z')
 */
+(long)dateStrTZToSptime:(NSString *)timeStr;

/**
 将时间戳字符串转换成NSDate
 */
+(NSDate *)sptimeToNSDate:(NSString *)spString;

/**
 日期字符串转换NSDate(yyyy年MM月dd日)
 */
+(NSDate *)datetimeStrToNSDate:(NSString *)timeStr;

/**
 日期字符串转换NSDate(自定义格式)
 */
+(NSDate *)datetimeStrToNSDate:(NSString *)timeStr dateFormat:(NSString *)dateF;

/**
 将时间戳字符串转换成NSDate,加上时区偏移
 */
+(NSDate *)zoneSptimeToNSDate:(NSString *)spString;

/**
 日期+分钟，返回日期
 */
+(NSDate *)dateAddMinutes:(NSDate *)date addMinutes:(NSInteger)minutes;

/**
 时间戳转换时间字符串(yyyy-MM-dd HH:mm:ss)
 */
+(NSString *)sptimeToDatetimeStr:(long)spTime dateFormat:(NSString *)dateF;

/**
 生成当前时间字符串(yyyyMMddHHmmssSSS)
 */
+(NSString *)getCurrentTimeString;

/**
 NSDate转换时间字符串(yyyy-MM-dd'T'HH:mm:ss.S'Z')
 */
+(NSString *)nsdateToDateStrTZ:(NSDate *)date;

/**
 NSDate转换时间字符串(自定义格式)
 */
+(NSString *)nsdateToDateStrTZ:(NSDate *)date dateFormat:(NSString *)dateF;

/**
 NSDate转换时间字符串(自定义格式,不考虑时区)
 */
+(NSString *)nsdateToDateStr:(NSDate *)date dateFormat:(NSString *)dateF;

/**
 将(yyyy-MM-dd'T'HH:mm:ss.S'Z')格式时间转换日期字符串格式
 */
+(NSString *)dateStrTZToDateStr:(NSString *)timeStr dateFormat:(NSString *)dateF;

/**
 将日期字符串格式转换(yyyy-MM-dd'T'HH:mm:ss.S'Z')格式时间
 */
+(NSString *)dateStrToDateStrTZ:(NSString *)timeStr dateFormat:(NSString *)dateF;

/**
 返回当日的零点和结束点
 @param zero TRUE返回零点 FALSE返回结束点
 */
+(NSString *)getOffsetTimeStrWithZero:(BOOL)zero data:(NSDate *)date;

/**
 时间戳转换时间间隔(距离当前时间过去多久)
 */
+(NSString *)getTimeFromSpToStr:(long)spTime;

/**
 时间字符串转换时间间隔(yyyy-MM-dd'T'HH:mm:ss.S'Z' 距离当前时间过去多久)
 */
+(NSString *)getTimeFromDatetStrTZToStr:(NSString *)datetime;

/**
 时间推移计算 可随分钟 小时 天 月 年 进行推移推算
 */
+(NSString *)getOffsetComponentsTimeStr:(NSInteger)index;

/**
 时间推移计算 偏移多少年
 */
+(NSString *)getOffsetTimeStrWithStart:(BOOL)start year:(NSInteger)year;

/**
 时间推移计算 偏移多少月 跨度为一个月 以originDate月份为起点月份
 */
+(NSString *)getOffsetTimeStrWithStart:(BOOL)start offictMonth:(NSInteger)offictMonth originDate:(NSDate *)originDate;

/**
 时间推移计算 随天进行推移推算
 */
+(NSString *)getOffsetComponentsTimeStrWithOffsetDayCount:(NSInteger)offsetDayCount;

/**
 时间推移计算 指定时间(yyyy-MM-dd'T'HH:mm:ss.S'') 随天进行推移推算
 */
+(NSString *)getOffsetComponentsTimeStrWithStartTime:(NSString *)startTime  offsetDayCount:(NSInteger)offsetDayCount;

/**
 时间间隔
 */
+(NSString *)timeIntervalSinceDate:(NSString *)datetime isTeacher:(BOOL)isTeacher;

/**
 计算两个时间的间隔 返回秒单位
 */
+(NSString *)timeIntervalSinceStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/**
 时间换算 秒换算
 */
+(NSString *)timeIntervalHastaken:(NSInteger)hasTaken;

/**
 两个时间相差小时(yyyy-MM-dd'T'HH:mm:ss.S'')
 */
+(NSInteger)intervalSinceNowFromTZ:(NSString *)datetime;

/**
 时间减天数
 */
+(NSString *)dateDecDays:(NSInteger)day currentDate:(NSDate *)cDate DateFormat:(NSString *)format;

/**
 时间加天数
 */
+(NSString *)dateAddDays:(NSInteger)day currentDate:(NSDate *)cDate DateFormat:(NSString *)format;

/**
 时间戳转换时分秒
 */
+(NSString *)getTimeFromSec:(long)sec;

/**
 两个时间比较大小
 */
+ (NSInteger)compareDate:(NSDate*)aDate withDate:(NSDate*)bDate;

/**
 计算当天是周几 返回int型
 */
+(NSInteger )getIntWeekDayWithDate:(NSDate *)date;

/**
 出生时间转年龄
 */
+(NSInteger)sptimeToAge:(long)sptime;

/**
 判断当前时间是否处于某个时间段内
 */
+(BOOL)validateWithDatetime:(NSDate *)inputTime startTime:(NSDate *)startTime endTime:(NSDate *)endTime;

/**
 判断两个时间是否同一天  type:1表示是否同年，2表示是否同月，3表示是否同日
 */
+(BOOL)isSamePeriod:(NSDate *)date1 date2:(NSDate *)date2 compareType:(NSInteger)type;

/**
 判断和当前时间是否同一周
 */
+(BOOL)isSameWeekWithDate:(NSDate *)date;

/**
 获取某月的天数
 */
+(NSInteger)getNumberOfDaysInMonth:(NSDate *)date;

/**
 *  获取当月中所有天数
 */
+(NSArray *)getAllDaysWithCalender:(NSDate *)currentDate;

/**
 获取当前周中所有天数
 */
+(NSArray *)getAllDaysWithWeek:(NSDate *)currentDate;

/**
 获取当前周中所有天数 传入时间格式
 */
+(NSArray *)getAllDaysWithWeek:(NSDate *)currentDate dateFormat:(NSString *)format;

/**
 *  获取指定的日期是星期几
 */
+(NSString *)getweekDayWithDate:(NSDate *)date;

/**
 系统时间转换为当前时区时间
 */
+(NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;

//*************************************************字符串处理************************************************************

/**
 获得设备型号
 */
+(NSString *)getCurrentDeviceModel;

/**
 MD5 16位加密
 */
+(NSString *)MD5_16:(NSString *)str;

/**
 正则匹配用户密码6-18位数字和字母组合
 */
+(BOOL)checkPassword:(NSString *)password;

/**
 正则匹配用户姓名,20位的中文或英文
 */
+(BOOL)checkUserName:(NSString *)userName;

/**
 正则匹配用户身份证号
 */
+(BOOL)checkUserIdCard:(NSString *)idCard;

/**
 正则匹配工号,12位的数字
 */
+(BOOL)checkEmployeeNumber:(NSString *)number;

/**
 正则匹配URL
 */
+(BOOL)checkURL:(NSString *)url;

/**
 手机号格式化(去掉"-"间隔)
 */
+(NSString *)dealWithPhoneNumber:(NSString *)phone;

/**
 正则匹配手机号
 */
+(BOOL)isPhoneNumber:(NSString *)phoneNum;

/**
 正则匹配手机号
 */
+(BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 验证邮箱
 */
+(BOOL)isValidateEmail:(NSString *)Email;

/**
 判断字符串是否为纯数字
 */
+ (BOOL)isPureInt:(NSString*)string;

/**
 截取字符串中两个指定字符串中间的字符串
 */
+ (NSString *)subString:(NSString *)sourceStr From:(NSString *)startStr to:(NSString *)endStr;

/**
 表情符号的判断
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 随机字符串
 */
+ (NSString *)randomStringWithLength:(NSUInteger)lenght;

//*************************************************json************************************************************

/*
 把格式化的JSON格式的字符串转换成字典
 */
+(NSDictionary *)jsonStringToDictionary:(NSString *)jsonString;

/**
 字典转换成json字符串
 */
+(NSString *)dictionaryToJsonString:(id)object;

//*************************************************color\image\view*****************************************************

/**
 随机颜色
 */
+(UIColor *)randomColor;

/**
 color转image
 */
+(UIImage *)imageWithColor:(UIColor *)color;

//图片的生成

/**
 color转image，设置固定高度
 */
+(UIImage *)imageWithColor:(UIColor *)color andHeight:(CGFloat)height;

/**
 根据URL获取图片尺寸
 */
+(CGSize)getImageSizeWithURL:(id)imageURL;


/**
 将视图View保存为图片
 */
+(UIImage *)createViewImage:(UIView *)shareView;

/**
 view局部截图
 */
+ (UIImage *)screenshotWithView:(UIView *)view Rect:(CGRect)rect;

/**

 照片获取本地路径转换
 */
+ (NSString *)getImagePath:(UIImage *)Image;

/**
 压缩视频并写入沙盒文件
 */
+(void)compressedVideoWithURL:(id)url success:(void(^)(NSString *fileName))success failure:(void(^)(void))failure;

/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize;

/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxSizeWithKB:(CGFloat)maxSize;

/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat)maxSize;


+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
+ (UIImage *)fitToSize:(UIImage *)img size:(CGSize)size;
/**
 UIImage:去色功能的实现（图片灰色显示）
 */
+ (UIImage *)grayImage:(UIImage *)sourceImage;

/**
 画水印
 */
+(UIImage *)imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect originalImage:(UIImage*)originalImage;

/**
 生成二维码
 */
+(UIImage *)encodeQRImageWithContent:(NSString *)content withSize:(CGFloat)size;

/**
 图片压缩到指定大小
 */
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

/**
 画笔颜色
 */
#pragma mark -
+(UIColor *)penColorWithStr:(NSString *)colorStr;

/**
 获取联系人首字母背景颜色
 *  @param textStr  标题首字母
 *
 *  @return 联系人首字母背景颜色
 */
+(UIColor *)textBGColorWithFirstTextStr:(NSString *)textStr;

/**
 打印父类所有视图
 */
+(NSString *)digView:(UIView *)view;

/**
 获取本地版本号
 */
+(NSString *)getAppCurVersion;

@end
