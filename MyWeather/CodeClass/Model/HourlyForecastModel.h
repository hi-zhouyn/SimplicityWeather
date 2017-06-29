//
//  HourlyForecastModel.h
//  MyWeather
//
//  Created by admin on 16/8/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "BaseModel.h"

@interface HourlyForecastModel : BaseModel
@property (nonatomic,strong) NSString *date;//时间
@property (nonatomic,strong) NSString *tmp;//温度
@property (nonatomic,strong) NSString *dir;//风向
@property (nonatomic,strong) NSString *sc;//风力
@property (nonatomic,strong) NSString *pop;//风力
@end
