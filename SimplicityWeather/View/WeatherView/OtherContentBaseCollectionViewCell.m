//
//  OtherContentBaseCollectionViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/8.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "OtherContentBaseCollectionViewCell.h"

@interface OtherContentBaseCollectionViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation OtherContentBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView setborderWithBorderColor:kColorBg Width:0.3];
    }
    return self;
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
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(14);
            make.left.equalTo(self.contentView).offset(15);
        }];
    }
    return _titleLabel;
}

@end
