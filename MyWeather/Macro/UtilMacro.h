//
//  UtilMacro.h
//  JuCaiBangManager
//
//  Created by 陈全 on 15/9/26.
//  Copyright © 2015年 陈全. All rights reserved.
//

#ifndef UtilMacro_h
#define UtilMacro_h


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define kAppDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define KsessionID [[NSUserDefaults standardUserDefaults ] objectForKey:@"sessionID"]
 /**
 *  提示框
 */
#define KPrompt(msg)        [Prompt promptWithMemessage:msg]

/**
 *  指示器
 */
#define kprogressHudShow(textlable) [[MBprogressUtil shareInstance]showMessage:textlable]
#define kprogressHudOnlyStr(title) [[MBprogressUtil shareInstance] showOnlyStr:title]
//#define kprogressHudGifAndTitle(title) [[MBprogressUtil shareInstance] showGif:title]
#define kprogressHudHide [[MBprogressUtil shareInstance] hide]
//#define iOS9 (([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0f) ? YES : NO)


#if iOS9

#define KShowAlert(ktitle,kmessage)\
{\
UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ktitle message:kmessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil , nil];\
[alertView show];\
}

#else

#define KShowAlert(ktitle,kmessage)\
{\
UIAlertController *alert = [UIAlertController alertControllerWithTitle:ktitle message:kmessage preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];\
[alert addAction:okAction];\
[kAppDelegate.window.rootViewController presentViewController:alert animated:YES completion:nil];\
}

#define KShowAlert1(ktitle1,kmessage1)\
{\
UIAlertController *alert = [UIAlertController alertControllerWithTitle:ktitle1 message:kmessage1 preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];\
[alert addAction:okAction];\
[kAppDelegate.window.rootViewController presentViewController:alert animated:YES completion:nil];\
}
#endif
//[alert addAction:cancelAction];\

#define kShowError KShowAlert(@"错误",[error description])

//NSIndexPath
#define IndexZero                   [NSIndexPath indexPathForRow:0 inSection:0]
#define Index(row)                  [NSIndexPath indexPathForRow:row inSection:0]
#define IndexPath(row, section)     [NSIndexPath indexPathForRow:row inSection:section]


#endif /* UtilMacro_h */
