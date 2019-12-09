//
//  DrawUtil.h
//  JuCaiBang
//
//  Created by 陈全 on 15/7/24.
//
//

#import <Foundation/Foundation.h>

#define KLineWidth 0.5f //默认线条宽度

#define kLinePointSet(start_X,start_Y,stop_X,stop_Y) @[NSStringFromCGPoint(CGPointMake(start_X, start_Y)),NSStringFromCGPoint(CGPointMake(stop_X,stop_Y))]

#define kPointSet(ponit_x,point_y) NSStringFromCGPoint(CGPointMake(ponit_x, point_y))

@interface DrawUtil : NSObject

//example
/*
    [DrawUtil drawTableWithContext:context PointArr:@[kLinePointSet(0,0,2,2),@[NSStringFromCGPoint(CGPointMake(0, self.height)),NSStringFromCGPoint(CGPointMake(self.width, self.height))]]];
 */

//自定义线条宽度
+ (void)drawLinePointArr:(NSArray *)pointArr LineColor:(UIColor *)color LineWidth:(CGFloat)lineWidth;

//默认线条宽度
+ (void)drawLinePointArr:(NSArray *)pointArr LineColor:(UIColor *)color;


+ (NSArray *)autoLayoutLinePoints:(NSArray *)pointArr;

/**
 *  绘制曲线
 */

@end
