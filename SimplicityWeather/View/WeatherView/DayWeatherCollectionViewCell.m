//
//  DayWeatherCollectionViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "DayWeatherCollectionViewCell.h"

@interface DayWeatherCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *tempMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMinLabel;

@end

@implementation DayWeatherCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = KColorClear;
    
    
}

@end
