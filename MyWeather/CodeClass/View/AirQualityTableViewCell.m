//
//  AirQualityTableViewCell.m
//  MyWeather
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "AirQualityTableViewCell.h"

@implementation AirQualityTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self autoLayoutAllSubViewsWithoutFont];
    
    [self.pm10SliderLabel setCircleWithRadius:2 * kAUTOLAYOUTSCALE];
    [self.pm25SliderView setCircleWithRadius:2 * kAUTOLAYOUTSCALE];
    [self.pm25BGView setCircleWithRadius:2 * kAUTOLAYOUTSCALE];
    [self.pm10BGView setCircleWithRadius:2 * kAUTOLAYOUTSCALE];
    
    
}
-(void)updateUI:(AqiModel *)model
{
    self.qltyLabel.text = [NSString stringWithFormat:@"空气质量\n%@",model.qlty];
    self.aqiLabel.text = model.aqi;
    self.pm25NumLabel.text = model.pm25;
    self.pm10NumLabel.text = model.pm10;
    [UIView animateWithDuration:0.3 animations:^{
         self.pm25SliderView.size = CGSizeMake([model.pm25 intValue] * 240 * kAUTOLAYOUTSCALE / 500 , 4 * kAUTOLAYOUTSCALE);
         self.pm10SliderLabel.size = CGSizeMake([model.pm10 intValue] * 240 * kAUTOLAYOUTSCALE / 500 , 4 * kAUTOLAYOUTSCALE);
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
