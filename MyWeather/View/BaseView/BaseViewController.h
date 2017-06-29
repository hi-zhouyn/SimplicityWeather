//
//  BaseViewController.h
//  Fortune
//
//  Created by Bean on 15-5-21.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorMacro.h"
#import "FontMacro.h"
#import "MJRefresh.h"

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL interactivePopGestureRecognizerEnable;


- (void)rightBarItemStatrRefresh;

- (void)setNavigationBarPinkWithTitle:(NSString *)title;//粉红

- (void)setNavigationBarGrayWithTitle:(NSString *)title;//灰色

- (void)setNavigationBarWithSearch:(void(^)(NSString *text))textChange;//搜索


- (void)hideKeyboardTapGesture;

- (UIBarButtonItem *)twoRightBarButtonWithImages:(NSArray *)images withFirstAction:(SEL)firstAction secondAction:(SEL)secondAction;

- (UIBarButtonItem *)getBarButtonItemWithImage:(UIImage *)image withAction:(SEL)action;

- (UIBarButtonItem *)getBarbuttonItemWith:(NSString *)string withAction:(SEL)action;

- (void)setupRefreshFortableView:(UITableView *)tableView WithAction:(SEL)headerRereshing and:(SEL)footderReReshing;

/**
 *  需要在 ViewWillAppear  中实现
 *  因为  viewController 共享一个 navigationController
 *  不重写 viewWillAppear 的话在基类的viewWillAppear 中实现了设置返回按钮的方法
 *  因为基类中的设置返回按钮也需要在 appear 方法中实现
 - (void)viewWillAppear:(BOOL)animated {
    [self setHideBackBarButton];
 }
 */
- (void)setHideBackBarButton;

/**
 *  有手势、默认返回上一页
 */
- (void)setBackBarButtonItem;

- (void)setBackBarButtonItemWithoutGestureRecognizer;
/**
 *  无手势返回、自定义action
 *
 *  @param action
 */
- (void)setBackBarButtonItemWithoutGestureRecognizerWithAction:(SEL)action;

/**
 *  有手势、自定义action
 *
 *  @param action
 */
- (void)setBackBarButtonItemAction:(SEL)action;

- (void)goBack;

-(void) hiddenTextField;

/**
 *  用于延时回调
 */
- (void)back:(NSInteger)idx;

@end
