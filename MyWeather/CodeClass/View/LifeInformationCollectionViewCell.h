//
//  LifeInformationCollectionViewCell.h
//  MyWeather
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KLifeInformationCollectionViewCellID @"LifeInformationCollectionViewCell"
@interface LifeInformationCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *informationImage;
@property (weak, nonatomic) IBOutlet UILabel *informationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;

-(void) updateUI:(SuggestionModel *) model Index:(NSInteger)index ;
@end
