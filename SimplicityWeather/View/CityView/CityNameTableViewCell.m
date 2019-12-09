//
//  CityNameTableViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/17.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "CityNameTableViewCell.h"

@interface CityNameTableViewCell ()
@property (nonatomic, strong) UILabel *cityNameLabel;
@end

@implementation CityNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
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
        _cityNameLabel.textColor = kColorMain;
        [self.contentView addSubview:_cityNameLabel];
        [_cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
        }];
    }
    return _cityNameLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
