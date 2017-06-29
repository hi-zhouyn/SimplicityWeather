//
//  BaseAlertView.h
//  JuCaiBang
//
//  Created by 陈全 on 15/7/30.
//
//

#import "BaseViewFromXib.h"

@interface BaseAlertView : BaseViewFromXib
@property (strong,nonatomic)UITapGestureRecognizer *tap;

- (void)dismiss;


//addSubview 之后调用
- (void)initClick;



@end
