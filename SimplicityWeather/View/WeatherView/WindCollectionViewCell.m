//
//  WindCollectionViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/8.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "WindCollectionViewCell.h"

#define KBladeWidth   CGRectGetWidth(self.frame) / 2.5

@interface WindCollectionViewCell ()
//@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bladeView;
@property (nonatomic, strong) UIImageView *poleImageView;
@property (nonatomic, strong) UILabel *windSpeedLabel;
@property (nonatomic, strong) CADisplayLink *windDisplaylink;
@end

@implementation WindCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.title = @"风速";
        [self poleImageView];
        [self buildBladeView];
        self.windSpeedLabel.text = @"2.00M/s";
        
        _windDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotateAction)];
        [_windDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)buildBladeView
{
    _bladeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KBladeWidth, KBladeWidth)];
//    _bladeView.backgroundColor = KColorClear;
    [self.contentView addSubview:_bladeView];
    [_bladeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(KBladeWidth);
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.poleImageView.mas_top).offset(5);
    }];
    for (int i = 0; i < 3; i ++) {
        UIView *bladeSubView = [self createBladeSubView];
        [_bladeView addSubview:bladeSubView];
        [bladeSubView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bladeView);
        }];
        bladeSubView.transform = CGAffineTransformRotate(bladeSubView.transform, DegreesToRadian(120 * i));
    }
}

- (UIView *)createBladeSubView
{
    UIView *bladeSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KBladeWidth, KBladeWidth)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KBladeWidth, KBladeWidth / 2 - 7)];
    imageView.image = ImageNamed(@"flabellumone");
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [bladeSubView addSubview:imageView];
    return bladeSubView;
}

//开始旋转（帧动画方式）
- (void)rotateAction
{
    //后期旋转速度根据角度大小来控制
    _bladeView.transform = CGAffineTransformRotate(_bladeView.transform, M_PI/50);
}


- (UIImageView *)poleImageView
{
    if (!_poleImageView) {
        _poleImageView = [[UIImageView alloc] init];
        _poleImageView.image = ImageNamed(@"pole");
        _poleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_poleImageView];
        [_poleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(KBladeWidth);
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.windSpeedLabel.mas_top).offset(-10);
        }];
    }
    return _poleImageView;
}


- (UILabel *)windSpeedLabel
{
    if (!_windSpeedLabel) {
        _windSpeedLabel = [[UILabel alloc] init];
        _windSpeedLabel.font = [UIFont systemFontOfSize:13];
        _windSpeedLabel.textColor = KColorBlack;
        [self.contentView addSubview:_windSpeedLabel];
        [_windSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.poleImageView.mas_centerX);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
    }
    return _windSpeedLabel;
}

@end
