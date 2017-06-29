//
//  NSString+CSTransform.m
//  JuCaiBang
//
//  Created by 21Lovetong on 15/9/23.
//
//

#import "NSString+CSTransform.h"

@implementation NSString (CSTransform)

- (NSString *)setFormatPhoneNum
{
    
    if (self.length<8) {
        return self;
    }
    NSMutableString *num = [NSMutableString stringWithString:self];
    if ([self isPhoneNum]) {
        [num insertString:@"-" atIndex:3];
        [num insertString:@"-" atIndex:8];
    }else{
        [num insertString:@"-" atIndex:3];
        [num insertString:@"-" atIndex:7];
    }
    return num;
}

- (BOOL)isPhoneNum {
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePre evaluateWithObject:self];
}

- (BOOL)isEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPre = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailPre evaluateWithObject:self];
}

- (BOOL)isLoginPassword {
    if (!self.length) {
        KShowAlert(nil, @"登录密码不能为空");
        return NO;
    } if (self.length < 6) {
        KShowAlert(nil, @"登录密码必须为6-12位数字和字母组合，区分大小写。");
        return NO;
    } if (![self isRepeat]) {
        if ([self isNumberAndLetter]) {
            return YES;
        } else {
            KShowAlert(nil, @"登录密码必须为6-12位数字和字母组合，区分大小写。");
            return NO;
        }
    }
    KShowAlert(nil, @"密码中不能包含3个连续相同字符");
    return NO;
}

- (BOOL)isPayPassword {
    if (!self.length) {
        KShowAlert(nil, @"密码不能为空");
        return NO;
    } if (self.length < 6) {
        KShowAlert(nil, @"密码必须是6位数字");
        return NO;
    } if (![self isRepeat]) {
        if (![self isStretch]) {
            return YES;
        } else {
            KShowAlert(nil, @"密码不能使用连续数字");
            return NO;
        }
    }
    KShowAlert(nil, @"密码不能使用相同数字");
    return NO;
}

- (NSString *)letter {
    if (self) {
        NSMutableString *letter = [[NSMutableString alloc] initWithString:self];
        CFStringTransform((__bridge CFMutableStringRef)letter, 0, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)letter, 0, kCFStringTransformStripDiacritics, NO);
        return [letter capitalizedString];
    }
    return @"";
}

- (NSString *)firstLetter {
    if (self.letter.length) {
        return [self.letter substringToIndex:1];
    }
    return @"";
}

/**
 *  判断连续
 *
 *  @return 连续返回 YES、不连续返回 NO
 */
- (BOOL)isStretch {
    int stretchStep = 0;
    BOOL isStretch = NO;
    for (int i = 0; i < self.length - 1; i++) {
        if ([self characterAtIndex:i] + 1 == [self characterAtIndex:i + 1]) {
            stretchStep++;
            if (stretchStep >= 2) {
                isStretch = YES;
                break;
            }
        } else {
            isStretch = NO;
            stretchStep = 0;
        }
    }
    return isStretch;
}

/**
 *  判断只有数字和字母、且不为全数字或全字母
 *
 *  @return 数字和字母都有返回 YES、全数字或全字母返回 NO
 */
- (BOOL)isNumberAndLetter {
    NSString *numLetRegex = @"[0-9]*(([a-zA-Z]+[0-9]+)|([0-9]+[a-zA-Z]+))+[a-zA-Z]*";
    NSPredicate *phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numLetRegex];
    BOOL isNumLet = [phonePre evaluateWithObject:self];
    return isNumLet;
}

/**
 *  判断连续3个或以上重复
 *
 *  @return 如果3个或以上重复返回 YES、没有3个或以上重复返回 NO
 */
- (BOOL)isRepeat {
    NSString *repeatRegex = @"^.*(.)\\1{2}.*$";
    NSPredicate *phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",repeatRegex];
    BOOL isRepeat = [phonePre evaluateWithObject:self];
    return isRepeat;
}

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

/////获取工作日，比传入的时间多一天
+ (NSString *)getWorkDayFromDate:(NSString *)dat
{
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate  setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [formate dateFromString:dat];
    NSDate *furture = [date dateByAddingTimeInterval:24*60*60];
    NSString *furStr = [[[formate stringFromDate:furture] componentsSeparatedByString:@" "] firstObject];
    return furStr;
}
////加两日
+ (NSString *)getMoneyWorkDayFromDate:(NSString *)dat
{
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate  setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [formate dateFromString:dat];
    NSDate *furture = [date dateByAddingTimeInterval:2*24*60*60];
    NSString *furStr = [[[formate stringFromDate:furture] componentsSeparatedByString:@" "] firstObject];
    return furStr;
}
///金额加上逗号
+ (NSString *)makeDownNumTextWithDouHao:(NSString *)text
{
    NSMutableString *str = [NSMutableString stringWithString:text];
    NSArray *arr1 = [str componentsSeparatedByString:@"."];
    NSArray *arr2 = [str componentsSeparatedByString:@"元"];
    NSArray *arr3 = [str componentsSeparatedByString:@"万"];
     NSString *numStr = @"";
    if (arr1.count > 1) {
        numStr = [arr1 firstObject];
    }else{
        if (arr2.count > 1) {
            numStr = [arr2 firstObject];
        }else if (arr3.count > 1){
            numStr = [arr3 firstObject];
        }else{
            numStr = text;
        }
    }
    NSInteger length = numStr.length;
    if (length > 3 && length < 7) {
        [str insertString:@"," atIndex:length-3];
    }else if (length > 6 && length < 10){
        [str insertString:@"," atIndex:length-3];
        [str insertString:@"," atIndex:length-6];
    }else if(length > 10 && length < 13){
        [str insertString:@"," atIndex:length-3];
        [str insertString:@"," atIndex:length-6];
        [str insertString:@"," atIndex:length-9];
    }else{
        [str insertString:@"," atIndex:length-3];
        [str insertString:@"," atIndex:length-6];
        [str insertString:@"," atIndex:length-9];
        [str insertString:@"," atIndex:length-12];
    }
    return str;
}


+ (NSString *)getPriceFormatWithPrice:(NSString *)price{
    
    NSArray *str = [price componentsSeparatedByString:@","];
    price = [str componentsJoinedByString:@""];
    
    NSString *unit = @".";
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    [formatter setUsesGroupingSeparator:YES];
    if ([price rangeOfString:unit].location != NSNotFound) {
        NSArray *numberArr = [price componentsSeparatedByString:unit];
        NSNumber *nn = [NSNumber numberWithLongLong:[[numberArr firstObject] longLongValue]];
        NSString *str = [formatter stringFromNumber:nn];
        @try {
            return  [NSString stringWithFormat:@"%@.%@",str,[numberArr[1] substringToIndex:2]];

        }
        @catch (NSException *exception) {
            return  [NSString stringWithFormat:@"%@.%@",str,numberArr[1]];

        }
    }
    return [formatter stringFromNumber:[NSNumber numberWithLongLong:[price longLongValue]]];
}

+ (NSString *)getNoFormatValue:(NSString *)string
{
    NSArray *str = [string componentsSeparatedByString:@","];
    return [str componentsJoinedByString:@""];
}

@end
