//
//  BaseViewController.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kColorBg;
    [self setNav];
    [self tableViewHeightFix];
    [self setBackBarButtonItem];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//}

- (void)tableViewHeightFix
{
    if (GHoEIOS11) {
        //解决iOS11，仅实现heightForHeaderInSection，没有实现viewForHeaderInSection方法时,section间距大的问题
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    }
}

- (void)setNav
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorMain] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:kColorBg];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:KColorWhite}];
}

- (void)setBackBarButtonItem
{
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
        self.navigationItem.leftBarButtonItem.tintColor = KColorWhite;
    }else{
        self.navigationItem.hidesBackButton = YES;
        [self.navigationItem.leftBarButtonItem.customView setHidden:YES];
    }
}

- (void)goBack
{
    if (self.isModal) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)isModal {
    if([self presentingViewController])
        return YES;
    
    if([[[self navigationController] presentingViewController] presentedViewController] == [self navigationController])
        return YES;
    
    if([[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]])
        return YES;
    
    return NO;
}

//通过图片自定义BarButtonItem
- (UIBarButtonItem *)getBarButtonItemWithImage:(UIImage *)image action:(SEL)action
{
    UIBarButtonItem *bit = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:action];
    return bit;
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
