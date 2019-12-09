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


+ (AFHTTPSessionManager *)getManager;


/**
 GET

 @param path        接口
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+ (void)getPath:(NSString *)path
     parameters:(id)parameters
        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 POST

 @param path        接口
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+ (void)postPath:(NSString *)path
      parameters:(id)parameters
         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 POST JSON

 @param path        接口
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+ (void)postJsonPath:(NSString *)path
          parameters:(id)parameters
             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 PUT

 @param path        接口
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+(void)putPath:(NSString *)path
    parameters:(id)parameters
       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 PUT JSON

 @param path        接口
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+(void)putJsonPath:(NSString *)path
        parameters:(id)parameters
           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 PATCH
 
 @param path        接口
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+(void)patchPath:(NSString *)path
      parameters:(id)parameters
         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 PATCH JSON
 
 @param path        接口
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+(void)patchJsonPath:(NSString *)path
          parameters:(id)parameters
             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 DELETE

 @param path        接口
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+(void)deletePath:(NSString *)path
       parameters:(id)parameters
          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  上传一张图片
 *
 *  @param URLString  上传接口
 *  @param image      直接传图片
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)uploadImagePostPath:(NSString *)URLString
                      image:(UIImage *)image
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

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
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
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
               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 请求地址格式化

 @param urlStr 请求URL
 @param parmaters 请求参数
 @return 返回请求地址
 */
+ (NSURL *)urlWith:(NSString *)urlStr parmaters:(NSDictionary *)parmaters;

/**
 后台返回错误码

 @param error 服务器错误信息
 @return 返回错误代码
 */
+ (NSString *)AFNetErrorCode:(NSError *)error;

/**
 后台返回错误详情
 
 @param error 服务器错误信息
 @return 返回错误详情
 */
+ (NSString *)AFNetErrorDetails:(NSError *)error;

@end
