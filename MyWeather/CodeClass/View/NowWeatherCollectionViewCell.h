//
//  NowWeatherCollectionViewCell.h
//  MyWeather
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KNowWeatherCollectionViewCellID @"NowWeatherCollectionViewCell"
@interface NowWeatherCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *popLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;

-(void)updateUI:(NSMutableArray *)Arr Index:(NSInteger)index;
@end
