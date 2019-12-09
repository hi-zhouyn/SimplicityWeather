//
//  TopCityTableViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/17.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "TopCityTableViewCell.h"
#import "CityNameCollectionViewCell.h"

#define KLineSpacing  15

@interface TopCityTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TopCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self collectionView];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityNameCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCityNameCollectionViewCellID forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGFloat width = (KSCREEN_WIDTH - 15 * 3 - 40) / 3;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = KLineSpacing;
        flowLayout.minimumInteritemSpacing = KLineSpacing;
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 40);
        flowLayout.itemSize = CGSizeMake(width, KCityNameCollectionViewCellHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kColorBg;
        _collectionView.userInteractionEnabled = NO;
        [_collectionView registerClass:[CityNameCollectionViewCell class] forCellWithReuseIdentifier:KCityNameCollectionViewCellID];
        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _collectionView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
