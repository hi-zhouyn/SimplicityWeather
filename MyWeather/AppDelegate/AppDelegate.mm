//
//  AppDelegate.m
//  SocialKids
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "AppDelegate.h"
#import "WXController.h"
#import "UmengUtil.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _mapManger = [[BMKMapManager alloc] init];
    if (![_mapManger start:BaiDuMapKey generalDelegate:self]) {
        NSLog(@"加载百度地图失败");
    }
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController  alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = navigation;

    
//    [AppDelegateTableBar showMain];
        return YES;
}

#pragma mark 获取device token失败后
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void) onGetNetworkState:(int)iError
{
    if (iError == 0) {
        NSLog(@"联网成功");
    }else
    {
        NSLog(@"联网失败:%d",iError);
    }
}

-(void)onGetPermissionState:(int)iError
{
    if (iError == 0) {
        NSLog(@"授权成功");
    }else
    {
        NSLog(@"授权失败%d",iError);
    }
}



@end
