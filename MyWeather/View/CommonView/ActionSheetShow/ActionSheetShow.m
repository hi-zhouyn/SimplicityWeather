//
//  ActionSheetShow.m
//  KBS
//
//  Created by admin on 16/3/23.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "ActionSheetShow.h"

@interface ActionSheetShow ()
{
    NSInteger _buttonCount;
    CGSize _size;
}

@property (nonatomic,assign) id<ActionSheetShowDelegate> delegate;
@property (nonatomic,strong) UIView *bgView;
@end
@implementation ActionSheetShow

// 初始化 委托代理 传入标题数组
-(instancetype) initWithFrame:(CGRect)frame delegate:(id<ActionSheetShowDelegate>)delegate titles:(NSArray *)titlesArr
{
    self = [super initWithFrame:frame];
    if (self) {
        _size = [UIScreen mainScreen].bounds.size;
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenActionSheet)];
        [self addGestureRecognizer:tap];
        self.titleArr = titlesArr;
        self.delegate = delegate;
        _buttonCount = titlesArr.count;
        self.buttonsArr = [NSMutableArray array];
        [self makeBaseUIWithButton:titlesArr];
        
    }
    return self;
}
// 初始化背景view 添加点击事件
-(void) makeBaseUIWithButton : (NSArray *) titles
{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, _size.height, _size.width, titles.count * 50 + 59  )];
    //    self.bgView.backgroundColor = [UIColor colorWithRed:0xe9/255.0 green:0xe9/255.0 blue:0xe9/255.0 alpha:1.0];
    self.bgView.backgroundColor = kColorBackgroundGray;
    [self addSubview:_bgView];
    
    CGFloat y = [self createByButtonWithTitle:@"取消" orign_Y:_bgView.frame.size.height - 50 Tag:-1 action:@selector(hiddenActionSheet)] - 59;
    y = 0;
    for (int i = 0; i < titles.count; i ++) {
        
        y = [self createByButtonWithTitle:titles[i] orign_Y:y Tag:i action:@selector(buttonDidSelected:)];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _bgView.frame;
        frame.origin.y  -= frame.size.height;
        _bgView.frame = frame;
        
    }];
    
    
}
// 创建button 做好布局 返回高
-(CGFloat) createByButtonWithTitle: (NSString *) title orign_Y : (CGFloat) y Tag : (NSInteger) tag action : (SEL) action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, y, _size.width, 50);
    btn.tag = tag;
    btn.backgroundColor = kColorWhite;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:btn];
    [self.buttonsArr addObject:btn];
    if (tag == -1) {
        return y-= tag == -1 ? 0 : 50.7;
    }else
    {
        return y+=  50.7;
    }
    //    return y-= tag == -1 ? 0 : 50.5;
    
}
// 代理事件
-(void) buttonDidSelected : (UIButton *) sender
{
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
    [self.delegate ActionSheetShow:self didSelectAtIndex:sender.tag];
    [self hiddenActionSheet];
    //    }
    
}
// 移除
-(void) hiddenActionSheet
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        CGRect frame = _bgView.frame;
        frame.origin.y += frame.size.height;
        _bgView.frame = frame;
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
    
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //        [self removeFromSuperview];
    //    });
}

@end
