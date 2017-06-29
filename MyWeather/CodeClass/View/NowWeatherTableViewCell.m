//
//  NowWeatherTableViewCell.m
//  MyWeather
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "NowWeatherTableViewCell.h"

@implementation NowWeatherTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
    [self autoLayoutAllSubViewsWithoutFont];
    
    
    
    
}

-(UICollectionView *)collectionView
{
    if (_collectionView == nil ) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
//        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowlayout.itemSize = CGSizeMake(30 * kAUTOLAYOUTSCALE, 90 * kAUTOLAYOUTSCALE);
        flowlayout.minimumInteritemSpacing = 15 * kAUTOLAYOUTSCALE;
//        flowlayout.minimumLineSpacing = 15 * kAUTOLAYOUTSCALE;
        flowlayout.sectionInset = UIEdgeInsetsMake(15 * kAUTOLAYOUTSCALE , 15 * kAUTOLAYOUTSCALE, 10 * kAUTOLAYOUTSCALE, 15 * kAUTOLAYOUTSCALE);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowlayout ];
        [ _collectionView  registerNib:[UINib nibWithNibName:KNowWeatherCollectionViewCellID bundle:nil] forCellWithReuseIdentifier:KNowWeatherCollectionViewCellID];
        // 禁止滑动
//        _collectionView.scrollEnabled = NO;
        
        _collectionView.backgroundColor = kColorClear;
        [self.contentView addSubview:_collectionView];

    }
    return _collectionView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
