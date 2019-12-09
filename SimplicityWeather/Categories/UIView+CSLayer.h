//
//  UIView+CSLayer.h
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CSLayer)

#pragma mark
#pragma mark----------------------- circle or corner radius -----------------------
#pragma mark
/**
 * Set circle.
 */
- (void)setCircle;
- (void)setCircleWithRadius:(CGFloat)radius;
- (void)setCircleWithBezierPath;
- (void)setTopLeftAndTopRightCircleWithBezierPath;
- (UIImage *)setCircleAndImageView;
/**
 * Set waterDrop.
 *
 */
- (CAShapeLayer *)setWaterDrop;

#pragma mark
#pragma mark----------------------- border and background color -----------------------
#pragma mark

/**
 * Set border.
 * gray color
 */
// 添加边框
- (void)setborder;

// 添加边框 自定义边框宽度
- (void)setborderWithBorderWidth:(CGFloat) width;

// 添加边框 自定义边框颜色，宽度
- (void)setborderWithBorderColor:(UIColor *)color Width:(CGFloat) width;

/**
 * Set clear color.
 */
- (void)setClearColor;

#pragma mark
#pragma mark----------------------- shadow -----------------------
#pragma mark
/**
 * Set shadow.
 * default opacity is 0.5f.
 * deault shadowRadius is 5.
 * defaul shadowColor is gray
 *
 */
- (void)setShadow;
/**
 *  Set shadow with opacity.
 * deault shadowRadius is 5.
 * defaul shadowColor is gray
 *
 */
- (void)setShadowWithOpacity:(CGFloat)opacity;

@end
