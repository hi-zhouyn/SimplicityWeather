//
//  UmengUtil.m
//  UMSocial_Sdk_Demo
//
//  Created by seastar on 15/3/28.
//  Copyright (c) 2015年 yeahugo. All rights reserved.
//

#import "UmengUtil.h"
#import "WXController.h"
#import "ShareView.h"

@implementation UmengUtil

+(void)init{
    
//    [MobClick startWithAppkey:UmengAppkey];
//    [UMSocialData setAppKey:UmengAppkey];
//    
//    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToWechatSession, UMShareToWechatTimeline]];
//    [UMSocialData openLog:NO];
//    
//    [UMSocialWechatHandler setWXAppId:WXAppKey appSecret:WXAppSecret url:APIBASE];
//    [UMSocialQQHandler setQQWithAppId:qqAPPID appKey:qqAPPKEY url:APIBASE];
}

+(void) presentShareView:(UIViewController *)controller
{
    /**
     自定义分享视图
     */
    
    UIView *bg = [[UIView alloc]initWithFrame:kFrameScreen];
    bg.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [kAppDelegate.window addSubview:bg];
    ShareView *share = (ShareView *)[Common viewFromXibName:@"ShareView"];
//    share.delegate = self;
    share.frame = CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kShareViewHeight);
    [bg addSubview:share];
    [share initClick];
    [UIView animateWithDuration:0.2 animations:^{
        bg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        share.frame = CGRectMake(0, kSCREEN_HEIGHT-kShareViewHeight, kSCREEN_WIDTH, kShareViewHeight);
    }];
    
}







@end
