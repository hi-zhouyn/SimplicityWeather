//
//  AirCollectionViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/8.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "AirCollectionViewCell.h"
#import "GDRoundView.h"

@interface AirCollectionViewCell ()
@property (nonatomic, strong) GDRoundView *roundView;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *describeLabel;
@end

@implementation AirCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.title = @"空气指数";
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.frame.size.height) {
        [self buildView];
    }
}

- (void)buildView
{
//    [self roundView];
    self.numLabel.text = @"50";
    self.describeLabel.text = @"优";
}

- (GDRoundView *)roundView
{
    if (!_roundView) {
        CGFloat width = CGRectGetWidth(self.frame) / 3.3 * 2;
        _roundView = [[GDRoundView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_roundView];
        [_roundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(width);
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
    }
    return _roundView;
}

- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.font = [UIFont systemFontOfSize:15];
        _numLabel.textColor = KColorBlack;
        [self.contentView addSubview:_numLabel];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.roundView.mas_centerY).offset(25);
            make.centerX.equalTo(self.roundView);
        }];
    }
    return _numLabel;
}

- (UILabel *)describeLabel
{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.font = [UIFont systemFontOfSize:12];
        _describeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_describeLabel];
        [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.numLabel);
            make.top.equalTo(self.numLabel.mas_bottom).offset(4);
        }];
    }
    return _describeLabel;
}

@end
