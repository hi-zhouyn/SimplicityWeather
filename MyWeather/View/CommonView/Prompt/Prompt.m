//
  
//  Prompt.m
//  Fortune
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import "Prompt.h"
@interface Prompt()
@end
@implementation Prompt

+ (void)promptWithMemessage:(NSString *)msg {
    Prompt *prompt = [Prompt promptWithMemessage:msg withFrame:CGRectMake(0, 0, 240 * kAUTOLAYOUTSCALE, 50 * kAUTOLAYOUTSCALE) withTime:1];
    [prompt setCenter:CGPointMake(kSCREEN_WIDTH / 2.0f, kSCREEN_HEIGHT / 2.0f)];
//    DDMenuController *slider = (DDMenuController *)kAppDelegate.window.rootViewController;
//    [slider showRootController:YES];
//    UITabBarController *rootVc = (UITabBarController *)slider.rootViewController;
//    [rootVc.selectedViewController.view addSubview:prompt];
}

+ (Prompt *)promptWithMemessage:(NSString *)msg withFrame:(CGRect)frame withTime:(NSInteger)time
{
    Prompt *lable=[[Prompt alloc] initWithFrame:frame];
    lable.textColor=[UIColor whiteColor];
    [lable setFont:kSetSystemFontOfSize(17)];
    lable.layer.masksToBounds=YES;
    lable.layer.cornerRadius=10*kAUTOLAYOUTSCALE;
    lable.backgroundColor=kColorBlue;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=msg;
    lable.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
       lable.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:time options:UIViewAnimationOptionLayoutSubviews animations:^{
            lable.alpha = 0;
        } completion:^(BOOL finished){
            [lable removeFromSuperview];
        }];
    }];
    return lable;
}

+ (void)promptWithMemessage:(NSString *)msg target:(id)target action:(SEL)action {
    Prompt *prompt = [Prompt promptWithMemessage:msg withFrame:CGRectMake(0, 0, 240 * kAUTOLAYOUTSCALE, 50 * kAUTOLAYOUTSCALE) withTime:1 target:target action:action];
    [prompt setCenter:CGPointMake(kSCREEN_WIDTH / 2.0f, kSCREEN_HEIGHT / 2.0f)];
    [kAppDelegate.window addSubview:prompt];
}

+ (Prompt *)promptWithMemessage:(NSString *)msg withFrame:(CGRect)frame withTime:(NSInteger)time target:(id)target action:(SEL)action {
    Prompt *lable=[[Prompt alloc] initWithFrame:frame];
    lable.target = target;
    lable.action = action;
    [lable setFont:kSetSystemFontOfSize(17)];
    lable.textColor=[UIColor whiteColor];
    lable.layer.masksToBounds=YES;
    lable.layer.cornerRadius=10*kAUTOLAYOUTSCALE;
    lable.backgroundColor=kColorBlack;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=msg;
    [UIView animateWithDuration:0.3 animations:^{
        lable.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:time options:UIViewAnimationOptionLayoutSubviews animations:^{
            lable.alpha = 0;
        } completion:^(BOOL finished){
            [lable removeFromSuperview];
            if ([lable.target respondsToSelector:lable.action]) {
                [(NSObject *)lable.target performSelector:lable.action];
            }
        }];
    }];
    return lable;
}

@end
