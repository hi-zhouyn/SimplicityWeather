//
//  CityNameCollectionViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/17.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "CityNameCollectionViewCell.h"

@interface CityNameCollectionViewCell ()
@property (nonatomic, strong) UILabel *cityNameLabel;
@end

@implementation CityNameCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KColorWhite;
        self.cityNameLabel.text = @"重庆";
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.cityNameLabel.text = title;
}

- (UILabel *)cityNameLabel
{
    if (!_cityNameLabel) {
        _cityNameLabel = [[UILabel alloc] init];
        _cityNameLabel.font = [UIFont systemFontOfSize:15];
        _cityNameLabel.textColor = kColorTextGray;
        [self.contentView addSubview:_cityNameLabel];
        [_cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return _cityNameLabel;
}

@end
