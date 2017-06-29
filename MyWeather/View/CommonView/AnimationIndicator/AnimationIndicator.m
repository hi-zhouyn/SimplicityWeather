//
//  AnimationIndicator.m
//  SocialKids
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "AnimationIndicator.h"

@implementation AnimationIndicator

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.hidden = YES;
        if (_width < 30 || _height < 30) {
            _width = 80;
            _height = 80;
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        [self indicatorImageView];
        [self indicatorLabel];
    }
    return self;
}
-(void) AnimationIndicatorShow
{
    self.layer.hidden = NO;
     _indicatorImageView.animationDuration = 0.5;
    [_indicatorImageView startAnimating];
    _indicatorLabel.text = self.titleStr;
}

-(void) AnimationIndicatorHide
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [_indicatorImageView stopAnimating];
        self.layer.hidden = YES;
        self.alpha = 1;
        [self removeFromSuperview];
    }];
}
-(void) netWorkInterruotionOrNotSmoothTitle:(NSString *)title
{
    self.layer.hidden = NO;
    _indicatorImageView.image = [UIImage imageNamed:@"15.jpg"];
    _indicatorLabel.text = title;
}
-(void) tapAction : (UITapGestureRecognizer *) sender
{
//    self.tapAction();
}

-(UILabel * )indicatorLabel
{
    if (!_indicatorLabel) {
        _indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH - _width * 2 ) / 2, CGRectGetMaxY(_indicatorImageView.frame) , _width * 2, 30)];
        _indicatorLabel.backgroundColor = [UIColor clearColor];
        _indicatorLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_indicatorLabel];
    }
    return _indicatorLabel;
}
-(UIImageView *)indicatorImageView
{
    if (!_indicatorImageView) {
        
        _indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH - _width  ) / 2, (kSCREEN_HEIGHT / 2) - _width * 2  , _width, _height)];
        NSMutableArray *imageArr =[ NSMutableArray array];
        for (int i = 1 ; i < 7; i ++) {
            NSString *nameStr = [NSString stringWithFormat:@"%d.png",i];
            [imageArr addObject:[UIImage imageNamed:nameStr]];
        }
        _indicatorImageView.animationImages = imageArr;
        [self addSubview:_indicatorImageView];
    }
    
    return _indicatorImageView;
}
//    self.indicator = [[AnimationIndicator alloc] initWithFrame:self.view.frame];
//    self.indicator.titleStr = @"加载框测试";
//    [self.indicator netWorkInterruotionOrNotSmoothTitle:@"网络加载失败"];
//    [self.indicator AnimationIndicatorShow];
//    [self.view addSubview:self.indicator];
//    __weak typeof (self) weakSelf = self;
//    [self.indicator setTapAction:^{
//        NSLog(@"网络加载失败");
//        [UIView animateWithDuration:0.3 animations:^{
//            weakSelf.indicator.alpha = 0;
//        } completion:^(BOOL finished) {
//            weakSelf.indicator.hidden = YES;
//            [weakSelf.indicator removeFromSuperview];
//        }];
//    }];
//    kprogressHudOnlyStr(@"加载错误......");
//    kprogressHudGifAndTitle(@"加载错误。。。");

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
