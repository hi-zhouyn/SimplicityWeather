//
//  ScrollView.m
//  WaterDeliver
//
//  Created by Lovetong on 15/7/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ScrollView.h"
#import "ADImageView.h"

@interface ScrollView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (assign, nonatomic) NSInteger page;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *scrollArray;
@property (nonatomic, copy) void (^tapImageCallBackToSendModel)(id model);

@end

@implementation ScrollView

- (instancetype)initWithFrame:(CGRect)frame timerActionState:(TimerActionState)timerActionState pageControlState:(PageControlState)pageControlState
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImageView];
        [self addSubview:self.scrollView];
        [self setPageControlState:pageControlState];
        [self setTimerActionState:timerActionState];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setPage:1];
        if (self.pageControlState == PageControlStateNormal) {
            [self addSubview:self.pageControl];
            [self.pageControl setHidden:YES];
        }
    }
    return self;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_bgImageView setUserInteractionEnabled:YES];
        [_bgImageView setImage:[UIImage imageNamed:@"banner"]];
    }
    return _bgImageView;
}

- (NSMutableArray *)scrollArray {
    if (!_scrollArray) {
        _scrollArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _scrollArray;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView setPagingEnabled:YES];
        [_scrollView setDelegate:self];
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - PageControlHeight, self.width, PageControlHeight)];
        [_pageControl setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0]];
        _pageControl.currentPageIndicatorTintColor= [UIColor colorWithRed:66/255.0 green:172/255.0 blue:212/255.0 alpha:1];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:66/255.0 green:172/255.0 blue:212/255.0 alpha:0.3];
        [_pageControl setCurrentPage:1];
    }
    return _pageControl;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:TimerInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)setScrollViewWithImageModelArray:(NSArray *)imageModelArray
{
    if (imageModelArray.count) {
        if (self.scrollArray.count) {
            [self.scrollArray removeAllObjects];
        }
        [self.scrollArray addObjectsFromArray:imageModelArray];
        if (imageModelArray.count == 1) {
            [self.pageControl setHidden:YES];
        } else {
            [self.pageControl setHidden:NO];
            [self.pageControl setNumberOfPages:imageModelArray.count];
            [self.scrollArray insertObject:[self.scrollArray lastObject] atIndex:0];
            [self.scrollArray addObject:[self.scrollArray objectAtIndex:1]];
        }
        [self.scrollView setContentSize:CGSizeMake(self.frame.size.width * self.scrollArray.count, 0)];
        for (int i = 0; i < self.scrollArray.count; i++) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adImageViewDidTapped:)];
            ADImageView *imageView = [[ADImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
            imageView.modelAdv = [self.scrollArray objectAtIndex:i];
            [imageView addGestureRecognizer:tapGesture];
            [imageView cs_setImageWithURLString:self.scrollArray[i] placeholderImage:nil];
            [_scrollView addSubview:imageView];
        }
        if (self.timerActionState == TimerActionStateNormal && imageModelArray.count > 1) {
            [self timer];
        }
    }else{
        self.pageControl.hidden = YES;
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
        [self.scrollView setContentSize:CGSizeMake(self.frame.size.width, 0)];
        
        ADImageView *imageView = [[ADImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
        imageView.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.scrollView addSubview:imageView];
    }
}

- (void)tapImageCallBackToSendModel:(void(^)(id obj))tapImageCallBackToSendModel {
    self.tapImageCallBackToSendModel = tapImageCallBackToSendModel;
}

- (void)setContentOffsetWithIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width * index, 0)];
}

- (void)timerAction:(NSTimer *)timer
{
    _pageControl.currentPage = _page;
    _page = [_scrollView contentOffset].x / _scrollView.frame.size.width;
    _page++;
    [UIView animateWithDuration:0.5 animations:^{
        [_scrollView setContentOffset:CGPointMake(_page * _scrollView.frame.size.width, 0)];
    }];
    if (_page == _scrollView.contentSize.width / self.frame.size.width - 1) {
        _page = 1;
        [_pageControl setCurrentPage:0];
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_scrollView.contentOffset.x == [_scrollView contentSize].width - self.frame.size.width) {
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    } if (_scrollView.contentOffset.x == 0) {
        [_scrollView setContentOffset:CGPointMake([_scrollView contentSize].width - self.frame.size.width * 2, 0)];
    }
    [_pageControl setCurrentPage:_scrollView.contentOffset.x / self.frame.size.width - 1];
    _page = _pageControl.currentPage;
}

- (void)adImageViewDidTapped:(UITapGestureRecognizer *)tapGesture {
    if (self.tapImageCallBackToSendModel) {
        if (self.tapActionType == TapActionTypeDetail) {
            self.tapImageCallBackToSendModel([(ADImageView *)tapGesture.view modelAdv]);
        } else if (self.tapActionType == TapActionTypeScale) {
            NSInteger index = [self getIndex:[(ADImageView *)tapGesture.view modelAdv]];
            self.tapImageCallBackToSendModel(@(index));
        }
    }
}

- (NSInteger)getIndex:(id)model {
    NSInteger index = 0;
    for (int i = 0; i < self.scrollArray.count; i++) {
        if ([self.scrollArray[i] isEqual:model]) {
            index = i;
            break;
        }
    }
    return index;
}

- (void)dealloc {
    @autoreleasepool {
        [self.timer invalidate];
    }
}

@end
