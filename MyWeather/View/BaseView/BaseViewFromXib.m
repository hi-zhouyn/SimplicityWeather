 //
//  BaseViewFormXib.m
//  Free_Kicker01
//
//  Created by 陈全的mac on 15/3/18.
//  Copyright (c) 2015年 陈全的mac. All rights reserved.
//

#import "BaseViewFromXib.h"
#import "BaseTableViewCell.h"

@interface BaseViewFromXib ()

@property (nonatomic, assign) BOOL needSets;

@end

@implementation BaseViewFromXib

+ (id)viewFromXibName:(NSString *)xibName{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
    BaseViewFromXib *view = [nibView objectAtIndex:0];
    [view setNeedSets:YES];
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self cs_set];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self cs_set];
    }
    return self;
}

- (void)cs_set {
    if (self.needSets) {
        if (!self.backgroundColor) {
            [self setBackgroundColor:kColorWhite];
        }
        [self setNeedSets:NO];
        [self setSeparatorLineColor:SeparatorLineColor];
//        [self setFonts];
    }
}

//- (void)setFonts {
//    for (UIView *view in self.subviews) {
//        [view setFontAndColorWithInitialedText];
//        if (![view isButton]) {
//            for (UIView *subView in view.subviews) {
//                [subView setFontAndColorWithInitialedText];
//            }
//        }
//    }
//}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self setNeedSets:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self cs_set];
}

- (void)setPoints:(NSArray *)points {
    if (_points != points) {
        _points = points;
        [self setLinesPointsArray:@[PointDic(points, kColorLine, KLineWidth)]];
    }
}

- (void)setLinesPointsArray:(NSArray *)linesPointsArray {
    if (_linesPointsArray != linesPointsArray) {
        _linesPointsArray = linesPointsArray;
        [self setNeedsDisplay];
    }
}

- (void)setSpace:(CGFloat)space {
    _space = space;
}

- (void)setSeparatorLineTypes:(NSArray *)separatorLineTypes {
    if (_separatorLineTypes != separatorLineTypes) {
        _separatorLineTypes = separatorLineTypes;
        [self setNeedsDisplay];
    }
}

- (void)setSeparatorLineType:(SeparatorLineType)separatorLineType {
    _separatorLineType = separatorLineType;
    [self setSeparatorLineTypes:@[@(separatorLineType)]];
}

- (void)setSeparatorLineColor:(UIColor *)separatorLineColor {
    _separatorLineColor = separatorLineColor;
    [self needsDisplay];
}

+ (NSDictionary *)getPointDicWithPointArray:(NSArray *)pointArray lineColor:(UIColor *)color lineWidth:(CGFloat)width {
    return @{@"point":pointArray, @"color":color, @"width":@(width)};
}

- (void)needsDisplay {
    if (self.separatorLineType != SeparatorLineTypeNone) {
        [self setNeedsDisplay];
    }
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    [super drawLayer:layer inContext:ctx];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    for (NSDictionary *pointAndColor in self.linesPointsArray) {
        [DrawUtil drawLinePointArr:[pointAndColor objectForKey:@"point"] LineColor:[pointAndColor objectForKey:@"color"] LineWidth:[[pointAndColor objectForKey:@"width"] floatValue]];
    }
    for (NSNumber *separatorLineTypeNum in self.separatorLineTypes) {
        switch ([separatorLineTypeNum integerValue]) {
            case SeparatorLineTypeNone: {
                break;
            }
                
            case SeparatorLineTypeWideTop: {
                [DrawUtil drawLinePointArr:@[kLinePointSet(0, 4, self.width, 4)] LineColor:SeparatorWideLineColor LineWidth:8];
                [DrawUtil drawLinePointArr:@[kLinePointSet(0, 0.5, self.width, 0.5),kLinePointSet(0, 7.5, self.width, 7.5)] LineColor:self.separatorLineColor];
                break;
            }
                
            case SeparatorLineTypeWide: {
                [DrawUtil drawLinePointArr:@[kLinePointSet(0, self.height-4, self.width, self.height-4)] LineColor:SeparatorWideLineColor LineWidth:8];
                [DrawUtil drawLinePointArr:@[kLinePointSet(0, self.height-7.5, self.width, self.height-7.5),kLinePointSet(0, self.height-0.5, self.width, self.height-0.5)] LineColor:self.separatorLineColor];
                break;
            }
                
            case SeparatorLineTypeTop: {
                NSArray *pointsArray = @[kLinePointSet(0, KLineWidth, kSCREEN_WIDTH, KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeBottom: {
                NSArray *pointsArray = @[kLinePointSet(0, self.height - KLineWidth, kSCREEN_WIDTH, self.height - KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeTopAndBottom: {
                NSArray *pointsArray = @[kLinePointSet(0, KLineWidth, kSCREEN_WIDTH, KLineWidth),
                                         kLinePointSet(0, self.height - KLineWidth, kSCREEN_WIDTH, self.height - KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeCenterShortTop: {
                NSArray *pointsArray = @[kLinePointSet(self.space, KLineWidth, kSCREEN_WIDTH - self.space, KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeCenterShortBottom: {
                NSArray *pointsArray = @[kLinePointSet(self.space, self.height - KLineWidth, kSCREEN_WIDTH - self.space, self.height - KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeCenterShortTopAndBottom: {
                NSArray *pointsArray = @[kLinePointSet(self.space, KLineWidth, kSCREEN_WIDTH - self.space, KLineWidth),
                                         kLinePointSet(self.space, self.height - KLineWidth, kSCREEN_WIDTH - self.space, self.height - KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeLeftShortTop: {
                NSArray *pointsArray = @[kLinePointSet(0, KLineWidth, kSCREEN_WIDTH - self.space, KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeLeftShortBottom: {
                NSArray *pointsArray = @[kLinePointSet(0, self.height - KLineWidth, kSCREEN_WIDTH - self.space, self.height - KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeLeftShortTopAndBottom: {
                NSArray *pointsArray = @[kLinePointSet(0, KLineWidth, kSCREEN_WIDTH - self.space, KLineWidth),
                                         kLinePointSet(0, self.height - KLineWidth, kSCREEN_WIDTH - self.space, self.height - KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeRightShortTop: {
                NSArray *pointsArray = @[kLinePointSet(self.space, KLineWidth, kSCREEN_WIDTH, KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeRightShortBottom: {
                NSArray *pointsArray = @[kLinePointSet(self.space, self.height - KLineWidth, kSCREEN_WIDTH, self.height - KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            case SeparatorLineTypeRightShortTopAndBottom: {
                NSArray *pointsArray = @[kLinePointSet(self.space, KLineWidth, kSCREEN_WIDTH, KLineWidth),
                                         kLinePointSet(self.space, self.height - KLineWidth, kSCREEN_WIDTH, self.height - KLineWidth)];
                [DrawUtil drawLinePointArr:pointsArray LineColor:self.separatorLineColor LineWidth:KLineWidth];
                break;
            }
                
            default:
                break;
        }
    }
}

@end
