//
//  AlterShow.m
//  GGSee
//
//  Created by admin on 16/6/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "AlertShow.h"

@implementation AlertShow

+(void)alertShowWithContent:(NSString *)content Message:(NSString *) message Seconds:(CGFloat)second {
    
    if (iOS8) {
        
        UIAlertController *alert =[ UIAlertController alertControllerWithTitle:content message: message preferredStyle:UIAlertControllerStyleAlert];
        [kAppDelegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
        [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(cancelAlter:) userInfo:alert repeats:NO];
        
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:content message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(cancelAlter:) userInfo:alert repeats:NO];
        [alert show];
        
    }
}
+(void)cancelAlter:(NSTimer *)sender
{
    if (iOS8) {
        UIAlertController *promptAlert = (UIAlertController*)[sender userInfo];
        [promptAlert dismissViewControllerAnimated:YES completion:nil];
        promptAlert =NULL;
    }else
    {
        UIAlertView *promptAlert = (UIAlertView *) [sender userInfo];
        [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
        promptAlert =NULL;
        
    }
    
}

@end
