//
//  NetWorkUtil.m
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import "NetWorkUtil.h"
#import "AFURLRequestSerialization.h"
@implementation NetWorkUtil

//GET － 指示器
+ (void)getPath:(NSString *)path
        parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
        progressHudText:(NSString *)titleText
{
    kprogressHudShow(titleText);
    
    [NetWorkUtil getPath:path parameters:parameters sessionID:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        kprogressHudHide;
        BaseModel *model = [BaseModel objectFromJSON:responseObject];
        if (model.status == 1) {// 成功条件
            success(operation,responseObject);
        }else{
           
            KShowAlert(nil, model.msg);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        KShowAlert(nil,[error description]);
        kprogressHudHide;
        failure(operation,error);
    }];
}

//GET
+ (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
     sessionID :(NSString *) SessionID
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *url = [[NSString stringWithFormat:@"%@%@",APIBASEAnother,path] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [NetWorkUtil getManager];
    [manager.requestSerializer setValue:SessionID forHTTPHeaderField:@"apikey"];
    [manager GET:url parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        kShowError;
        failure(operation,error);
    }];
}

//POST － 指示器
+ (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
 progressHudText:(NSString *)titleText
{
    kprogressHudShow(titleText);
    [NetWorkUtil postPath:path parameters:parameters  sessionID:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        kprogressHudHide;
        BaseModel *model = [BaseModel objectFromJSON:responseObject];
        if (model.status == 1) {// 成功条件
            success(operation,responseObject);
        }else{
            if ((([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0f) ? YES : NO)) {
                KShowAlert1(nil, model.msg);
            }else
            {
            KShowAlert(nil, model.msg);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KShowAlert(nil,[error description]);
        kprogressHudHide;
        failure(operation,error);
    }];
}
//POST
+ (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
       sessionID:(NSString *)SessionID
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",APIBASE,path];
    AFHTTPRequestOperationManager *manager = [NetWorkUtil getManager];
    [manager.requestSerializer setValue:SessionID forHTTPHeaderField:@"SessionID"];
    [manager POST:url parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        kShowError;
        failure(operation,error);
    }];
    
}



// PUT
+(void) putPath:(NSString *)path parameters:(NSDictionary *)parameters sessionID:(NSString *)SessionID success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",APIBASE,path];

    AFHTTPRequestOperationManager *manager = [NetWorkUtil getManager];
    [manager.requestSerializer setValue:SessionID forHTTPHeaderField:@"SessionID"];

//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [manager PUT:url parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        kShowError;
        failure(operation,error);
    }];
}
//POST JSON
+ (void)postPath:(NSString *)path
       parameter:(NSDictionary *)parameter
       sessionID:(NSString *)SessionID
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",APIBASE,path];
    AFHTTPRequestOperationManager *manager = [NetWorkUtil getManager];
    //     申明返回的结果是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //     申明请求的结果是json类型
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:SessionID forHTTPHeaderField:@"SessionID"];
    [manager.requestSerializer setValue:@"4" forHTTPHeaderField:@"KA"];
    [manager POST:url parameters:parameter success:success failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        kShowError;
        failure(operation,error);
    }];
    
}


// PUT JSON
+(void) putPath:(NSString *)path parameter:(NSDictionary * )parameter sessionID:(NSString *)SessionID success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",APIBASE,path];
    
    AFHTTPRequestOperationManager *manager = [NetWorkUtil getManager];
//     申明返回的结果是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//     申明请求的结果是json类型
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:SessionID forHTTPHeaderField:@"SessionID"];
    [manager.requestSerializer setValue:@"4" forHTTPHeaderField:@"KA"];
    [manager PUT:url parameters:parameter success:success failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        kShowError;
        failure(operation,error);
    }];
    
}


// DELETE
+(void) deletePath:(NSString *)path parameters:(NSDictionary *)parameters sessionID:(NSString *)SessionID success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",APIBASE,path];
    AFHTTPRequestOperationManager *manager = [NetWorkUtil getManager];
     [manager.requestSerializer setValue:SessionID forHTTPHeaderField:@"SessionID"];
//    [manager.requestSerializer setValue:@"4" forHTTPHeaderField:@"KA"];
    [manager DELETE:url parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        kShowError;
        failure(operation,error);
    }];
}




+ (void)uploadImagePostPath:(NSString *)URLString
                      image:(UIImage *)image
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [NetWorkUtil uploadPostPath:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"form-data0" fileName:@"form-data0" mimeType:@"image/jpeg"];
    } success:success failure:failure];
}

+ (void)uploadImageWithoutProgressPostPath:(NSString *)URLString
                                     image:(UIImage *)image
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [NetWorkUtil uploadWithoutProgressPostPath:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"form-data0" fileName:@"form-data0" mimeType:@"image/jpeg"];
    } success:success failure:failure];
}

+ (void)uploadImagesPostPath:(NSString *)URLString
                      images:(NSArray *)images
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [NetWorkUtil uploadPostPath:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < images.count; i++) {
            UIImage *image = images[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@%d", @"form-data", i] fileName:[NSString stringWithFormat:@"%@%d", @"form-data", i] mimeType:@"image/jpeg"];
        }
    } success:success failure:failure];
}

+ (void)uploadWithoutProgressPostPath:(NSString *)URLString
            parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    URLString = [NSString stringWithFormat:@"%@%@", APIBASE, URLString];
    AFHTTPRequestOperationManager *manager = [NetWorkUtil getManager];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

+ (void)uploadPostPath:(NSString *)URLString
            parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    kprogressHudShow(@"正在上传…");
    URLString = [NSString stringWithFormat:@"%@%@", APIBASE, URLString];
    AFHTTPRequestOperationManager *manager = [NetWorkUtil getManager];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
        kprogressHudHide;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
        kprogressHudHide;
    }];
    
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        CGFloat progress = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
//        NSString *progressValueStr = Float1ToString(progress * 100);
//        NSString *progressTitle = Format3Str(@"已上传", progressValueStr, @"%");
//        kprogressHudShow(progressTitle);
//    }];
}


+ (AFHTTPRequestOperationManager *)getManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"4" forHTTPHeaderField:@"KA"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"KAV"];
//    manager.securityPolicy=[AFSecurityPolicypolicy WithPinningMode:AFSSLPinningModeNone];
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects: @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/xml",@"text/plain",@"text/application",nil];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@%@",@"JSESSIONID=",kAppDelegate.modelUserLoction.cookie] forHTTPHeaderField:@"cookie"];
    
    return manager;
}


+ (NSURL *)urlWith:(NSString *)urlStr parmaters:(NSDictionary *)parmaters
{
    NSString *par = @"";
    for (NSString *key in [parmaters allKeys]) {
        if ([par length] == 0) {
            par = [NSString stringWithFormat:@"?%@=%@", key, [parmaters objectForKey:key]];
        } else {
            par = [NSString stringWithFormat:@"%@&%@=%@", par,key, [parmaters objectForKey:key]];
        }
    }
    urlStr = [NSString stringWithFormat:@"%@%@%@", APIBASE, urlStr, par];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return url;
}


@end
