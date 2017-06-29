//
//  PromptAlertView.h
//  JuCaiBang
//
//  Created by kingphone_he on 15/12/1.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import "BaseAlertView.h"

#define PromptAlertViewWidth        320 * kAUTOLAYOUTSCALE
#define PromptAlertViewHeight       165 * kAUTOLAYOUTSCALE

@interface PromptAlertView : BaseAlertView
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

//- (void)updateUIWithInfo:(NSString *)info confirmButtonPressedCallBack:(JCBCallBack)callBack;

//- (void)updateUIBtn1:(NSString*)btn1 Btn2:(NSString*)btn2 WithInfo:(NSString *)info confirmButtonPressedCallBack:(JCBCallBack)callBack;


@end
