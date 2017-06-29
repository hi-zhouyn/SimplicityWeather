//
//  AqiModel.h
//  MyWeather
//
//  Created by admin on 16/8/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "BaseModel.h"

@interface AqiModel : BaseModel

@property (nonatomic,strong) NSString *aqi;//空气质量指数
@property (nonatomic,strong) NSString *pm10;//PM10 1小时平均值(ug/m³)
@property (nonatomic,strong) NSString *pm25;//PM2.5 1小时平均值(ug/m³)
@property (nonatomic,strong) NSString *qlty;//空气质量类别

@end
