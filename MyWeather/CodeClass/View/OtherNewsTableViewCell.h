//
//  OtherNewsTableViewCell.h
//  MyWeather
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KOtherNewsTableViewCellID @"OtherNewsTableViewCell"
#define KOtherNewsTableViewCellHeight 300 * kAUTOLAYOUTSCALE
@interface OtherNewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *windForceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
-(void) updateUI:(NowModel *)nowModel  Daily:(DailyForecastModel *) dailyModel;
@end
