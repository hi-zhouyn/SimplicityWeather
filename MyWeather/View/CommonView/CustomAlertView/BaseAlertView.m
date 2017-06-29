//
//  BaseAlertView.m
//  JuCaiBang
//
//  Created by 陈全 on 15/7/30.
//
//

#import "BaseAlertView.h"

@implementation BaseAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tpClick)];
        [self addGestureRecognizer:self.tap];
    }
    return self;
}

- (void)tpClick
{
    
}


- (void)awakeFromNib
{
     self.tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tpClick)];
    [self addGestureRecognizer:self.tap];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 9;
}

- (void)dismiss
{
    WS(weakSelf);
    [UIView animateWithDuration:0.2 animations:^{
        UIView *view = weakSelf.superview;
        view.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        weakSelf.alpha = 0;
    }completion:^(BOOL finished) {
        [weakSelf.superview removeFromSuperview];
        
    }];
}

- (void)initClick
{
    UIView *view = self.superview;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [view addGestureRecognizer:tap];
}

- (void)tapClick
{
    [self dismiss];
    
}




@end
