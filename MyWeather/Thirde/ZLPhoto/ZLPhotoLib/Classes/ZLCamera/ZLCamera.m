//
//  ZLCamera.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 15-1-23.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "ZLCamera.h"

@implementation ZLCamera

- (UIImage *)photoImage{
    return [UIImage imageWithContentsOfFile:self.imagePath];
}
- (UIImage *)originImage{
    return [UIImage imageWithContentsOfFile:self.imagePath];
}
-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
