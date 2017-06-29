//
//  NSString+CSTransform.h
//  JuCaiBang
//
//  Created by 21Lovetong on 15/9/23.
//
//

#import <Foundation/Foundation.h>

/**
 *  获取 attribute 字典
 *
 *  @param fontSize 字体大小
 *  @param color    字体颜色
 *
 *  @return 字典
 */
//  HelveticaFont
#define KAttributeHelveticaFont(fontSize, color)             [NSString attributeWithHelveticaFontSize:fontSize color:color]
//  PingHeiFont
#define KAttributePingHeiFont(fontSize, color)               [NSString attributeWithPingHeiFontSize:fontSize color:color]

/**
 *  获取带下划线的 attribute 字典
 *
 *  @param fontSize 字体大小
 *  @param color    字体颜色
 *
 *  @return 字典
 */
//  HelveticaFont
#define KUnderlineAttributeHelveticaFont(fontSize, clr)             [NSString underlineAttributeWithHelveticaFontSize:fontSize color:clr]
//  PingHeiFont
#define KUnderlineAttributePingHeiFont(fontSize, clr)               [NSString underLineAttributeWithPingHeiFontSize:fontSize color:clr]

/**
 *  拼接
 */
#define FormatStr(str1, str2)                   [NSString stringWithFormat:@"%@%@",str1, str2]
#define Format3Str(str1, str2, str3)            [NSString stringWithFormat:@"%@%@%@",str1, str2, str3]
#define Format4Str(str1, str2, str3, str4)      [NSString stringWithFormat:@"%@%@%@%@",str1, str2, str3, str4]
/**
 *  第二个字符串带括号拼接
 *
 */
#define FormatStrWithBrackets(str1, str2)                   [NSString stringWithFormat:@"%@(%@)",str1, str2]
/**
 *  int和float直接转string
 */
#define IntToString(i)               [NSString stringWithFormat:@"%ld", i]
#define Float0ToString(f)            [NSString stringWithFormat:@"%.0f", f]
#define Float1ToString(f)            [NSString stringWithFormat:@"%.1f", f]
#define FloatToString(f)             [NSString stringWithFormat:@"%.2f", f]
#define Float3ToString(f)            [NSString stringWithFormat:@"%.3f", f]
#define Float4ToString(f)            [NSString stringWithFormat:@"%.4f", f]

/**
 *  从date中截取日（d）
 */
#define DayRangeInDate              NSMakeRange(8, 2)
#define DayInDate(dateStr)          [[dateStr substringWithRange:DayRangeInDate] integerValue]

/**
 *  从date中截取月（M）
 */
#define MonthRangeInDate              NSMakeRange(5, 2)
#define MonthInDate(dateStr)          [[dateStr substringWithRange:MonthRangeInDate] integerValue]

/**
 *  从date中截取年（y）
 */
#define YearRangeInDate             NSMakeRange(0, 4)
#define YearInDate(dateStr)         [[dateStr substringWithRange:YearRangeInDate] integerValue]

@interface NSString (CSTransform)

/**
 *  汉字转拼音
 */
@property (nonatomic, readonly, strong) NSString *letter;
/**
 *  汉字首字母
 */
@property (nonatomic, readonly, strong) NSString *firstLetter;

- (NSString *)setFormatPhoneNum;

- (BOOL)isPhoneNum;

- (BOOL)isEmail;

- (BOOL)isLoginPassword;

- (BOOL)isPayPassword;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

+ (NSString *)getWorkDayFromDate:(NSString *)dat;
////加两日
+ (NSString *)getMoneyWorkDayFromDate:(NSString *)dat;
///金额加上逗号
+ (NSString *)makeDownNumTextWithDouHao:(NSString *)text;

+ (NSString *)getPriceFormatWithPrice:(NSString *)price;

+ (NSString *)getNoFormatValue:(NSString *)string;
@end
