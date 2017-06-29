//
//  JSONModelCS.m
//  CrazyBox
//
//  Created by 陈全 on 15/12/9.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import "JSONModelCS.h"

@implementation JSONModelCS

+ (id)objectFromJSON:(NSDictionary *)object
{
    return [[self alloc] initWithDictionary:object error:nil];
}
+ (id)objectFromJSONNSArray:(NSArray *)object
{
    return [self arrayOfModelsFromDictionaries:object];
}
+ (id)objectFromJSONString:(NSString *)string {
    return [[self alloc] initWithString:string error:nil];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
