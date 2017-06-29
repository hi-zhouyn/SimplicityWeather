//
//  SVPHUDUtil.m
//  SocialKids
//
//  Created by admin on 16/6/27.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "SVPHUDUtil.h"
#import "SVProgressHUD.h"
@implementation SVPHUDUtil

+(void)show
{
    [SVProgressHUD show];
//    SVProgressHUD
    [SVProgressHUD setRingThickness:4];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setForegroundColor:kColorOrangeRed];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
}
+(void) show:(NSString *)title
{
    [SVProgressHUD showWithStatus:title];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setForegroundColor:kColorOrangeRed];
    [SVProgressHUD setBackgroundColor:kColorWhite];
}
+(void) hiden
{
    [SVProgressHUD dismiss];
}
+(void)hiden:(NSString *)title
{
    [SVProgressHUD displayDurationForString:title];
}
@end
