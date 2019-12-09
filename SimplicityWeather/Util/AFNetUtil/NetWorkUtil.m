//
//  NetWorkUtil.m
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import "NetWorkUtil.h"

@implementation NetWorkUtil

//GET
+ (void)getPath:(NSString *)path
     parameters:(id)parameters
        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];

    AFHTTPSessionManager *manager = [NetWorkUtil getManager];
    
    [manager GET:url parameters:parameters progress:nil success:success failure:^(NSURLSessionDataTask *task, NSError *error){
        failure(task,error);
    }];
}

//POST
+ (void)postPath:(NSString *)path
      parameters:(id)parameters
         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];

    AFHTTPSessionManager *manager = [NetWorkUtil getManager];

    [manager POST:url parameters:parameters progress:nil success:success failure:^(NSURLSessionDataTask *task,NSError *error){
        failure(task,error);
    }];
}

//POST JSON
+ (void)postJsonPath:(NSString *)path
          parameters:(id)parameters
             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];
    
    AFHTTPSessionManager *manager = [NetWorkUtil getManagerJson];
    
    [manager POST:url parameters:parameters progress:nil success:success failure:^(NSURLSessionDataTask *task,NSError *error){
        failure(task,error);
    }];
}

//PUT
+(void)putPath:(NSString *)path
    parameters:(id)parameters
       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];
    
    AFHTTPSessionManager *manager = [NetWorkUtil getManager];
    
    [manager PUT:url parameters:parameters success:success failure:^(NSURLSessionDataTask *task,NSError *error){
        failure(task,error);
    }];
}

//PUT JSON
+(void)putJsonPath:(NSString *)path
        parameters:(id)parameters
           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];
    
    AFHTTPSessionManager *manager = [NetWorkUtil getManagerJson];
    
    [manager PUT:url parameters:parameters success:success failure:^(NSURLSessionDataTask *task,NSError *error){
        failure(task,error);
    }];
    
}

//PATCH
+(void)patchPath:(NSString *)path
      parameters:(id)parameters
         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];
    
    AFHTTPSessionManager *manager = [NetWorkUtil getManager];
    
    [manager PATCH:url parameters:parameters success:success failure:^(NSURLSessionDataTask *task,NSError *error){
        failure(task,error);
    }];
}

//PATCH JSON
+(void)patchJsonPath:(NSString *)path
          parameters:(id)parameters
             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];
    
    AFHTTPSessionManager *manager = [NetWorkUtil getManagerJson];
    
    [manager PATCH:url parameters:parameters success:success failure:^(NSURLSessionDataTask *task,NSError *error){
        failure(task,error);
    }];
}

//DELETE
+(void)deletePath:(NSString *)path
       parameters:(id)parameters
          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];
    
    AFHTTPSessionManager *manager = [NetWorkUtil getManager];
    
    [manager DELETE:url parameters:parameters success:success failure:^(NSURLSessionDataTask *task,NSError *error){
        failure(task,error);
    }];
}

//上传一张图片
+ (void)uploadImagePostPath:(NSString *)URLString
                      image:(UIImage *)image
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [NetWorkUtil uploadPostPath:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"form-data0" fileName:@"form-data0" mimeType:@"image/jpeg"];
    } success:success failure:failure];
}

//上传多张图片
+ (void)uploadImagesPostPath:(NSString *)URLString
                      images:(NSArray *)images
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [NetWorkUtil uploadPostPath:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < images.count; i++) {
            UIImage *image = images[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@%d", @"form-data", i] fileName:[NSString stringWithFormat:@"%@%d", @"form-data", i] mimeType:@"image/jpeg"];
        }
    } success:success failure:failure];
}

//上传图片
+ (void)uploadPostPath:(NSString *)URLString
            parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    URLString = [NSString stringWithFormat:@"%@%@", HTTP_BASE, URLString];
    
    AFHTTPSessionManager *manager = [NetWorkUtil getManager];
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
    
//    [task setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        CGFloat progress = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
//        NSString *progressValueStr = Float1ToString(progress * 100);
//        NSString *progressTitle = Format3Str(@"已上传", progressValueStr, @"%");
//        kprogressHudShow(progressTitle);
//    }];
}

+ (AFHTTPSessionManager *)getManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];

    [manager.requestSerializer setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [manager.requestSerializer setTimeoutInterval:30.0];
    [manager.requestSerializer setValue:@"4" forHTTPHeaderField:@"XA"];
    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"XAV"];
    //[manager.requestSerializer setValue:[NSString stringWithFormat:@"%@%@",@"JSESSIONID=",kAppDelegate.modelUserLoction.cookie] forHTTPHeaderField:@"cookie"];

    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects: @"application/json",@"application/text",@"application/xml", @"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain",@"text/application",@"image/*",nil];
    
    return manager;
}

+ (AFHTTPSessionManager *)getManagerJson
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    //申明请求为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [manager.requestSerializer setTimeoutInterval:30.0];
    [manager.requestSerializer setValue:@"4" forHTTPHeaderField:@"XA"];
    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"XAV"];
    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[manager.requestSerializer setValue:[NSString stringWithFormat:@"%@%@",@"JSESSIONID=",kAppDelegate.modelUserLoction.cookie] forHTTPHeaderField:@"cookie"];
    
    //申明响应为json类型
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json",@"application/text",@"application/xml", @"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain",@"text/application",@"image/*",nil];
    
    return manager;
}

+ (NSURL *)urlWith:(NSString *)urlStr parmaters:(NSDictionary *)parmaters
{
    NSString *par = @"";
    
    for (NSString *key in [parmaters allKeys])
    {
        if ([par length] == 0) {
            par = [NSString stringWithFormat:@"?%@=%@", key, [parmaters objectForKey:key]];
        } else {
            par = [NSString stringWithFormat:@"%@&%@=%@", par,key, [parmaters objectForKey:key]];
        }
    }
    
    urlStr = [NSString stringWithFormat:@"%@%@%@", HTTP_BASE, urlStr, par];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return url;
}

+ (NSString *)AFNetErrorCode:(NSError *)error
{
    NSString *errorStr = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
    
    NSDictionary *dict = [Common jsonStringToDictionary:errorStr];
    
    if (dict)
    {
        return dict[@"ec"];
    }

    return nil;
}

+ (NSString *)AFNetErrorDetails:(NSError *)error
{
    NSString *errorStr = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
    
    NSDictionary *dict = [Common jsonStringToDictionary:errorStr];
    
    if (dict)
    {
        return dict[@"details"];
    }
    
    return nil;
}

@end
