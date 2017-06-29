//
//  LifeInformationTableViewCell.m
//  MyWeather
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "LifeInformationTableViewCell.h"

@implementation LifeInformationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self autoLayoutAllSubViewsWithoutFont];
   
}

-(UICollectionView *)collectionView
{
    if (_collectionView == NULL) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(75 * kAUTOLAYOUTSCALE, 100 * kAUTOLAYOUTSCALE);
        flowLayout.minimumLineSpacing = 15 * kAUTOLAYOUTSCALE;
        
        flowLayout.sectionInset = UIEdgeInsetsMake(20 * kAUTOLAYOUTSCALE, 15 * kAUTOLAYOUTSCALE, 15 * kAUTOLAYOUTSCALE, 15 * kAUTOLAYOUTSCALE);
        _collectionView = [[UICollectionView  alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        _collectionView.scrollEnabled = NO;
        [_collectionView registerNib:[UINib nibWithNibName:KLifeInformationCollectionViewCellID bundle:nil] forCellWithReuseIdentifier:KLifeInformationCollectionViewCellID ];
        _collectionView.backgroundColor = kColorClear;
        [self.contentView addSubview:_collectionView ];
        
    }
    return _collectionView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
