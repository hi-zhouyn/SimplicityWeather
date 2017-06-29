//
//  MBprogressUtil.h
//  JuCaiBangManager
//
//  Created by 陈全 on 15/10/23.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MBprogressUtil : MBProgressHUD

@property (assign,nonatomic)NSInteger showCount;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) UIImageView *gifImage;
+ (MBprogressUtil*)shareInstance;

//信号量控制
- (void)showMessage:(NSString *)message;
-(void) showOnlyStr:(NSString *) title;

//-(void) showGif : (NSString *) titleStr;

- (void)hide;

@end
