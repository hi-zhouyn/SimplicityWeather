//
//  AFNetUtil.h
//  Xiaojs-XMI
//
//  Created by 王强 on 2017/1/6.
//  Copyright © 2017年 xiaojs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

#ifndef kIsNetwork
#define kIsNetwork     [NetworkHelper isNetwork]  // 一次性判断是否有网
#endif

#ifndef kIsWWANNetwork
#define kIsWWANNetwork [NetworkHelper isWWANNetwork]  // 一次性判断是否为手机网络
#endif

#ifndef kIsWiFiNetwork
#define kIsWiFiNetwork [NetworkHelper isWiFiNetwork]  // 一次性判断是否为WiFi网络
#endif

typedef NS_ENUM(NSUInteger, NetworkStatusType)
{
    /** 未知网络*/
    NetworkStatusUnknown,
    /** 无网络*/
    NetworkStatusNotReachable,
    /** 手机网络*/
    NetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    NetworkStatusReachableViaWiFi
};

/** 请求成功的Block */
typedef void(^AFHttpRequestSuccess)(NSURLSessionDataTask *task, id responseObject);

/** 请求失败的Block */
typedef void(^AFHttpRequestFailed)(NSURLSessionDataTask *task, NSError *error);

/** 缓存的Block */
typedef void(^AFHttpRequestCache)(id responseCache);

/** 上传的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小 */
typedef void (^AFHttpUploadProgress)(NSProgress *progress,NSURLSessionTask *uploadTask);

/** 下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小 */
typedef void (^AFHttpDownloadProgress)(NSProgress *progress,NSURLSessionDownloadTask *downloadTask);

/** 回调参数filePath:文件的路径 */
typedef void (^AFHttpFilePath)(NSString *filePath);

/** 下载失败的Block */
typedef void(^AFHttpDownloadFailed)(NSURLResponse *response, NSError *error);

/** 网络状态的Block*/
typedef void(^AFNetworkStatus)(NetworkStatusType status);

@interface AFNetUtil : NSObject

+ (AFHTTPSessionManager *)getAFHTTPManager;

/**
 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)networkStatusWithBlock:(AFNetworkStatus)networkStatus;

/**
 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;

/**
 手机网络:YES, 反之:NO
 */
+ (BOOL)isWWANNetwork;

/**
 WiFi网络:YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork;

/**
 取消所有HTTP请求
 */
+ (void)cancelAllRequest;

/**
 取消指定path的HTTP请求
 */
+ (void)cancelRequestWithPath:(NSString *)path;


/**
 *  GET请求
 *
 *  @param path          请求地址
 *  @param parameters    请求参数
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)getPath:(NSString *)path
                            parameters:(id)parameters
//                         responseCache:(AFHttpRequestCache)responseCache
                               success:(AFHttpRequestSuccess)success
                               failure:(AFHttpRequestFailed)failure;


/**
 *  POST请求
 *
 *  @param path          请求地址
 *  @param parameters    请求参数
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)postPath:(NSString *)path
                             parameters:(id)parameters
                                success:(AFHttpRequestSuccess)success
                                failure:(AFHttpRequestFailed)failure;

/**
 *  PUT请求
 *
 *  @param path          请求地址
 *  @param parameters    请求参数
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)putPath:(NSString *)path
                            parameters:(id)parameters
                               success:(AFHttpRequestSuccess)success
                               failure:(AFHttpRequestFailed)failure;

/**
 *  PATCH请求
 *
 *  @param path          请求地址
 *  @param parameters    请求参数
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)patchPath:(NSString *)path
                              parameters:(id)parameters
                                 success:(AFHttpRequestSuccess)success
                                 failure:(AFHttpRequestFailed)failure;

/**
 *  DELETE请求
 *
 *  @param path          请求地址
 *  @param parameters    请求参数
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)deletePath:(NSString *)path
                               parameters:(id)parameters
                                  success:(AFHttpRequestSuccess)success
                                  failure:(AFHttpRequestFailed)failure;

/**
 *  上传图片文件
 *
 *  @param path       请求地址
 *  @param parameters 请求参数
 *  @param images     图片数组
 *  @param name       文件对应服务器上的字段
 *  @param fileName   文件名
 *  @param mimeType   图片文件的类型,例:png、jpeg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)uploadWithURL:(NSString *)path
                                  parameters:(id)parameters
                                      images:(NSArray<UIImage *> *)images
                                        name:(NSString *)name
                                    fileName:(NSString *)fileName
                                    mimeType:(NSString *)mimeType
                                    progress:(AFHttpUploadProgress)progress
                                     success:(AFHttpRequestSuccess)success
                                     failure:(AFHttpRequestFailed)failure;

/**
 *  下载文件
 *
 *  @param path     请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)path
                                       fileDir:(NSString *)fileDir
                                      progress:(AFHttpDownloadProgress)progress
                                       success:(AFHttpFilePath)success
                                       failure:(AFHttpDownloadFailed)failure;


/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask;

/**
 请求地址格式化
 
 @param urlStr 请求path
 @param parameters 请求参数
 @return 返回请求地址
 */
+ (NSURL *)urlWith:(NSString *)urlStr parameters:(NSDictionary *)parameters;

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
