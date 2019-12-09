//
//  CityNameCollectionViewCell.h
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/17.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KCityNameCollectionViewCellID      @"CityNameCollectionViewCell"
#define KCityNameCollectionViewCellHeight  40

@interface CityNameCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) NSString *title;
@end
