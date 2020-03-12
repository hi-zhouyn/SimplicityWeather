//
//  HumidityCollectionViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/8.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "HumidityCollectionViewCell.h"
#import "YAWaveView.h"

@interface HumidityCollectionViewCell ()
@property (nonatomic, strong) UILabel *numLabel;
@end

@implementation HumidityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.title = @"空气湿度";
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.frame.size.height) {
        [self buildWaterDropView];
    }
}

- (void)buildWaterDropView
{
    _numLabel = [[UILabel alloc] init];
    _numLabel.font = [UIFont systemFontOfSize:13];
    _numLabel.textColor = KColorBlack;
    _numLabel.text = @"71%";
    [self.contentView addSubview:_numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-20);
        make.centerX.equalTo(self.contentView);
    }];
    
    NSArray *colors = @[(__bridge id)[UIColor colorWithRed:134/255.0 green:208/255.0 blue:248/255.0 alpha:0.75].CGColor, (__bridge id)[UIColor whiteColor].CGColor];  //里
    NSArray *sColors = @[(__bridge id)[UIColor colorWithRed:166/255.0 green:240/255.0 blue:255/255.0 alpha:0.5].CGColor, (__bridge id)[UIColor colorWithRed:240/255.0 green:250/255.0 blue:255/255.0 alpha:0.5].CGColor];  //外
    CGFloat width = CGRectGetWidth(self.frame) / 3.5 * 2;
    YAWaveView *waveView = [[YAWaveView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    [self.contentView addSubview:waveView];
    [waveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(width);
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.numLabel.mas_top).offset(-5);
    }];
    waveView.layer.mask = [waveView setWaterDrop];
    waveView.colors = colors;
    waveView.sColors = sColors;
    waveView.percent = 0.6;
    [waveView startWave];
    
}


@end
