//
//  SunCollectionViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/8.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "SunCollectionViewCell.h"

@interface SunCollectionViewCell ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *riseImageView;
@property (nonatomic, strong) UIImageView *setImageView;
@property (nonatomic, strong) UILabel *riseLabel;
@property (nonatomic, strong) UILabel *setLabel;
@end

@implementation SunCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.title = @"日出/日落";
        [self buildView];
        [self layoutIfNeeded];
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.lineView.frame.size.width) {
        [self drawArcLayer];
    }
}

- (void)drawArcLayer
{
    CGFloat radius = (self.setLabel.center.x - self.riseLabel.center.x ) / 2;
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:self.lineView.center radius:radius startAngle:M_PI endAngle:2 * M_PI clockwise:YES];
    arcPath.lineCapStyle = kCGLineCapRound;
    arcPath.lineJoinStyle = kCGLineJoinRound;
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    arcLayer.lineWidth = 0.5f;
    arcLayer.path = arcPath.CGPath;
    arcLayer.strokeColor = [UIColor grayColor].CGColor;
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.lineCap = @"square";
    arcLayer.lineDashPattern = @[@3,@2];
    [self.contentView.layer addSublayer:arcLayer];
    
    
    UIBezierPath *colorPath = [UIBezierPath bezierPathWithArcCenter:self.lineView.center radius:radius startAngle:M_PI endAngle:1.5 * M_PI clockwise:YES];
    CGFloat endX = self.lineView.center.x;
    [colorPath addLineToPoint:CGPointMake(endX, self.lineView.frame.origin.y)];
    [colorPath addLineToPoint:CGPointMake(self.riseLabel.center.x, self.lineView.frame.origin.y)];
    
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.path = colorPath.CGPath;
    bgLayer.frame = self.contentView.frame;
    
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.frame = bgLayer.frame;
    colorLayer.mask = bgLayer;
    colorLayer.startPoint = CGPointMake(0, 0);
    colorLayer.endPoint = CGPointMake(0, 1);
    colorLayer.colors = [NSArray arrayWithObjects:(id)[[[UIColor redColor] colorWithAlphaComponent:0.5] CGColor],(id)[[[UIColor yellowColor] colorWithAlphaComponent:0.5] CGColor], nil];
    [self.contentView.layer addSublayer:colorLayer];
}

- (void)buildView
{
    _riseLabel = [[UILabel alloc] init];
    _riseLabel.font = [UIFont systemFontOfSize:13];
    _riseLabel.textColor = KColorBlack;
    _riseLabel.text = @"06:51";
    [self.contentView addSubview:_riseLabel];
    [_riseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    
    _riseImageView = [[UIImageView alloc] init];
    _riseImageView.image = ImageNamed(@"daytime");
    _riseImageView.tintColor = [UIColor orangeColor];
    [self.contentView addSubview:_riseImageView];
    [_riseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.riseLabel);
        make.bottom.equalTo(self.riseLabel.mas_top);
        make.width.height.mas_equalTo(20);
    }];
    
    _setLabel = [[UILabel alloc] init];
    _setLabel.font = [UIFont systemFontOfSize:13];
    _setLabel.textColor = KColorBlack;
    _setLabel.text = @"18:31";
    [self.contentView addSubview:_setLabel];
    [_setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.riseLabel);
    }];
    
    _setImageView = [[UIImageView alloc] init];
    _setImageView.image = ImageNamed(@"night");
    [self.contentView addSubview:_setImageView];
    [_setImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.setLabel);
        make.centerY.equalTo(self.riseImageView);
        make.width.height.mas_equalTo(16);
    }];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.riseLabel);
        make.right.equalTo(self.setLabel.mas_right);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.riseImageView.mas_top).offset(-5);
    }];
}


@end
