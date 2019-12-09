//
//  UIImage+Common.h
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)

- (NSString *)saveImageToTmpWithCompressLevel:(CGFloat)compressionQuality;

- (NSString *)saveImageToTmpWithSize:(CGFloat)maxFileSize;

+ (UIImage *)imageWithUIView:(UIView*)view;

+ (UIImage *)imageWithColor:(UIColor*)color;

- (UIImage *)roundedRectWithSize:(CGSize)size radius:(CGFloat)r;

- (UIImage *)transformtoSize:(CGSize)newSize;

+(UIImage*)imageWithBase64String:(NSString*)base64String;

-(NSString*)toBase64String;

@end

