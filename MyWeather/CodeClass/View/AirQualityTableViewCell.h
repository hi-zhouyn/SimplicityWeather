//
//  AirQualityTableViewCell.h
//  MyWeather
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KAirQualityTableViewCellID @"AirQualityTableViewCell"
#define KAirQualityTableViewCellHeight 110 * kAUTOLAYOUTSCALE
@interface AirQualityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *qltyLabel;
@property (weak, nonatomic) IBOutlet UILabel *aqiLabel;
@property (weak, nonatomic) IBOutlet UILabel *pm25Label;
@property (weak, nonatomic) IBOutlet UILabel *pm10Label;
@property (weak, nonatomic) IBOutlet UILabel *pm25NumLabel;
@property (weak, nonatomic) IBOutlet UILabel *pm10NumLabel;
@property (weak, nonatomic) IBOutlet UIView *pm25BGView;
@property (weak, nonatomic) IBOutlet UIView *pm10BGView;
@property (weak, nonatomic) IBOutlet UIView *pm25SliderView;
@property (weak, nonatomic) IBOutlet UIView *pm10SliderLabel;

-(void) updateUI:(AqiModel *) model;
@end
