//
//  DayWeatherContentTableViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "DayWeatherContentTableViewCell.h"
#import "DayWeatherCollectionViewCell.h"
#import "TemperatureLineView.h"

@interface DayWeatherContentTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TemperatureLineView *lineView;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@end

@implementation DayWeatherContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setborderWithBorderColor:kColorBg Width:0.6];
        
        self.backgroundColor = KColorWhite;
        [self collectionView];
        [self bgScrollView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOffset = CGSizeMake(1, -1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 4.0;
    self.layer.shouldRasterize =  YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    CGPathRef path = [UIBezierPath bezierPathWithRect:CGRectMake(0,
                                                    self.bounds.size.height,
                                                    [UIScreen mainScreen].bounds.size.width,2)].CGPath;
    
    [self.layer setShadowPath:path];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.bgScrollView) {
        self.collectionView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }else if (scrollView == self.collectionView){
        self.bgScrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 14;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DayWeatherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([DayWeatherCollectionViewCell class])] forIndexPath:indexPath];
    
    return cell;
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0.f;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake(KWidth, KDayWeatherCollectionViewCellHeight);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.contentView addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = KColorWhite;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:[NSString stringWithUTF8String:object_getClassName([DayWeatherCollectionViewCell class])] bundle:nil] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([DayWeatherCollectionViewCell class])]];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(KDayWeatherCollectionViewCellHeight);
        }];
    }
    return _collectionView;
}

- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), KSCREEN_WIDTH, 50)];
        _bgScrollView.delegate = self;
        _bgScrollView.bounces = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.contentSize = CGSizeMake(KWidth * 14, _bgScrollView.frame.size.height);
        [self.contentView addSubview:_bgScrollView];
        [_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(self.collectionView.mas_bottom);
        }];
        self.lineView = [[TemperatureLineView alloc] initWithFrame:CGRectMake(0, 0, _bgScrollView.contentSize.width, _bgScrollView.frame.size.height)];
        [_bgScrollView addSubview:self.lineView];
//        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.top.bottom.equalTo(self.lineView.superview);
//            make.width.mas_equalTo(1800);
//        }];
    }
    return _bgScrollView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
