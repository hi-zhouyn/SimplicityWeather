//
//  SegmentedControl.h
//  JuCaiBang
//
//  Created by 21Lovetong on 15/7/23.
//
//

#import "BaseViewFromXib.h"

#define Space 2

@class SegmentedControl;

@protocol SegmentedControlDelegate <NSObject>

/*
 *  代理回调方法
 @  parmater baseSegmentedControl   segmentedControl 自身
 @  parmater index                  选中按钮的下标
 */
- (void)segmentedControl:(SegmentedControl *)segmentedControl didSelectButtonAtIndex:(NSInteger)index;

@end

@interface SegmentedControl : BaseViewFromXib
@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) NSArray *titles;

/*
 *  按钮未选中状态背景颜色
 */
@property (nonatomic, strong) UIColor *buttonsbackgroundColor;

/*
 *  按钮选中状态背景颜色
 */
@property (nonatomic, strong) UIColor *selectedBackgroundColor;

/*
 *  按钮未选中状态字体颜色
 */
@property (nonatomic, strong) UIColor *titleColor;

/*
 *  按钮选中状态字体颜色
 */
@property (nonatomic, strong) UIColor *selectedTitleColor;

/*
 *  按钮未选中状态边框颜色（选中状态无边框）
 */
@property (nonatomic, strong) UIColor *borderColor;

/*
 *  按钮未选中状态边框宽度（选中状态无边框）
 */
@property (nonatomic, assign) CGFloat borderWidth;

/*
 *  按钮圆角半径
 */
@property (nonatomic, assign) CGFloat buttonsCornerRadius;

/*
 *  按钮间距（默认为 2（4像素））
 */
@property (nonatomic, assign) CGFloat itemSpace;

/*
 *  当前选中按钮下标
 */
@property (nonatomic, assign) NSInteger currentSelectedIndex;

/*
 *  选中的按钮背景图片
 */
@property (nonatomic, strong) UIImage *selectedBackgroundImage;

@property (nonatomic, assign) CGFloat seperaterHeight;

@property (nonatomic, strong) UIFont *font;

/*
 *  初始化
 @  parmater frmae      坐标、大小
 @  parmater delegate   代理
 @  parmater titles     存放标题的数组
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<SegmentedControlDelegate>)delegate titles:(NSArray *)titles;

/**
 *  设置tag
 */
- (void)setTags:(NSArray *)tags;

@end
