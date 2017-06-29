//
//  PromptAlertView.m
//  JuCaiBang
//
//  Created by kingphone_he on 15/12/1.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import "PromptAlertView.h"

@interface PromptAlertView ()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *confirm;
//@property (nonatomic, strong) JCBCallBack callBack;

@end

@implementation PromptAlertView
//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    [self setCircleWithRadius:8 * kAUTOLAYOUTSCALE];
//    [self autoLayoutAllSubViewsWithoutFont];
//    [self setPoints:@[kLinePointSet(0, self.confirm.top - KLineWidth, PromptAlertViewWidth, self.confirm.top - KLineWidth)]];
//    [self setWidth:PromptAlertViewWidth];
//    [self setHeight:PromptAlertViewHeight];
//}
//
//- (void)updateUIBtn1:(NSString *)btn1 Btn2:(NSString *)btn2 WithInfo:(NSString *)info confirmButtonPressedCallBack:(JCBCallBack)callBack
//{
//    [self.btn1 setTitle:btn1 forState:UIControlStateNormal];
//    [self.btn2 setTitle:btn2 forState:UIControlStateNormal];
//    [self updateUIWithInfo:info confirmButtonPressedCallBack:callBack];
//}
//
//- (void)updateUIWithInfo:(NSString *)info confirmButtonPressedCallBack:(JCBCallBack)callBack {
//    [self.infoLabel setText:info];
//    [self.infoLabel setFontAndColorWithString:@"p2042t2"];
//    [self sizeToFit];
//    [self.infoLabel setCenter:CGPointMake(self.width / 2.0f, self.confirm.top / 2.0f)];
//    [self setCallBack:callBack];
//}
//
//- (IBAction)cancelButtonDidPressed:(UIButton *)sender {
//    [self dismiss];
//}
//
//- (IBAction)confirmButtonDidPressed:(UIButton *)sender {
//    self.callBack();
//    [self dismiss];
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
