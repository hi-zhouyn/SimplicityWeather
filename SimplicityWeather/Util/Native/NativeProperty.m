//
//  PropertyHelper.m
//  Xiaojs-XMI
//
//  Created by 王强 on 2016/10/28.
//  Copyright © 2016年 xiaojs. All rights reserved.
//

#import "NativeProperty.h"

static NSString *Area_File_Name = @"ChinaArea";

@implementation NativeProperty


//------------------------------------------------------------------------------------------------------------------------------
//城市列表
+(NSDictionary *)areaMap;
{
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *path = [bundle pathForResource:Area_File_Name ofType:@"plist"];
    
    return [NSDictionary dictionaryWithContentsOfFile:path];
}


+(NSArray *)cqAreas
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:Area_File_Name ofType:@"plist"];
    
    NSDictionary *areaMap = [NSDictionary dictionaryWithContentsOfFile:path];
    return areaMap[@"3"][@"重庆市"][@"0"][@"重庆市"];
}
//------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------------------------------------------------
//错误信息列表
+(NSDictionary *)getErrorInfo
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"ErrorInfo" ofType:@"plist"];
    
    NSDictionary *errorInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    return errorInfo;
}

//------------------------------------------------------------------------------------------------------------------------------

@end
