//
//  HomeLoadView.h
//  MyWeather
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "BaseViewFromXib.h"
#import "BaseButton.h"
@interface HomeLoadView : BaseViewFromXib
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
//@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowWeatherTMPLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowWeatherAirLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowWeatherWindLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *isOLabel;
@property (nonatomic,strong) BaseButton *testButton;
-(void) updateUI:(NowModel *)nowModel CityName:(NSString *)cityName Time : (NSString *) time Aqi:(AqiModel *)aqiModel Daily:(DailyForecastModel *) dailyModel;
@end
