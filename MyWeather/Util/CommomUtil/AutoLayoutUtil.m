//
//  AutoLayoutUtil.m
//  JuCaiBang
//
//  Created by 陈全 on 15/8/3.
//
//

#import "AutoLayoutUtil.h"

@implementation AutoLayoutUtil

+ (void)autoLayoutWith:(NSArray *)allSubView
{
    [allSubView enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
//        if (iPhone4 || iPhone5) {
//            obj.frame = CGRectMake(obj.frame.origin.x*kAUTOLAYOUTSCALE, obj.frame.origin.y*kAUTOLAYOUTSCALE, obj.frame.size.width*kAUTOLAYOUTSCALE, obj.frame.size.height);
//        }else
//        {
            obj.frame = CGRectMake(obj.frame.origin.x*kAUTOLAYOUTSCALE, obj.frame.origin.y*kAUTOLAYOUTSCALE, obj.frame.size.width*kAUTOLAYOUTSCALE, obj.frame.size.height*kAUTOLAYOUTSCALE);

//        }
        
        if ([obj isKindOfClass:[UILabel class]]||[obj isMemberOfClass:[UITextField class]]||[obj isMemberOfClass:[UITextView class]]) {
            UILabel *label = (UILabel *)obj;
            CGFloat size = label.font.pointSize;
            if (iPhone5 || iPhone4) {
                
                label.font = kBaseSetFontOfSize_iPhone5(label.font.fontName, size);
            }
//            else if (iPhone6Plus)
//            {
//                label.font = kBaseSetFontOfSize_iPhone6Plus(label.font.fontName, size);
//            }else
//            {
//                label.font = kBaseSetFontOfSize(label.font.fontName, size);
//            }
            else
            {
                label.font = kBaseSetFontOfSize(label.font.fontName, size);
            }

        }
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)obj;
            UILabel *label = btn.titleLabel;
            CGFloat size = label.font.pointSize;
            if (iPhone5 || iPhone4) {
                
                label.font = kBaseSetFontOfSize_iPhone5(label.font.fontName, size);
            }
//            else if (iPhone6Plus)
//            {
//                label.font = kBaseSetFontOfSize_iPhone6Plus(label.font.fontName, size);
//            }else
//            {
//                label.font = kBaseSetFontOfSize(label.font.fontName, size);
//            }
            else
            {
                label.font = kBaseSetFontOfSize(label.font.fontName, size);
            }

        }
    }];
}

//
//+ (void)autoLayoutNoFontWith:(NSArray *)allSubView
//{
//    [allSubView enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
//      obj.frame = CGRectMake(obj.frame.origin.x*kAUTOLAYOUTSCALE, obj.frame.origin.y*kAUTOLAYOUTSCALE, obj.frame.size.width*kAUTOLAYOUTSCALE, obj.frame.size.height*kAUTOLAYOUTSCALE);
//        if ([obj isKindOfClass:[UILabel class]]||[obj isMemberOfClass:[UITextField class]]||[obj isMemberOfClass:[UITextView class]]) {
//            UILabel *label = (UILabel *)obj;
//            CGFloat size = label.font.pointSize;
//            label.font = kBaseSetFontOfSize(label.font.fontName, size);
//        }
//        if ([obj isKindOfClass:[UIButton class]]) {
//            UIButton *btn = (UIButton*)obj;
//            UILabel *label = btn.titleLabel;
//            CGFloat size = label.font.pointSize;
//            label.font = kBaseSetFontOfSize(label.font.fontName, size);
//        }
//    }];  
//}

@end
