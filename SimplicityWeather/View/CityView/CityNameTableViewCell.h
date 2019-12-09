//
//  CityNameTableViewCell.h
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/17.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KCityNameTableViewCellID      @"CityNameTableViewCell"
#define KCityNameTableViewCellHeight  40

@interface CityNameTableViewCell : UITableViewCell
@property (nonatomic, copy) NSString *title;
@end
