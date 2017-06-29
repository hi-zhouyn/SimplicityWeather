//
//  AppDelegate.h
//  SocialKids
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "BaseTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) NSString * isLogin;;
@property (nonatomic,strong) BMKMapManager *mapManger;
@end

