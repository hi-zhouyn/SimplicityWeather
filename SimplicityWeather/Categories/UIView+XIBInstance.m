//
//  UIView+XIBInstance.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "UIView+XIBInstance.h"

@implementation UIView (XIBInstance)

+ (instancetype)instanceView {
    
    NSArray * nibView = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithUTF8String:object_getClassName([self class])] owner:nil options:nil];
    return [nibView firstObject];
}

@end
