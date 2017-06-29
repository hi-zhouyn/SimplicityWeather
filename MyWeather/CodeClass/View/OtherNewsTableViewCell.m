//
//  OtherNewsTableViewCell.m
//  MyWeather
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "OtherNewsTableViewCell.h"

@implementation OtherNewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self autoLayoutAllSubViewsWithoutFont];
    
}
-(void)updateUI:(NowModel *)nowModel Daily:(DailyForecastModel *)dailyModel
{
    self.windLabel.text = nowModel.dir;
    self.windForceLabel.text = nowModel.sc;
    self.sunriseLabel.text = dailyModel.sr;
    self.sunsetLabel.text = dailyModel.ss;
    self.humidityLabel.text = nowModel.hum;
    self.tempLabel.text = nowModel.fl;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
