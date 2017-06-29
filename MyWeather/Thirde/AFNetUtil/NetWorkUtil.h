//
//  NetWorkUtil.h
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIMacro.h"
#import "AFNetworking.h"

@interface NetWorkUtil : NSObject

+ (AFHTTPRequestOperationManager *)getManager;

+ (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
    progressHudText:(NSString *)titleText;

+ (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
     sessionID :(NSString *) SessionID
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
        progressHudText:(NSString *)titleText;

// POST
+ (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
      sessionID :(NSString *) SessionID
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
// POST　JSON
+ (void)postPath:(NSString *)path
      parameter:(NSDictionary *)parameter
      sessionID :(NSString *) SessionID
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
// PUT
+ (void)putPath:(NSString *)path
      parameters:(NSDictionary *)parameters
        sessionID :(NSString *) SessionID
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// PUT JSON
+ (void)putPath:(NSString *)path
     parameter:(NSDictionary *)parameter
     sessionID :(NSString *) SessionID
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+ (void)deletePath:(NSString *)path
     parameters:(NSDictionary *)parameters
        sessionID :(NSString *) SessionID
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  上传一张图片
 *
 *  @param URLString  上传接口
 *  @param images     直接传图片
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)uploadImagePostPath:(NSString *)URLString
                      image:(UIImage *)image
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  上传多张图片
 *
 *  @param URLString  上传接口
 *  @param images     直接传图片数组
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)uploadImagesPostPath:(NSString *)URLString
                      images:(NSArray *)images
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  上传图片
 *
 *  @param URLString  上传接口
 *  @param parameters 参数
 *  @param block      拼接图片二进制
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)uploadPostPath:(NSString *)URLString
            parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  上传图片(无进度指示)
 *
 *  @param URLString  上传接口
 *  @param parameters 参数
 *  @param block      拼接图片二进制
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)uploadImageWithoutProgressPostPath:(NSString *)URLString
                                     image:(UIImage *)image
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (NSURL *)urlWith:(NSString *)urlStr parmaters:(NSDictionary *)parmaters;


@end
