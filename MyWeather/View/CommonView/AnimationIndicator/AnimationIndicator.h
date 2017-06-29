//
//  AnimationIndicator.h
//  SocialKids
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
// 网络加载不通畅时点击事件代理回调
//@protocol AnimationIndicatorDelegate <NSObject>
//-(void) tapAction : (id) sender;
//@end
@interface AnimationIndicator : UIView
//@property (nonatomic,weak) id<AnimationIndicatorDelegate> delegate;
@property (nonatomic,strong) UIImageView *indicatorImageView;
@property (nonatomic,strong) UILabel *indicatorLabel;
// 网络加载不通畅时点击事件回调
@property (nonatomic,copy) void (^tapAction)();
// 加载图片宽  不传默认80
@property (nonatomic,assign) NSInteger width;
// 加载图片高  不传默认80
@property (nonatomic,assign) NSInteger height;
/**
 *  文字显示 不传不显示
 */
@property (nonatomic,strong) NSString *titleStr;
/**
 *  开始加载
 */
-(void) AnimationIndicatorShow;
/**
 *  介绍加载
 */
-(void) AnimationIndicatorHide;
// 网络加载不通畅或者加载失败时调用
-(void) netWorkInterruotionOrNotSmoothTitle : (NSString *) title;
@end
