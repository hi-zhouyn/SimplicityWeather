//
//  BaseTableViewCell.h
//  CrazyBox
//
//  Created by 陈全 on 15/12/9.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SeparatorLineColor          kColorLine
#define SeparatorWideLineColor      kColorBg

/*
 *  可以用这个宏快速获取一个字典，放到数组，可以在当前cell上随意绘制线条
 */
#define PointDic(pointArr, color, width) [BaseTableViewCell getPointDicWithPointArray:pointArr lineColor:color lineWidth:width]

typedef NS_ENUM(NSInteger, SeparatorLineType) {
    SeparatorLineTypeNone,                      //  无分割线
    SeparatorLineTypeWideTop,                   //  宽分割线上
    SeparatorLineTypeWide,                      //  宽分割线
    SeparatorLineTypeTop,                       //  长分割线上
    SeparatorLineTypeBottom,                    //  长分割线下
    SeparatorLineTypeTopAndBottom,              //  长分割线上下
    SeparatorLineTypeCenterShortTop,            //  短居中分割线上
    SeparatorLineTypeCenterShortBottom,         //  短居中分割线下
    SeparatorLineTypeCenterShortTopAndBottom,   //  短居中分割线上下
    SeparatorLineTypeLeftShortTop,              //  短居左分割线上
    SeparatorLineTypeLeftShortBottom,           //  短居左分割线下
    SeparatorLineTypeLeftShortTopAndBottom,     //  短居左分割线上下
    SeparatorLineTypeRightShortTop,             //  短居右分割线上
    SeparatorLineTypeRightShortBottom,          //  短居右分割线下
    SeparatorLineTypeRightShortTopAndBottom,    //  短居右分割线上下
};

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) NSInteger index;

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

/**
 *  如果 YES 则 cell背景颜色为灰色
 */
@property (nonatomic, getter=isGrayBg, assign) BOOL grayBg;

/*
 *  可以用上面的宏快速获取一个字典，放到数组，可以在当前cell上随意绘制线条
 */
+ (NSDictionary *)getPointDicWithPointArray:(NSArray *)pointArray lineColor:(UIColor *)color lineWidth:(CGFloat)width;

@end
