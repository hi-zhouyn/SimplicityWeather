//
//  UserDefaults.m
//  Xiaojs-XMI
//
//  Created by  on 2016/11/9.
//  Copyright © 2016年 xiaojs. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

//**************************************************************************************************************
//登录信息

//保存登录手机号 登录密码
+(void)saveUserPhone:(NSString *)phone Password:(NSString *)pwd
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:phone forKey:@"userPhone"];
    [userDefaults setObject:pwd forKey:@"password"];
    [userDefaults synchronize];
}

//读取登录手机号
+(NSString *)getUserPhone
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefaults objectForKey:@"userPhone"];
    if (value){
        return value;
    }else{
        return @"";
    }
}

//读取登录密码
+(NSString *)getUserPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefaults objectForKey:@"password"];
    if (value){
        return value;
    }else{
        return @"";
    }
}

+(void)saveUserAccountID:(NSString *)accountID AccountName:(NSString *)accountName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:accountID forKey:@"accountID"];
    [userDefaults setObject:accountName forKey:@"accountName"];
    [userDefaults synchronize];
}

+(NSString *)getUserAccountID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefaults objectForKey:@"accountID"];
    if (value){
        return value;
    }else{
        return @"";
    }
}

+(NSString *)getUserAccountName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefaults objectForKey:@"accountName"];
    if (value){
        return value;
    }else{
        return @"";
    }
}

+(void)removeUserAccountName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"accountID"];
    [userDefaults removeObjectForKey:@"accountName"];
    [userDefaults synchronize];
}

+(void)saveUserSessionID:(NSString *)sessionID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:sessionID forKey:@"sessionID"];
    [userDefaults synchronize];
}

+(NSString *)getUserSessionID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefaults objectForKey:@"sessionID"];
    return value;
}

+(void)removeUserSessionID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"sessionID"];
    [userDefaults synchronize];
}


//保存登录状态
+(void)saveLoginStatus:(BOOL)login
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:login forKey:@"isLogin"];
    [userDefaults synchronize];
}

//读取登录状态
+(BOOL)getLoginStatus
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:@"isLogin"];
}


//保存是否认证状态
+(void)saveIsVerifiedStatus:(BOOL)isVerified
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isVerified forKey:@"isVerified"];
    [userDefaults synchronize];
}

//读取是否认证状态
+(BOOL)getIsVerifiedStatus
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:@"isVerified"];
}


/**
 保存是否有新消息
 */
+(void)saveIsNewMessage:(BOOL)isNew
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isNew forKey:@"isNewMessage"];
    [userDefaults synchronize];
}

/**
 读取是否有新消息
 */
+(BOOL)getIsNewMessage
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:@"isNewMessage"];
}

/**
 保存当前场景指导是否显示过
 */
+(void)saveIsShowIntroGuideScene:(BOOL)isShow sceneTypeStr:(NSString *)sceneTypeStr
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults] objectForKey:@"IntroGuideScene"] ] ;
    [dict setValue:[NSNumber numberWithBool:isShow] forKey:sceneTypeStr];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dict forKey:@"IntroGuideScene"];
    [userDefaults synchronize];
}

/**
 读取当前场景指导是否显示过
 */
+(BOOL)getIsShowIntroGuideSceneWithSceneTypeStr:(NSString *)sceneTypeStr
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"IntroGuideScene"]) {
        return NO;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [userDefaults objectForKey:@"IntroGuideScene"]];
    if ([dict objectForKey:sceneTypeStr]) {
        NSNumber *num = (NSNumber *)[dict objectForKey:sceneTypeStr];
        return num.boolValue;
    }else{
        return NO;
    }
}

/**
 保存是否显示过引导页
 */
+(void)saveIsReadGuide:(BOOL)isNew version:(NSString *)version
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults] objectForKey:@"isReadGuide"] ] ;
    [dict setValue:[NSNumber numberWithBool:isNew] forKey:version];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dict forKey:@"isReadGuide"];
    [userDefaults synchronize];
}

/**
 读取是否显示过引导页
 */
+(BOOL)getIsReadGuideWithVersion:(NSString *)version
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"isReadGuide"]) {
        return NO;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [userDefaults objectForKey:@"isReadGuide"]];
    if ([dict objectForKey:version]) {
        NSNumber *num = (NSNumber *)[dict objectForKey:version];
        return num.boolValue;
    }else{
        return NO;
    }
}

/**
 保存是否有新更新
 */
+(void)saveIsReadNewUpDate:(BOOL)isNew version:(NSString *)version
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults] objectForKey:@"isNewUpDate"] ] ;
    [dict setValue:[NSNumber numberWithBool:isNew] forKey:version];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dict forKey:@"isNewUpDate"];
    [userDefaults synchronize];
}

/**
 读取是否有新更新
 */
+(BOOL)getIsReadNewUpDateWithVersion:(NSString *)version
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"isNewUpDate"]) {
        return NO;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [userDefaults objectForKey:@"isNewUpDate"]];
    if ([dict objectForKey:version]) {
        NSNumber *num = (NSNumber *)[dict objectForKey:version];
        return num.boolValue;
    }else{
        return NO;
    }
}

/**
 保存是否显示发现更新
 */
+(void)saveIsShowFindUpDate:(BOOL)isNew
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isNew forKey:@"isShowFindUpDate"];
    [userDefaults synchronize];
}

/**
 读取是否显示发现更新
 */
+(BOOL)getIsShowFindUpDate
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:@"isShowFindUpDate"];
}

/**
 保存AppStore版本号
 */
+(void)saveAppStoreVersion:(NSString *)version
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:version forKey:@"version"];
    [userDefaults synchronize];
}

/**
 读取AppStore版本号
 */
+(NSString *)getAppStoreVersion
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefaults objectForKey:@"version"];
    if (value){
        return value;
    }else{
        return @"";
    }
}

+(NSInteger)getStreamingLevel{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"streamingLevel"] == nil) {
        [userDefaults setInteger:1 forKey:@"streamingLevel"];
    }
    return [userDefaults integerForKey:@"streamingLevel"];
}

+(void)saveStreamingLevel:(NSInteger)level{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:level forKey:@"streamingLevel"];
    [userDefaults synchronize];
}



+(void)saveAPPEnvironment:(NSInteger)environment;
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:environment forKey:@"APPEnvironment"];
    [userDefaults synchronize];
}

+(NSInteger)getAPPEnvironment
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"APPEnvironment"] == nil) {
        [userDefaults setInteger:2 forKey:@"APPEnvironment"];
    }
    
    return [userDefaults integerForKey:@"APPEnvironment"];
}


@end
