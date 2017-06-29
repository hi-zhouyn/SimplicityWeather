//
//  DailyForecastModel.h
//  MyWeather
//
//  Created by admin on 16/8/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "BaseModel.h"

@interface DailyForecastModel : BaseModel
@property (nonatomic,strong) NSString *date;//预报日期
@property (nonatomic,strong) NSString *sr;//日出时间
@property (nonatomic,strong) NSString *ss; //日落时间
@property (nonatomic,strong) NSString *txt_d;//白天天气状况描述
@property (nonatomic,strong) NSString *txt_n;//夜间天气状况描述
@property (nonatomic,strong) NSString *max;//最高温度
@property (nonatomic,strong) NSString *min;//最低温度
@property (nonatomic,strong) NSString *spd;//风向
@property (nonatomic,strong) NSString *sc;//风力

@end
