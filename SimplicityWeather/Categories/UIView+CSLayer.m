//
//  UIView+CSLayer.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "UIView+CSLayer.h"

@implementation UIView (CSLayer)

#pragma mark
#pragma mark----------------------- circle or corner radius -----------------------
#pragma mark
- (void)setCircle {
    [self setCircleWithRadius:self.frame.size.width / 2];
}

- (void)setCircleWithRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}


-(void) setCircleWithBezierPath
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.frame.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setTopLeftAndTopRightCircleWithBezierPath
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:self.frame.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(UIImage *) setCircleAndImageView
{
    //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.width] addClip];
    [self drawRect:self.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
    return image;
}

- (CAShapeLayer *)setWaterDrop
{
    CGFloat ridio = CGRectGetHeight(self.bounds) / 5;
    CGFloat width = CGRectGetWidth(self.bounds);
    if (width < ridio * 4) {
        NSLog(@"view宽度过窄");
        return nil;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), 0)];
    [path addQuadCurveToPoint:CGPointMake(CGRectGetMidX(self.bounds) - ridio * 2, ridio * 3) controlPoint:CGPointMake(CGRectGetMidX(self.bounds) - ridio * 2, ridio * 1.8)];
    [path addArcWithCenter:CGPointMake(CGRectGetMidX(self.bounds), ridio * 3) radius:ridio * 2 startAngle:-M_PI endAngle:0 clockwise:NO];
    [path addQuadCurveToPoint:CGPointMake(CGRectGetMidX(self.bounds), 0) controlPoint:CGPointMake(CGRectGetMidX(self.bounds) + ridio * 2, ridio * 1.8)];
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    return layer;
}


#pragma mark
#pragma mark----------------------- border and background color -----------------------
#pragma mark
- (void)setborder {
    self.layer.borderColor = kColorBg.CGColor;
    self.layer.borderWidth = 1;
}

-(void)setborderWithBorderWidth:(CGFloat)width
{
    self.layer.borderColor = kColorBg.CGColor;
    self.layer.borderWidth = width;
}

-(void)setborderWithBorderColor:(UIColor *)color Width:(CGFloat)width
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width ;
}


- (void)setClearColor {
    [self setBackgroundColor:[UIColor clearColor]];
}

#pragma mark
#pragma mark----------------------- shadow -----------------------
#pragma mark
- (void)setShadow {
    [self setShadowWithOpacity:0.5f];
}

- (void)setShadowWithOpacity:(CGFloat)opacity {
    [self.layer setShadowOpacity:opacity];
    [self.layer setShadowRadius:5];
    [self.layer setShadowOffset:CGSizeZero];
}

@end
