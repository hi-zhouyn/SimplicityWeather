//
//  MBprogressUtil.m
//  JuCaiBangManager
//
//  Created by 陈全 on 15/10/23.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import "MBprogressUtil.h"

@interface MBprogressUtil ()
@property (strong,nonatomic) MBProgressHUD *showHUD;
@property (strong,nonatomic) UIView *hudSuperView;
@property (nonatomic,strong) NSTimer *time;

@end

@implementation MBprogressUtil

+ (MBprogressUtil*)shareInstance
{
    static MBprogressUtil* mb = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        mb = [[[self class] alloc] initWithWindow:kAppDelegate.window];
//        wxc.color = (56, 162, 236, 0.8);
        mb.removeFromSuperViewOnHide = YES;

    });
    return mb;
}

//- (void)showMessage:(NSString *)message
//{
//    self.showCount ++;
//    
//    UIView *superView = nil;
//    
//    UIViewController *vc = kAppDelegate.window.rootViewController;
//    if ([vc isKindOfClass:[UINavigationController class]]) {
//        superView = vc.view;
//    }else{
//        UITabBarController *rootVc = (UITabBarController *)kAppDelegate.window.rootViewController;
//        superView = rootVc.selectedViewController.view;
//    }
//    
//    if (!self.showHUD) {
//        self.showHUD = [MBProgressHUD showHUDAddedTo:superView animated:YES];
//        self.hudSuperView = superView;
//    }else{
//        if (self.hudSuperView != superView) {
//            self.showHUD.removeFromSuperViewOnHide = NO;
//            [self.showHUD hide:NO];
//            self.showHUD = [MBProgressHUD showHUDAddedTo:superView animated:NO];
//            self.hudSuperView = superView;
//        }
//    }
//}
//
//-(void)hide
//{
//    self.showCount --;
//    if (!self.showCount) {
//        self.showHUD.removeFromSuperViewOnHide = YES;
//        [self.showHUD hide:YES];
//        self.showHUD = nil;
//    }
//}

//------------------------------

- (void)showMessage:(NSString *)message
{
    [super show:YES];
    self.labelText = message;
    self.mode = MBProgressHUDModeIndeterminate;
    UIViewController *vc = kAppDelegate.window.rootViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        [vc.view addSubview:self];
        return;
    }
    UITabBarController *rootVc = (UITabBarController *)kAppDelegate.window.rootViewController;
    [rootVc.selectedViewController.view addSubview:self];
    
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
    self.showCount = 1;
}
-(void) showOnlyStr: (NSString *) title
{
    [super show:YES];
    self.labelText = title;
    
    self.mode = MBProgressHUDModeCustomView;
    [self hide:YES afterDelay:1];
    UIViewController *vc = kAppDelegate.window.rootViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        [vc.view addSubview:self];
        return;
    }
    UITabBarController *rootVc = (UITabBarController *)kAppDelegate.window.rootViewController;
    [rootVc.selectedViewController.view addSubview:self];
    
}
-(void) showGif : (NSString *) titleStr
{
    [super show:YES];
    _gifImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 37, 37)];
    _gifImage.image = [UIImage imageNamed:@"15.jpg"];
    [_gifImage setCircle];
//    self.labelText = titleStr;
    self.mode = MBProgressHUDModeCustomView;
    self.customView= _gifImage;
    UIViewController *vc = kAppDelegate.window.rootViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        [vc.view addSubview:self];
        return;
    }
    UITabBarController *rootVc = (UITabBarController *)kAppDelegate.window.rootViewController;
    [rootVc.selectedViewController.view addSubview:self];
//   NSTimer *time = [NSTimer  scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(beginChange) userInfo:nil repeats:YES];
}
-(void ) beginChange
{
    _gifImage.transform =  CGAffineTransformRotate(_gifImage.transform, M_PI/360);
}

-(void) timeAction
{
    self.showCount ++;
    if (self.showCount == 50) {
         [self hide:YES];
        [self.time invalidate];
//        [AlertShow alertShowWithContent:@"提示" Message:@"请求超时，请重新请求再试" Seconds:1];
    }
}

-(void)hide
{
    [super hide:YES];
}
-(UIImageView *)gifImage
{
    if (!_gifImage) {
        _gifImage = [[UIImageView alloc] init];
       NSMutableArray *imageArr = [NSMutableArray array];
        for (int i = 1 ; i < 7; i ++) {
            NSString *nameStr = [NSString stringWithFormat:@"%d.png",i];
            [imageArr addObject:[UIImage imageNamed:nameStr]];
        }
        _gifImage.animationImages = imageArr;
    }
    return _gifImage;
}

@end
