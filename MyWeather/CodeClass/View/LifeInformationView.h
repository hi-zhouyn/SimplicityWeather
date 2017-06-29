//
//  LifeInformationView.h
//  MyWeather
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "BaseViewFromXib.h"

@interface LifeInformationView : BaseViewFromXib
@property (weak, nonatomic) IBOutlet UILabel *informationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationDetailsLabel;

-(void)updateUI:(SuggestionModel *)model Index:(NSInteger)index;
@end
