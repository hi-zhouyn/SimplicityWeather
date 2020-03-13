//
//  CityFirstTextHeaderView.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/18.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "CityFirstTextHeaderView.h"

@interface CityFirstTextHeaderView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation CityFirstTextHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setViewMode:(CityFirstTextHeaderViewMode)viewMode
{
    _viewMode = viewMode;
    if (viewMode == CityFirstTextHeaderViewModeWhite) {
        self.titleLabel.textColor = KColorBlack;
        self.contentView.backgroundColor = KColorWhite;
    }else if (viewMode == CityFirstTextHeaderViewModeGray){
        self.titleLabel.textColor = KColorBlack;
        self.contentView.backgroundColor = kColorLine;
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
