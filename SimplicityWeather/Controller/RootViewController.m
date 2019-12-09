//
//  RootViewController.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/28.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "RootViewController.h"
#import "WeatherViewController.h"
#import "GroupViewController.h"

@interface RootViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, assign) NSInteger idnex;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *viewControllersArr;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.pageViewController setViewControllers:@[[self.viewControllersArr firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.navigationItem.rightBarButtonItem = [self getBarButtonItemWithImage:ImageNamed(@"group") action:@selector(goToGroup)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:KColorClear];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:KColorClear] forBarMetrics:UIBarMetricsDefault];
}

- (void)goToGroup
{
    KPushVC(GroupViewController);
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllersArr indexOfObject:viewController];
    if (!index || index == NSNotFound) {
        return nil;
    }
    index --;
    return [self.viewControllersArr objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllersArr indexOfObject:viewController];
    if (index == self.viewControllersArr.count - 1 || index == NSNotFound) {
        return nil;
    }
    index ++;
    return [self.viewControllersArr objectAtIndex:index];
}

- (UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStyleScroll) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
        [_pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(-0.5);
        }];
    }
    return _pageViewController;
}

- (NSMutableArray *)viewControllersArr
{
    if (!_viewControllersArr) {
        _viewControllersArr = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            WeatherViewController *temVC = [[WeatherViewController alloc] init];
            [_viewControllersArr addObject:temVC];
        }
    }
    return _viewControllersArr;
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
