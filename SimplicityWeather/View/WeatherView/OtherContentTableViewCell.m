//
//  OtherContentTableViewCell.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/8.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "OtherContentTableViewCell.h"
#import "OtherContentBaseCollectionViewCell.h"
#import "WindCollectionViewCell.h"
#import "SunCollectionViewCell.h"
#import "HumidityCollectionViewCell.h"
#import "AirCollectionViewCell.h"

@interface OtherContentTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *cellClassArr;
@end

@implementation OtherContentTableViewCell

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
    return self.cellClassArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OtherContentBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.cellClassArr[indexPath.row]) forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake(KSCREEN_WIDTH/2, KSCREEN_WIDTH/2);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        _collectionView.backgroundColor = KColorWhite;
        for (Class class in self.cellClassArr) {
            [_collectionView registerClass:class forCellWithReuseIdentifier:NSStringFromClass(class)];
        }
    }
    return _collectionView;
}

- (NSArray *)cellClassArr
{
    if (!_cellClassArr) {
        _cellClassArr = @[[WindCollectionViewCell class],
                          [HumidityCollectionViewCell class],
                          [SunCollectionViewCell class],
                          [AirCollectionViewCell class]];
    }
    return _cellClassArr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
