//
//  ZLNavigationController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 15/11/25.
//  Copyright © 2015年 com.zixue101.www. All rights reserved.
//

#import "ZLNavigationController.h"

@interface ZLNavigationController ()

@end

@implementation ZLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    // 导航栏设置不透明（坐标原点从导航条底部开始）
//    [self.navigationController.navigationBar setTranslucent:NO];
//    //导航栏背景
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorOrangeRed] forBarMetrics:UIBarMetricsDefault];
//    //控制器背景
//    self.view.backgroundColor = kColorBg;
//    self.navigationController.navigationBar.tintColor = kColorClear;
    // 设置标题字号及颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:kColorBlack}];
    
    self.navigationItem.rightBarButtonItem.tintColor = kColorOrangeRed;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
