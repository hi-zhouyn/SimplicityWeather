//
//  ScrollView.h
//  WaterDeliver
//
//  Created by Lovetong on 15/7/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TimerInterval 3.0f

#define PageControlHeight 20 * kAUTOLAYOUTSCALE

typedef NS_ENUM(NSInteger, PageControlState){
    PageControlStateNone,
    PageControlStateNormal
};

typedef NS_ENUM(NSInteger, TimerActionState){
    TimerActionStateNone,
    TimerActionStateNormal
};

typedef NS_ENUM(NSInteger, TapActionType) {
    TapActionTypeDetail,
    TapActionTypeScale
};

@interface ScrollView : UIView

@property (assign, nonatomic) PageControlState pageControlState;
@property (assign, nonatomic) TimerActionState timerActionState;
@property (assign, nonatomic) TapActionType tapActionType;

- (instancetype)initWithFrame:(CGRect)frame timerActionState:(TimerActionState)timerActionState pageControlState:(PageControlState)pageControlState;

- (void)setScrollViewWithImageModelArray:(NSArray *)imageModelArray;

- (void)tapImageCallBackToSendModel:(void(^)(id obj))tapImageCallBackToSendModel;

- (void)setContentOffsetWithIndex:(NSInteger)index;

@end
