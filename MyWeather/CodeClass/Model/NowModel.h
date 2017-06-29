//
//  NowModel.h
//  MyWeather
//
//  Created by admin on 16/8/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "BaseModel.h"

@interface NowModel : BaseModel

@property (nonatomic,strong) NSString *txt;//天气状况描述
@property (nonatomic,strong) NSString *fl;//体感温度
@property (nonatomic,strong) NSString *hum;//相对湿度（%）
@property (nonatomic,strong) NSString *dir;//风向
@property (nonatomic,strong) NSString *sc;//风力
@property (nonatomic,strong) NSString *tmp;//温度

@end
