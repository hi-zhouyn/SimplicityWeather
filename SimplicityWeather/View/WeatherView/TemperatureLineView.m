//
//  TemperatureLineView.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/30.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "TemperatureLineView.h"
#import "UIBezierPath+LxThroughPointsBezier.h"

@interface TemperatureLineView ()
@property (nonatomic, strong) NSMutableArray *maxArr;
@property (nonatomic, strong) NSMutableArray *minArr;
@property (nonatomic, assign) NSInteger maxNum;
@end

@implementation TemperatureLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor lightGrayColor];
        [self maxArr];
        [self minArr];
        [self drawLineLayer];
    }
    return self;
}

- (void)drawLineLayer
{
    CGFloat startx = 0;
    NSMutableArray *maxPointsArr = [NSMutableArray array];
    NSMutableArray *minPointsArr = [NSMutableArray array];
    CGFloat ratio = (self.frame.size.height - 5) / self.maxNum;
    
    for (int i = 0; i < self.maxArr.count; i ++) {
        NSNumber *tempNum = self.maxArr[i];
        CGFloat y = self.frame.size.height - tempNum.integerValue * ratio;
        if (!i) {
            NSValue *value = [NSValue valueWithCGPoint:CGPointMake(startx, y)];
            [maxPointsArr addObject:value];
        }
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake(KWidth / 2 + KWidth * i, y)];
        [maxPointsArr addObject:value];
        if (i == self.maxArr.count - 1) {
            NSValue *value = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, y)];
            [maxPointsArr addObject:value];
        }
    }
    
    for (int i = 0; i < self.minArr.count; i ++) {
        NSNumber *tempNum = self.minArr[i];
        CGFloat y = self.frame.size.height - tempNum.integerValue * ratio / 1.1;
        if (!i) {
            NSValue *value = [NSValue valueWithCGPoint:CGPointMake(startx, y)];
            [minPointsArr addObject:value];
        }
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake(KWidth / 2 + KWidth * i, y)];
        [minPointsArr addObject:value];
        if (i == self.maxArr.count - 1) {
            NSValue *value = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, y)];
            [minPointsArr addObject:value];
        }
    }
    
    
    CGPoint startPoint = [[maxPointsArr firstObject] CGPointValue];
    CGPoint endPoint = [[maxPointsArr lastObject] CGPointValue];
    UIBezierPath *maxPath = [UIBezierPath bezierPath];
    [maxPath moveToPoint:startPoint];
    [maxPath addBezierThroughPoints:maxPointsArr];
    
    CAShapeLayer *maxLineLayer = [CAShapeLayer layer];
    maxLineLayer.path = maxPath.CGPath;
    maxLineLayer.strokeColor = [UIColor whiteColor].CGColor;
    maxLineLayer.fillColor = KColorClear.CGColor;
    maxLineLayer.lineWidth = 1.5;
    maxLineLayer.lineCap = kCALineCapRound;
    maxLineLayer.lineJoin = kCALineJoinRound;
    maxLineLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:maxLineLayer];
    
    UIBezierPath *colorPath = [UIBezierPath bezierPath];
    colorPath.lineWidth = 1.f;
    [colorPath moveToPoint:startPoint];
    [colorPath addBezierThroughPoints:maxPointsArr];
    [colorPath addLineToPoint:CGPointMake(endPoint.x, self.frame.size.height)];
    [colorPath addLineToPoint:CGPointMake(startx, self.frame.size.height)];
    [colorPath addLineToPoint:CGPointMake(startx, startPoint.y)];
    
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.path = colorPath.CGPath;
    bgLayer.frame = self.frame;
    
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.frame = bgLayer.frame;
    colorLayer.mask = bgLayer;
    colorLayer.startPoint = CGPointMake(0, 0);
    colorLayer.endPoint = CGPointMake(0, 1);
    colorLayer.colors = [NSArray arrayWithObjects:(id)[[KColorBlue colorWithAlphaComponent:1] CGColor],(id)[[KColorBlue colorWithAlphaComponent:0.07] CGColor], nil];
    [self.layer addSublayer:colorLayer];
    
    
    UIBezierPath *minPath = [UIBezierPath bezierPath];
    [minPath moveToPoint:[[minPointsArr firstObject] CGPointValue]];
    [minPath addBezierThroughPoints:minPointsArr];
    
    CAShapeLayer *minLineLayer = [CAShapeLayer layer];
    minLineLayer.path = minPath.CGPath;
    minLineLayer.lineWidth = 1.5f;
    minLineLayer.strokeColor = [UIColor whiteColor].CGColor;
    minLineLayer.fillColor = KColorClear.CGColor;
    minLineLayer.lineCap = kCALineCapRound;
    minLineLayer.lineJoin = kCALineJoinRound;
    minLineLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:minLineLayer];
    
    
    CABasicAnimation *maxPathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    maxPathAnimation.duration = 12;
    maxPathAnimation.repeatCount = 1;
    maxPathAnimation.removedOnCompletion = YES;
    maxPathAnimation.fromValue = @0.f;
    maxPathAnimation.toValue = @1;
    [maxLineLayer addAnimation:maxPathAnimation forKey:@"strokeEnd"];
    
    [self buildDotWithMaxPointsArr:maxPointsArr minPointsArr:minPointsArr];
}

- (void)buildDotWithMaxPointsArr:(NSMutableArray *)maxPointsArr minPointsArr:(NSMutableArray *)minPointsArr
{
    for (int i = 0; i < maxPointsArr.count; i ++) {
        if (!i || i == maxPointsArr.count - 1) {
            continue;
        }
        NSValue *point = maxPointsArr[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.image = ImageNamed(@"select");
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(8);
            make.left.mas_equalTo(point.CGPointValue.x - 4);
            make.top.mas_equalTo(point.CGPointValue.y - 4);
        }];
    }
    
    for (int i = 0; i < minPointsArr.count; i ++) {
        if (!i || i == minPointsArr.count - 1) {
            continue;
        }
        NSValue *point = minPointsArr[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.image = ImageNamed(@"select");
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(8);
            make.left.mas_equalTo(point.CGPointValue.x - 4);
            make.top.mas_equalTo(point.CGPointValue.y - 4);
        }];
    }
}


- (NSMutableArray *)maxArr
{
    if (!_maxArr) {
        _maxArr = [NSMutableArray array];
        for (int i = 0; i < 14; i ++) {
            NSInteger temp = (arc4random() % 12) + 18;
            self.maxNum = temp > self.maxNum?temp:self.maxNum;
            [_maxArr addObject:[NSNumber numberWithInteger:temp]];
        }
    }
    return _maxArr;
}

- (NSMutableArray *)minArr
{
    if (!_minArr) {
        _minArr = [NSMutableArray array];
        for (int i = 0; i < self.maxArr.count; i ++) {
            NSNumber *tempNum = self.maxArr[i];
            NSNumber *minTemp = [NSNumber numberWithInteger:tempNum.integerValue - (arc4random() % 10)];
            [_minArr addObject:minTemp];
        }
    }
    return _minArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
