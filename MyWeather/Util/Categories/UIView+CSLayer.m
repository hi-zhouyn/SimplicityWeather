//
//  UIView+CSLayer.m
//  JuCaiBang
//
//  Created by 21Lovetong on 15/9/22.
//
//

#import "UIView+CSLayer.h"

@implementation UIView (CSLayer)

#pragma mark
#pragma mark----------------------- circle or corner radius -----------------------
#pragma mark
- (void)setCircle {
    [self setCircleWithRadius:self.width / 2];
}

- (void)setCircleWithRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}



#pragma mark
#pragma mark----------------------- border and background color -----------------------
#pragma mark
- (void)setborder {
//    self.layer.borderColor = kColorSpert1.CGColor;
    self.layer.borderWidth = 1;
}

- (void)setBlueBorder {
//    [self setBackgroundColor:kColorBg];
//    [self.layer setBorderColor:kColorBlue.CGColor];
    [self.layer setBorderWidth:1.0f];
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
//    [self.layer setShadowColor:kColorTitle3.CGColor];
    [self.layer setShadowOpacity:opacity];
    [self.layer setShadowRadius:5];
    [self.layer setShadowOffset:CGSizeZero];
}

@end
