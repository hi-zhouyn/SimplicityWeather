//
//  NowWeatherCollectionViewCell.m
//  MyWeather
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "NowWeatherCollectionViewCell.h"

@implementation NowWeatherCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self autoLayoutAllSubViewsWithoutFont];
}
-(void)updateUI:(NSMutableArray *)Arr Index:(NSInteger)index
{
    HourlyForecastModel *model = Arr[index];
//    NSLog(@"%@time：%@",model.date,[NSString stringWithFormat:@"%@",[model.date substringWithRange:NSMakeRange(11, 5)]]);
    self.timeLabel.text = [NSString stringWithFormat:@"%@时",[model.date substringWithRange:NSMakeRange(11, 2)]];
    self.popLabel.text = [NSString stringWithFormat:@"%@%%",model.pop];
    self.tmpLabel.text = [NSString stringWithFormat:@"%@℃",model.tmp];
}
@end
