//
//  ManyWeaherCollectionViewCell.h
//  MyWeather
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KManyWeaherCollectionViewCellID @"ManyWeaherCollectionViewCell"
@interface ManyWeaherCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dayImageView;
@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nightImageView;
@property (weak, nonatomic) IBOutlet UILabel *nightLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *tmpNightLabel;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,assign) NSInteger index;
-(void) updateUI:(NSMutableArray *)Arr Index : (NSInteger) index;
@end
