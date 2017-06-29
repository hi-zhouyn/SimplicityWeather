//
//  CustomAlertView.m
//  JuCaiBang
//
//  Created by 陈全 on 15/7/30.
//
//

#import "CustomAlertView.h"
#import "PromptAlertView.h"


@interface CustomAlertView ()


@end

@implementation CustomAlertView

//+ (void)presentAlertViewBtn1:(NSString *)btn1 Btn2:(NSString *)btn2 WithInfo:(NSString *)info confirmButtonPressedCallBack:(JCBCallBack)callBack
//{
//    UIView *bg = [[UIView alloc]initWithFrame:kFrameScreen];
//    bg.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0];
//    [kAppDelegate.window addSubview:bg];
//    PromptAlertView *promptAlertView = [PromptAlertView viewFromXibName:@"PromptAlertView"];
//    [promptAlertView updateUIBtn1:btn1 Btn2:btn2 WithInfo:info confirmButtonPressedCallBack:callBack];
//    promptAlertView.frame = CGRectMake(0, 0, PromptAlertViewWidth, PromptAlertViewHeight);
//    promptAlertView.alpha = 0;
//    promptAlertView.center = CGPointMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/2);
//    [bg addSubview:promptAlertView];
//    [promptAlertView initClick];
//    [UIView animateWithDuration:0.2 animations:^{
//        bg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//        promptAlertView.alpha = 1;
//    }];
//}

@end
