//
//  UIView+CSLayer.h
//  JuCaiBang
//
//  Created by 21Lovetong on 15/9/22.
//
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

/**
 * Set blue buttons corner radius.
 *defaul backgroundColor is kColorBlue.
 *
 */
//- (void)setBlueButtonCornerRadius;

#pragma mark
#pragma mark----------------------- border and background color -----------------------
#pragma mark
/**
 * Set border.
 * gray color
 */
- (void)setborder;

/**
 * Set blue border.
 * default backgroundColor is kColorBg
 */
- (void)setBlueBorder;

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
 *  @param opacity
 */
- (void)setShadowWithOpacity:(CGFloat)opacity;

@end
