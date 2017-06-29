//
//  NowWeatherTableViewCell.h
//  MyWeather
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KNowWeatherTableViewCellID @"NowWeatherTableViewCell"
#define KNowWeatherTableViewCellHeight 120 * kAUTOLAYOUTSCALE
@interface NowWeatherTableViewCell : BaseTableViewCell  
@property (nonatomic,strong) UICollectionView *collectionView;
@end
