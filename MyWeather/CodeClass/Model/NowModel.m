//
//  NowModel.m
//  MyWeather
//
//  Created by admin on 16/8/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "NowModel.h"

@implementation NowModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"cond"]) {
        self.txt = value[@"txt"];
        
    }
    if ([key isEqualToString:@"wind"])
    {
        self.dir = value[@"dir"];
        self.sc = value[@"sc"];
    }
}
@end
