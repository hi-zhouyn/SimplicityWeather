//
//  PropertyHelper.h
//  Xiaojs-XMI
//
//  Created by 王强 on 2016/10/28.
//  Copyright © 2016年 xiaojs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NativeProperty : NSObject


+(NSDictionary *)areaMap;
+(NSArray *)cqAreas;

/**
 错误信息列表
 */
+(NSDictionary *)getErrorInfo;


@end
