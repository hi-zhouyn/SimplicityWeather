//
//  BaseViewController.h
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, assign) BOOL isModal; //判断是否为模态

//通过图片自定义BarButtonItem
- (UIBarButtonItem *)getBarButtonItemWithImage:(UIImage *)image action:(SEL)action;
@end
