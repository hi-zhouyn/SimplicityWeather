//
//  ActionSheetShow.h
//  KBS
//
//  Created by admin on 16/3/23.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "BaseViewFromXib.h"

@class ActionSheetShow;
@protocol ActionSheetShowDelegate <NSObject>

-(void) ActionSheetShow : (ActionSheetShow *) actionSheetShow didSelectAtIndex : (NSInteger )index;

@end

@interface ActionSheetShow : BaseViewFromXib

@property (nonatomic,strong) NSMutableArray *buttonsArr;
@property (nonatomic,strong) NSArray *titleArr;


/* 初始化 坐标 大小 标题数组
 *
 
 */
-(instancetype) initWithFrame:(CGRect)frame delegate : (id<ActionSheetShowDelegate>)delegate titles : (NSArray *) titlesArr;
//-(void) makeBaseUIWithButtonShow;
/**
 设置tag
 */
//-(void) setTags:(NSArray *)tags;
@end
