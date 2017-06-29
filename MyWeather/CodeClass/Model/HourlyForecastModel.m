//
//  HourlyForecastModel.m
//  MyWeather
//
//  Created by admin on 16/8/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "HourlyForecastModel.h"

@implementation HourlyForecastModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"wind"])
    {
        _dir = value[@"dir"];
        _sc = value[@"sc"];
    }
}
@end
