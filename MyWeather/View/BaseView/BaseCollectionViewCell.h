//
//  BaseCollectionViewCell.h
//  CrazyBox
//
//  Created by kingphone_he on 15/12/10.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface BaseCollectionViewCell : UICollectionViewCell

/*
 *  如果上下分割线离屏幕左右有一定距离，必须设置这个距离
 */
@property (nonatomic, assign) CGFloat space;
/*
 *  如果当前 cell需要用到以上分割线的随意组合，可以把这个枚举组合放到下面数组
 */
@property (nonatomic, strong) NSArray *separatorLineTypes;
/*
 *  按照上面的分割线的类型，设置 cell的分割线
 */
@property (nonatomic, assign) SeparatorLineType separatorLineType;
/*
 *  设置分割线的颜色，默认黑色，必须设置
 *  如果以后有必要可以设置默认颜色
 */
@property (nonatomic, strong) UIColor *separatorLineColor;

/**
 *  如果 YES 则 cell背景颜色为灰色
 */
@property (nonatomic, getter=isGrayBg, assign) BOOL grayBg;

/*
 *  格式
 *  @[kLinePointSet(<#start_X#>, <#start_Y#>, <#stop_X#>, <#stop_Y#>),
 kLinePointSet(<#start_X#>, <#start_Y#>, <#stop_X#>, <#stop_Y#>)]
 *  默认线宽 KLineWidth
 *  默认颜色 kColorLine
 */
@property (nonatomic, strong) NSArray *points;
/*
 *  格式
 *  @[@{@"point":@[kLinePointSet(<#start_X#>, <#start_Y#>, <#stop_X#>, <#stop_Y#>),
 kLinePointSet(<#start_X#>, <#start_Y#>, <#stop_X#>, <#stop_Y#>)],
 @"color":[UIColor blueColor],
 @"width":@(KLineWidth)},
 @{@"point":@[kLinePointSet(<#start_X#>, <#start_Y#>, <#stop_X#>, <#stop_Y#>),
 kLinePointSet(<#start_X#>, <#start_Y#>, <#stop_X#>, <#stop_Y#>)],
 @"color":[UIColor blueColor],
 @"width":@(KLineWidth)}]
 */
@property (nonatomic, strong) NSArray *linesPointsArray;

@end
