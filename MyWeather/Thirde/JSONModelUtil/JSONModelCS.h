//
//  JSONModelCS.h
//  CrazyBox
//
//  Created by 陈全 on 15/12/9.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JSONModelCS : JSONModel

+ (id)objectFromJSON:(NSDictionary *)object;

+ (id)objectFromJSONString:(NSString *)string;

+ (id) objectFromJSONNSArray:(NSArray *)object;

+ (BOOL)propertyIsOptional:(NSString*)propertyName;

@end
