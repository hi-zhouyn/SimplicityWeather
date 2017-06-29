//
//  ManyWeatherTableViewCell.m
//  MyWeather
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "ManyWeatherTableViewCell.h"

@implementation ManyWeatherTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
    [self autoLayoutAllSubViewsWithoutFont];
    
}

-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(52 * kAUTOLAYOUTSCALE, 370 * kAUTOLAYOUTSCALE);
        flowLayout.minimumInteritemSpacing = 0  * kAUTOLAYOUTSCALE;
        flowLayout.sectionInset = UIEdgeInsetsMake(0 * kAUTOLAYOUTSCALE, 5.5 * kAUTOLAYOUTSCALE, 0 * kAUTOLAYOUTSCALE, 5.5 * kAUTOLAYOUTSCALE);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        [_collectionView registerNib:[UINib nibWithNibName:KManyWeaherCollectionViewCellID bundle:nil] forCellWithReuseIdentifier:KManyWeaherCollectionViewCellID       ];
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
