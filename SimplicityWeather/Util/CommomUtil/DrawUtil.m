//
//  DrawUtil.m
//  JuCaiBang
//
//  Created by 陈全 on 15/7/24.
//
//

#import "DrawUtil.h"

@implementation DrawUtil

+ (void)drawLinePointArr:(NSArray *)pointArr LineColor:(UIColor *)color
{
    [DrawUtil drawLinePointArr:pointArr LineColor:color LineWidth:KLineWidth];
}

+ (void)drawLinePointArr:(NSArray *)pointArr LineColor:(UIColor *)color LineWidth:(CGFloat)lineWidth
{
    for (NSArray *linePoints in pointArr) {
        CGPoint ponitStart = CGPointFromString(linePoints[0]);
        CGPoint ponitStop = CGPointFromString(linePoints[1]);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:ponitStart];
        [path addLineToPoint:ponitStop];
        path.lineWidth = lineWidth;
        [color setStroke];
        [path stroke];
    }
}

+ (NSArray *)autoLayoutLinePoints:(NSArray *)pointArr
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSArray *linePoints in pointArr) {
        CGPoint ponitStart = CGPointFromString(linePoints[0]);
        CGPoint newPonitStart = CGPointMake(ponitStart.x*KAUTOLAYOUTSCALE_WIDTH, ponitStart.y*KAUTOLAYOUTSCALE_WIDTH);
        
        CGPoint ponitStop = CGPointFromString(linePoints[1]);
        CGPoint newPonitStop = CGPointMake(ponitStop.x*KAUTOLAYOUTSCALE_WIDTH, ponitStop.y*KAUTOLAYOUTSCALE_WIDTH);
        
        [arr addObject:@[NSStringFromCGPoint(newPonitStart),NSStringFromCGPoint(newPonitStop)]];
    }
    return arr;
}

@end
