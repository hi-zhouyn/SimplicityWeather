//
//  ChdBaseAlertView.m
//  GYY
//
//  Created by kings on 15/11/18.
//  Copyright © 2015年 kings. All rights reserved.
//

#import "ChdBaseAlertView.h"
@interface ChdBaseAlertView ()<UIAlertViewDelegate>

@end
@implementation ChdBaseAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(void)showAlertViewWithMessage:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    [alertView show];
    
}
+(void)showAlertViewWithMessage:(NSString *)message delegate:(id)delegate{

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:delegate cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    [alertView show];
}


+(void)showAlertViewWithMessage:(NSString *)message cusButtonTitle:(NSString *)cusButtonTitles, ...{

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:cusButtonTitles, nil];
    [alertView show];
}


+(void)showAlertViewWithMessage:(NSString *)message delegate:(id)delegate cusButtonTitle:(NSString *)cusButtonTitles, ...{

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:delegate cancelButtonTitle:nil otherButtonTitles:cusButtonTitles, nil];
    [alertView show];
}


+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message{

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    [alertView show];
}

+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate{

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    [alertView show];
}

+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message otherButtonTitles:(NSString *)otherButtonTitles, ...{

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:otherButtonTitles, nil];
    [alertView show];
}

+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate otherButtonTitles:(NSString *)otherButtonTitles, ...{

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:nil otherButtonTitles:otherButtonTitles, nil];
    [alertView show];
}


@end
