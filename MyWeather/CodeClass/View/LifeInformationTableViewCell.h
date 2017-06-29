//
//  LifeInformationTableViewCell.h
//  MyWeather
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KLifeInformationTableViewCellID @"LifeInformationTableViewCell"
#define KLifeInformationTableViewCellHeight 300 * kAUTOLAYOUTSCALE
@interface LifeInformationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsShowLabel;
@property (nonatomic,strong) UICollectionView *collectionView;
@end
