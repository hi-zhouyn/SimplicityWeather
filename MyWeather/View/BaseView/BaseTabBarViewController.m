//
//  BaseTabBarViewController.m
//  Fortune
//
//  Created by Bean on 15-5-21.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import "BaseTabBarViewController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = kColorOrangeRed;
    [[UITabBar appearance] setBackgroundColor:kColorWhite];
    [UITabBar appearance].translucent = NO;
    [self.tabBar  setShadowImage:[UIImage imageWithColor:kColorClear]];
    
    self.tabBar.shadowImage = [UIImage imageNamed:@"footer_line_translucent"];
   
}

- (void)setTabBarItemAttributes
{
    for (UIBarItem *barItem in self.tabBar.items) {
//        NSDictionary *normalStateAttribute = @{NSFontAttributeName:kCustomFontOfSize(15), NSForegroundColorAttributeName:kSetColor(126, 126, 126)};
        NSDictionary *selectedStateAttribute = @{NSFontAttributeName:kCustomFontOfSize(15), NSForegroundColorAttributeName:kColorWhite};
//        [barItem setTitleTextAttributes:normalStateAttribute forState:UIControlStateNormal];
        [barItem setTitleTextAttributes:selectedStateAttribute forState:UIControlStateSelected];
    }
}

@end
