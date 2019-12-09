//
//  UserDefaults.h
//  Xiaojs-XMI
//
//  Created by  on 2016/11/9.
//  Copyright © 2016年 xiaojs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DownloadStateIsRuning,
    DownloadStateIsHad,
    DownloadStateIsNot,
    DownloadStateOtherIsRuning,
} DownloadState;


@interface UserDefaults : NSObject

/**
 保存登录手机号 登录密码
 */
+(void)saveUserPhone:(NSString *)phone Password:(NSString *)pwd;

/**
 读取登录手机号
 */
+(NSString *)getUserPhone;

/**
 读取登录密码
 */
+(NSString *)getUserPassword;

/**
 保存用户ID 用户名
 */
+(void)saveUserAccountID:(NSString *)accountID AccountName:(NSString *)accountName;

/**
 读取用户ID
 */
+(NSString *)getUserAccountID;

/**
 读取用户名
 */
+(NSString *)getUserAccountName;

/**
 删除用户ID和用户名
 */
+(void)removeUserAccountName;

/**
 保存SessionID
 */
+(void)saveUserSessionID:(NSString *)sessionID;

/**
 读取SessionID
 */
+(NSString *)getUserSessionID;

/**
 删除SessionID
 */
+(void)removeUserSessionID;


/**
 保存登录状态
 */
+(void)saveLoginStatus:(BOOL)login;

/**
 读取登录状态
 */
+(BOOL)getLoginStatus;


/**
 保存是否认证状态
 */
+(void)saveIsVerifiedStatus:(BOOL)isVerified;

/**
 读取是否认证状态
 */
+(BOOL)getIsVerifiedStatus;


/**
 保存是否有新消息
 */
+(void)saveIsNewMessage:(BOOL)isNew;

/**
 读取是否有新消息
 */
+(BOOL)getIsNewMessage;

/**
 保存是否显示过引导页
 */
+(void)saveIsReadGuide:(BOOL)isNew version:(NSString *)version;

/**
 读取是否显示过引导页
 */
+(BOOL)getIsReadGuideWithVersion:(NSString *)version;

/**
 保存当前场景指导是否显示过
 */
+(void)saveIsShowIntroGuideScene:(BOOL)isShow sceneTypeStr:(NSString *)sceneTypeStr;

/**
 读取当前场景指导是否显示过
 */
+(BOOL)getIsShowIntroGuideSceneWithSceneTypeStr:(NSString *)sceneTypeStr;

/**
 保存是否有新更新
 */
+(void)saveIsReadNewUpDate:(BOOL)isNew version:(NSString *)version;

/**
 读取是否有新更新
 */
+(BOOL)getIsReadNewUpDateWithVersion:(NSString *)version;

/**
 保存是否显示发现更新
 */
+(void)saveIsShowFindUpDate:(BOOL)isNew;

/**
 读取是否显示发现更新
 */
+(BOOL)getIsShowFindUpDate;

/**
 保存AppStore版本号
 */
+(void)saveAppStoreVersion:(NSString *)version;

/**
 读取AppStore版本号
 */
+(NSString *)getAppStoreVersion;


+(void)saveStreamingLevel:(NSInteger)level;

+(NSInteger)getStreamingLevel;


/**
 保存消息服务器sfm
 */
+(void)saveSFM:(NSString*)sfm;

/**
 获取消息服务器sfm
 */
+(NSString*)getSFM;

/**
 删除消息服务器sfm
 */
+(void)removeSFM;


/**
 保存运行环境
 */
+(void)saveAPPEnvironment:(NSInteger)environment;

/**
 读取运行环境
 */
+(NSInteger)getAPPEnvironment;




@end
