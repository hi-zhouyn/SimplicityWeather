//
//  AFNetUtil.m
//  Xiaojs-XMI
//
//  Created by 王强 on 2017/1/6.
//  Copyright © 2017年 xiaojs. All rights reserved.
//

#import "AFNetUtil.h"

@implementation AFNetUtil

static NSMutableArray *_allSessionTask;


#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(AFNetworkStatus)networkStatus
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
        {
            switch (status)
            {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(NetworkStatusUnknown) : nil;
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(NetworkStatusNotReachable) : nil;
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(NetworkStatusReachableViaWWAN) : nil;
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(NetworkStatusReachableViaWiFi) : nil;
                    break;
            }
        }];
        
    });
}

+ (BOOL)isNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)cancelAllRequest
{
    // 锁操作
    @synchronized(self)
    {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop)
        {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithPath:(NSString *)path
{
    if (!path) { return; }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];
    
    @synchronized (self)
    {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop)
        {
            if ([task.currentRequest.URL.absoluteString hasPrefix:url])
            {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}


#pragma mark - GET

+ (NSURLSessionTask *)getPath:(NSString *)path
                   parameters:(id)parameters
//                responseCache:(AFHttpRequestCache)responseCache
                      success:(AFHttpRequestSuccess)success
                      failure:(AFHttpRequestFailed)failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];

    
    AFHTTPSessionManager *manager = [self getAFHTTPManager];
    
    NSURLSessionTask *sessionTask = [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress)
    {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [[self allSessionTask] removeObject:task];
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        
        if (httpResponse.statusCode == 304)
        {
            NSLog(@"数据未更新");
        }
        else
        {
            [[self allSessionTask] removeObject:task];
            failure ? failure(task, error) : nil;
        }
        
    }];
    
    //添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;

    return sessionTask;
}


#pragma mark - POST

+ (__kindof NSURLSessionTask *)postPath:(NSString *)path
                             parameters:(id)parameters
                                success:(AFHttpRequestSuccess)success
                                failure:(AFHttpRequestFailed)failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];
    
    AFHTTPSessionManager *manager = [self getAFHTTPManagerJson];
    
    NSURLSessionTask *sessionTask = [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [[self allSessionTask] removeObject:task];
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [[self allSessionTask] removeObject:task];
        failure ? failure(task, error) : nil;
        
    }];
    
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;

    return sessionTask;
}

#pragma mark - PUT

+ (__kindof NSURLSessionTask *)putPath:(NSString *)path
                            parameters:(id)parameters
                               success:(AFHttpRequestSuccess)success
                               failure:(AFHttpRequestFailed)failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];

    AFHTTPSessionManager *manager = [self getAFHTTPManagerJson];

    NSURLSessionTask *sessionTask = [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [[self allSessionTask] removeObject:task];
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [[self allSessionTask] removeObject:task];
        failure ? failure(task, error) : nil;
        
    }];
    
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;

    return sessionTask;
}

#pragma mark - PATCH

+ (__kindof NSURLSessionTask *)patchPath:(NSString *)path
                              parameters:(id)parameters
                                 success:(AFHttpRequestSuccess)success
                                 failure:(AFHttpRequestFailed)failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];
    
    AFHTTPSessionManager *manager = [self getAFHTTPManagerJson];
    
    NSURLSessionTask *sessionTask = [manager PATCH:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [[self allSessionTask] removeObject:task];
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [[self allSessionTask] removeObject:task];
        failure ? failure(task, error) : nil;
        
    }];
    
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - DELETE

+ (__kindof NSURLSessionTask *)deletePath:(NSString *)path
                               parameters:(id)parameters
                                  success:(AFHttpRequestSuccess)success
                                  failure:(AFHttpRequestFailed)failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_BASE,path];
    
    AFHTTPSessionManager *manager = [self getAFHTTPManagerJson];
    
    //需带body参数时，需加上这句，否则参数会拼接到URL
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];

    NSURLSessionTask *sessionTask = [manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [[self allSessionTask] removeObject:task];
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [[self allSessionTask] removeObject:task];
        failure ? failure(task, error) : nil;
        
    }];
    
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 上传图片文件

+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                         parameters:(id)parameters
                             images:(NSArray<UIImage *> *)images
                               name:(NSString *)name
                           fileName:(NSString *)fileName
                           mimeType:(NSString *)mimeType
                           progress:(AFHttpUploadProgress)progress
                            success:(AFHttpRequestSuccess)success
                            failure:(AFHttpRequestFailed)failure
{
    AFHTTPSessionManager *manager = [self getAFHTTPManager];
    
    __block NSURLSessionTask *sessionTask = [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop)
        {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(long)idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType ? mimeType : @"jpeg"]];
            
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress)
    {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress,sessionTask) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [[self allSessionTask] removeObject:task];
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [[self allSessionTask] removeObject:task];
        failure ? failure(task, error) : nil;
        
    }];
    
    //添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(AFHttpDownloadProgress)progress
                              success:(AFHttpFilePath)success
                              failure:(AFHttpDownloadFailed)failure
{
    AFHTTPSessionManager *manager = [self getAFHTTPManager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress)
    {
        NSLog(@"============下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress,downloadTask) : nil;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response)
    {
        //拼接缓存目录 fileDir ? fileDir : @"Download"
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // 判断文件夹是否存在，如果不存在，则创建
        if (![[NSFileManager defaultManager] fileExistsAtPath:downloadDir]) {
            //创建Download目录
            [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
            NSLog(@"文件夹不存在，开始创建");
        } else {
            NSLog(@"文件夹已存在，开始写入");
        }
       
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error)
    {
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(response, error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    
    //开始下载
    [downloadTask resume];
    
    //添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    return downloadTask;
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask
{
    if (!_allSessionTask)
    {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

#pragma mark - 初始化AFHTTPSessionManager相关属性

+ (AFHTTPSessionManager *)getAFHTTPManager
{
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setTimeoutInterval:30.0];
        [manager.requestSerializer setValue:@"4" forHTTPHeaderField:@"XA"];
        [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"XAV"];
        
        //[manager.requestSerializer setValue:[NSString stringWithFormat:@"%@%@",@"JSESSIONID=",kAppDelegate.modelUserLoction.cookie] forHTTPHeaderField:@"cookie"];
        
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json",@"application/text",@"application/xml", @"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain",@"text/application",nil];
    });
    
    
    [manager.requestSerializer setValue:[Common getCurrentTimeString] forHTTPHeaderField:@"cookie"];
    
    return manager;
}

+ (AFHTTPSessionManager *)getAFHTTPManagerJson
{
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        //manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        //申明请求为json类型
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //[manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        [manager.requestSerializer setTimeoutInterval:30.0];
        [manager.requestSerializer setValue:@"4" forHTTPHeaderField:@"XA"];
        [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"XAV"];
        
        //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //[manager.requestSerializer setValue:[NSString stringWithFormat:@"%@%@",@"JSESSIONID=",kAppDelegate.modelUserLoction.cookie] forHTTPHeaderField:@"cookie"];
        
        
        //申明响应为json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json",@"application/text",@"application/xml", @"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain",@"text/application",nil];
    });
    
    [manager.requestSerializer setValue:[Common getCurrentTimeString] forHTTPHeaderField:@"cookie"];
    
    return manager;
}

+ (NSURL *)urlWith:(NSString *)urlStr parameters:(NSDictionary *)parameters
{
    NSString *paramete = @"";
    
    for (NSString *key in [parameters allKeys])
    {
        if ([paramete length] == 0)
        {
            paramete = [NSString stringWithFormat:@"?%@=%@", key, [parameters objectForKey:key]];
        }
        else
        {
            paramete = [NSString stringWithFormat:@"%@&%@=%@", paramete,key, [parameters objectForKey:key]];
        }
    }
    
    urlStr = [NSString stringWithFormat:@"%@%@%@",HTTP_BASE, urlStr, paramete];
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
    /*
    NSDictionary *dict = [Common jsonStringToDictionary:errorStr];
    
    if (dict)
    {
        return dict[@"details"];
    }
    */
    
    return errorStr;
}

@end
