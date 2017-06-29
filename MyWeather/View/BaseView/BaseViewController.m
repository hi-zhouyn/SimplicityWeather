//
//  BaseViewController.m
//  Fortune
//
//  Created by Bean on 15-5-21.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import "BaseViewController.h"
//#import "CSTextFieldView.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

//自定义NavBar标题
- (void)setNavigationBarPinkWithTitle:(NSString *)title
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorPink] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = title;
    if (!iOS7) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorWhite,NSFontAttributeName:kFontNavBarPink}];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:kColorWhite,UITextAttributeFont:kFontNavBarPink}];
    }
}

- (void)setNavigationBarGrayWithTitle:(NSString *)title
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorBg] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = title;
    if (!iOS7) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorBlack,NSFontAttributeName:kFontNavBarGray}];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:kColorBlack,UITextAttributeFont:kFontNavBarGray}];
    }
}

- (void)setNavigationBarWithSearch:(void(^)(NSString *text))textChange
{
//    [self.navigationController.navigationBar setBackgroundImage:[Commom imageWithColor:kColorPink] forBarMetrics:UIBarMetricsDefault];
//    CSTextFieldView *search = [[CSTextFieldView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH/2, 28)];
//    [search setCircleWithRadius:14];
//    search.textField.tintColor = kColorWhite;
//    search.textField.font = kFontNavBarSearch;
//    search.textField.textColor = kColorWhite;
//    [search setTextEditingLeft:7];
//    search.backgroundColor = kColorSearchBg;
//    UIImageView *bg = [[UIImageView alloc]initWithImage:[Commom imageWithColor:kColorWhite]];
//    bg.frame = CGRectMake(0, 0, 20, 20);
//    bg.right = search.width-7;
//    bg.centerY = search.centerY;
//    search.rightView = bg;
//    [search setTextFieldChangeTextCallBack:^(NSString *text) {
//        textChange(text);
//    }];
//    self.navigationItem.titleView = search;
}

- (UIBarButtonItem *)twoRightBarButtonWithImages:(NSArray *)images withFirstAction:(SEL)firstAction secondAction:(SEL)secondAction {
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80 * kAUTOLAYOUTSCALE, 40 * kAUTOLAYOUTSCALE)];
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(0 * kAUTOLAYOUTSCALE, 0, 40 * kAUTOLAYOUTSCALE, 40 * kAUTOLAYOUTSCALE);
    [firstBtn setImage:images[0] forState:UIControlStateNormal];
    [firstBtn addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:firstBtn];
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(40 * kAUTOLAYOUTSCALE, 0, 40 * kAUTOLAYOUTSCALE, 40 * kAUTOLAYOUTSCALE);
    [secondBtn setImage:images[1] forState:UIControlStateNormal];
    [secondBtn addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:secondBtn];
    
    UIBarButtonItem *bit = [[UIBarButtonItem alloc] initWithCustomView:barView];
    return bit;
}

//通过图片自定义BarButtonItem
- (UIBarButtonItem *)getBarButtonItemWithImage:(UIImage *)image withAction:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bit = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return bit;
}

//通过文字自定义BarButtonItem
- (UIBarButtonItem *)getBarbuttonItemWith:(NSString *)string withAction:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    CGSize size = [string sizeWithFont:kSetSystemFontOfSize(21) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)]; 
//    btn.frame = CGRectMake(0, 0, kNavBarHeight,size.width );
//    [btn setTitle:string forState:UIControlStateNormal];
//    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitleColor:kColorBlue forState:UIControlStateNormal];
//    [btn setTitleColor:kColorSpert3 forState:UIControlStateHighlighted];
    UIBarButtonItem *bit = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return bit;
}

//下拉刷新
- (void)setupRefreshFortableView:(UITableView *)tableView WithAction:(SEL)headerRereshing and:(SEL)footderReReshing
{
    //    [tableView add]]
    if (headerRereshing) {
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:headerRereshing];
        
    }
    if (footderReReshing) {
        tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:footderReReshing];
    }
}

- (void)setHideBackBarButton {
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem.leftBarButtonItem.customView setHidden:YES];
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
    [self setInteractivePopGestureRecognizerEnable:NO];
}

/**
 *  有手势、默认返回上一页
 */
- (void)setBackBarButtonItem {
    [self setInteractivePopGestureRecognizerEnable:YES];
    [self setBackBarButtonItemAction:@selector(goBack)];
}

- (void)setBackBarButtonItemWithoutGestureRecognizer {
    [self setBackBarButtonItemWithoutGestureRecognizerWithAction:@selector(goBack)];
}

/**
 *  无手势返回、自定义action
 *
 *  @param action
 */
- (void)setBackBarButtonItemWithoutGestureRecognizerWithAction:(SEL)action {
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [self getBarButtonItemWithImage:[UIImage imageNamed:@"Back"] withAction:action?action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem.tintColor = kColorOrange;
    [self setInteractivePopGestureRecognizerEnable:NO];
}

/**
 *  有手势、自定义action
 *
 *  @param action
 */
- (void)setBackBarButtonItemAction:(SEL)action
{
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [self getBarButtonItemWithImage:[UIImage imageNamed:@"Back"] withAction:action?action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem.tintColor = kColorOrange;
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


//-(void) hiddenTextField
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
//}
//-(void) keyboardWillShow:(NSNotification *) sender
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        
//         self.view.frame = CGRectMake(0, -64, kSCREEN_WIDTH, kSCREEN_HEIGHT);
//    }];
//   
//}
//
//-(void) keyboardWillHidden: (NSNotification *) sender
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.view.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
//    }];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //控制器初始化设置
    // 导航栏设置不透明（坐标原点从导航条底部开始）
    [self.navigationController.navigationBar setTranslucent:NO];
    //导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorWhite] forBarMetrics:UIBarMetricsDefault];
    //控制器背景
    self.view.backgroundColor = kColorBg;
    self.navigationController.navigationBar.tintColor = kColorClear;
    // 设置标题字号及颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:kColorBlack}];
//    [self setFonts];
//    if (iPhone6Plus) {
//        
//        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont  systemFontOfSize:17]}];
//    }

////        self.view.backgroundColor = kColorBg;
//    
////    self.navigationItem.backBarButtonItem = [self getBarButtonItemWithImage:[UIImage imageNamed:@"icon_back_blue"] withAction:nil];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
}
//-(void) backAction: (UINavigationItem *) sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count != 1) {
        [self setBackBarButtonItem];
    } else {
        [self setHideBackBarButton];
    }
    [kAppDelegate.window endEditing:YES];
}

- (void)rightBarItemStatrRefresh
{
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [view startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
}

- (void)hideKeyboardTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToHideKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)tapToHideKeyboard {
    [self.view endEditing:YES];
}

- (void)back:(NSInteger)idx
{
    NSArray *arr = self.navigationController.viewControllers;
    UIViewController *vc = arr[arr.count-1-idx];
    [self.navigationController popToViewController:vc animated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isMemberOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        NSLog(@"%d",self.interactivePopGestureRecognizerEnable);
        return self.interactivePopGestureRecognizerEnable;
    }
    return YES;
}

@end
