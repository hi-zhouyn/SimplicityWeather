//
//  ManyWeatherTableViewCell.h
//  MyWeather
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KManyWeatherTableViewCellID @"ManyWeatherTableViewCell"
#define KManyWeatherTableViewCellHeight 375 * kAUTOLAYOUTSCALE
@interface ManyWeatherTableViewCell : BaseTableViewCell
@property (nonatomic,strong) UICollectionView *collectionView;
@end
