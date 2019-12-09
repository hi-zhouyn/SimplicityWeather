//
//  GDRoundView.m
//  EzraRoundView
//
//  Created by 周亚楠 on 2018/10/12.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "GDRoundView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define KRoundWidth  15


@interface GDRoundView ()
{
    CGFloat _width;
    CGFloat _height;
}
@property (nonatomic, strong) CAShapeLayer *maxRoundLayer;
@property (nonatomic, strong) CAShapeLayer *minRoundLayer;

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@end

@implementation GDRoundView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (CGRectGetHeight(self.frame)) {
        [self drawLayer];
    }
}

- (void)drawLayer
{
    _width = self.frame.size.width;
    _height = self.frame.size.height;
    if (!self.frame.size.width) {
        NSLog(@"宽度为0");
        return;
    }
    
    self.radius = MIN(_width, _height) / 2 - KRoundWidth / 2;
    self.startAngle = M_PI_4 * 3;
    self.endAngle = M_PI_4;
    
    [self drawMaxRoundLayer];
    [self drawMinLayer];
    
    CAGradientLayer *maxColorGradientLayer = [self createColorGradientLayer];
    maxColorGradientLayer.mask = self.progressLayer;
    [self.layer addSublayer:maxColorGradientLayer];
    
//    CAGradientLayer *minColorGradientLayer = [self createColorGradientLayer];
//    minColorGradientLayer.mask = self.minRoundLayer;
//    [self.layer addSublayer:minColorGradientLayer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startPathAnimationWithPercent:0.3];
    });
    
}

- (void)drawMaxRoundLayer
{
    UIBezierPath *maxRoundPath = [UIBezierPath bezierPath];
    [maxRoundPath addArcWithCenter:CGPointMake(_width / 2, _height / 2) radius:self.radius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    
    _maxRoundLayer = [CAShapeLayer layer];
    _maxRoundLayer.frame = self.bounds;
    _maxRoundLayer.path = maxRoundPath.CGPath;
    _maxRoundLayer.lineCap = kCALineCapButt;
    _maxRoundLayer.lineJoin = kCALineJoinRound;
    _maxRoundLayer.lineDashPattern = @[@2,@5];
    _maxRoundLayer.lineWidth = KRoundWidth;
    _maxRoundLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _maxRoundLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_maxRoundLayer];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.path = maxRoundPath.CGPath;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.lineJoin = kCALineJoinRound;
    _progressLayer.lineDashPattern = @[@2,@5];
    _progressLayer.lineWidth = KRoundWidth;
    _progressLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
}

- (void)drawMinLayer
{
    CGFloat radius = self.radius ;
    UIBezierPath *minRoundPath = [UIBezierPath bezierPath];
    [minRoundPath addArcWithCenter:CGPointMake(_width / 2, _height / 2) radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    
    _minRoundLayer = [CAShapeLayer layer];
    _minRoundLayer.frame = self.bounds;
    _minRoundLayer.path = minRoundPath.CGPath;
    _minRoundLayer.lineCap = kCALineCapButt;
    _minRoundLayer.lineJoin = kCALineJoinRound;
//    _minRoundLayer.lineDashPattern = @[@2,@5];
    _minRoundLayer.lineWidth = 0.8;
    _minRoundLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _minRoundLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_minRoundLayer];
}

- (CAGradientLayer *)createColorGradientLayer
{
    CAGradientLayer *colorGradientLayer = [CAGradientLayer layer];
    colorGradientLayer.frame = self.maxRoundLayer.frame;
    
    
    CAGradientLayer *topLayer = [CAGradientLayer layer];
    topLayer.frame = CGRectMake(0, 0, _width, _height / 2);
    topLayer.colors = @[(__bridge id)kColorYellow.CGColor,
                        (__bridge id)kColorOrange.CGColor,
                        (__bridge id)kColorRed.CGColor,
                        (__bridge id)kColorPurple.CGColor];
    topLayer.startPoint = CGPointMake(0, 0);
    topLayer.endPoint = CGPointMake(1, 0);
    
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, _width / 2, _width / 2, _height / 2);
    leftLayer.colors = @[(__bridge id)kColorYellow.CGColor,
                         (__bridge id)kColorGreen.CGColor];
    leftLayer.startPoint = CGPointMake(0, 0);
    leftLayer.endPoint = CGPointMake(0, 1);
    
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(_width / 2, _height / 2, _width / 2, _height / 2);
    rightLayer.colors = @[(__bridge id)kColorPurple.CGColor,
                          (__bridge id)kColorDeepPurple.CGColor];
    rightLayer.startPoint = CGPointMake(0, 0);
    rightLayer.endPoint = CGPointMake(0, 1);
    
    [colorGradientLayer addSublayer:topLayer];
    [colorGradientLayer addSublayer:leftLayer];
    [colorGradientLayer addSublayer:rightLayer];
    [topLayer setLocations:@[@0.1,@0.5,@0.85,@1]];
    //    [leftLayer setLocations:@[@0.05,@0.35]];
    //    [rightLayer setLocations:@[@0.2,@0.75]];
    
//    [colorGradientLayer setMask:self.progressLayer];
//    [self.layer addSublayer:colorGradientLayer];
    [self.progressLayer setStrokeEnd:0];
    return colorGradientLayer;
}

-(void)startPathAnimationWithPercent:(CGFloat)percent
{
    CABasicAnimation *maxPathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    maxPathAnimation.duration = 2;
    maxPathAnimation.repeatCount = 1;
    maxPathAnimation.removedOnCompletion = NO;
    maxPathAnimation.fillMode = kCAFillModeForwards;
    maxPathAnimation.fromValue = @0.f;
    maxPathAnimation.toValue = [NSNumber numberWithFloat:percent];
    // 动画缓慢的进入，中间加速，然后减速到达目的地。
    //    maxPathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.progressLayer addAnimation:maxPathAnimation forKey:@""];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
