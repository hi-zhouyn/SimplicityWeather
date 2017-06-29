//
//  DailyForecastModel.m
//  MyWeather
//
//  Created by admin on 16/8/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "DailyForecastModel.h"

@implementation DailyForecastModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"astro"]) {
        _sr = value[@"sr"];
        _ss = value[@"ss"];
    }
    if ([key isEqualToString:@"cond"])
    {
        _txt_d = value[@"txt_d"];
        _txt_n = value[@"txt_n"];
    }
    if ([key isEqualToString:@"tmp"])
    {
        _max = value[@"max"];
        _min = value[@"min"];
    }
    if ([key isEqualToString:@"wind"])
    {
        _spd = value[@"spd"];
        _sc = value[@"sc"];
    }
    
}
@end
