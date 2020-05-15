//
//  NowWeatherHeadView.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "NowWeatherHeadView.h"
@interface NowWeatherHeadView ()

@property (weak, nonatomic) IBOutlet UILabel *citeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempScopeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowWeatherLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bottomSunImageView;
@property (strong, nonatomic) IBOutlet UIImageView *sunshineImageView;

@property (nonatomic, strong) CAEmitterCell *cloudCell;
@end

@implementation NowWeatherHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self createEmitter];
    [self createShark];
}

- (void)createShark
{
    //关键帧动画
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    shakeAnimation.values = @[[NSNumber numberWithFloat:M_PI / 180 * -22.5],
                              [NSNumber numberWithFloat:M_PI / 180 * 60],
                              [NSNumber numberWithFloat:M_PI / 180 * -22.5]];
    
    CAKeyframeAnimation *ampAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    ampAnimation.values = @[[NSNumber numberWithFloat:1.f],
                            [NSNumber numberWithFloat:1.2f],
                            [NSNumber numberWithFloat:1.f]];
    
    //动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[shakeAnimation,ampAnimation];
    group.duration = 30;
    group.repeatCount = FLT_MAX;
    group.removedOnCompletion = NO;
    group.autoreverses = NO;
    
    [self.sunshineImageView.layer addAnimation:group forKey:nil];
}

- (void)createEmitter
{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    //粒子单元
    emitterLayer.emitterCells = @[self.cloudCell];
    emitterLayer.position = CGPointMake(-80, 20);
    //发射器的尺寸
    emitterLayer.emitterSize = CGSizeMake(80, 50);
    //发射模式：顶点、轮廓、 表面、 容积(the default)
    emitterLayer.emitterMode = kCAEmitterLayerOldestFirst;
    //发射源的形状：点(the default)、直线、矩形、立方体、圆形形、3D球
    emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    //渲染模式, 默认kCAEmitterLayerUnordered
    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    //发射位置
    emitterLayer.emitterPosition = CGPointMake(-20, emitterLayer.frame.size.height/4);
    //发射源的中心位置，默认(0,0,0)//决定了粒子发射形状的中心点
    emitterLayer.emitterZPosition = 0;
    [self.layer addSublayer:emitterLayer];
}

- (CAEmitterCell *)cloudCell
{
    if (!_cloudCell) {
        _cloudCell = [CAEmitterCell emitterCell];
        _cloudCell.contents = (id)[UIImage imageNamed:@"whitecloud"].CGImage;
        //粒子的产生率
        _cloudCell.birthRate = 0.08;
        //粒子的生命周期，以秒为单位
        _cloudCell.lifetime = 80;
        //速度，默认0
        _cloudCell.velocity = 15;
        //速度范围，默认0
        _cloudCell.velocityRange = 5;

        //缩放比例,缩放比例范围,缩放速度,缩放比例和缩放范围默认是0
        _cloudCell.scale = 0.5;
        _cloudCell.scaleRange = 0.5;
        _cloudCell.scaleSpeed = 0.05;

        //粒子透明度alpha能改变的范围,默认0
        _cloudCell.alphaRange = 0.5;
        //粒子透明度alpha在生命周期内的改变速度,默认0
//        _cloudCell.alphaSpeed = 0.05;
    }
    return _cloudCell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
