//
//  LifeInformationCollectionViewCell.m
//  MyWeather
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "LifeInformationCollectionViewCell.h"

@implementation LifeInformationCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self autoLayoutAllSubViewsWithoutFont];
    
    
}
-(void)updateUI:(SuggestionModel *)model Index:(NSInteger)index
{
    switch (index) {
        case 0:
            self.informationImage.image = [UIImage imageNamed:@"yundong"];
            self.informationNameLabel.text = @"运动指数";
            self.informationLabel.text = model.comfBrf;
            break;
        case 1:
            self.informationImage.image = [UIImage imageNamed:@"xiche"];
            self.informationNameLabel.text = @"洗车指数";
            self.informationLabel.text = model.cwBrf;
            break;
        case 2:
            self.informationImage.image = [UIImage imageNamed:@"ziwaixian"];
            self.informationNameLabel.text = @"紫外线指数";
            self.informationLabel.text = model.uvBrf;
            break;
        case 3:
            self.informationImage.image = [UIImage imageNamed:@"guangjie"];
            self.informationNameLabel.text = @"旅游指数";
            self.informationLabel.text = model.travBrf;
            break;
        case 4:
            self.informationImage.image = [UIImage imageNamed:@"fangshai"];
            self.informationNameLabel.text = @"防晒指数";
            self.informationLabel.text = model.uvBrf;
            break;
        case 5:
            self.informationImage.image = [UIImage imageNamed:@"ganmao"];
            self.informationNameLabel.text = @"感冒指数";
            self.informationLabel.text = model.fluBrf;
            break;
        case 6:
            self.informationImage.image = [UIImage imageNamed:@"chuanyi"];
            self.informationNameLabel.text = @"穿衣指数";
            self.informationLabel.text = model.drsgBrf;
            break;
        case 7:
            self.informationImage.image = [UIImage imageNamed:@"shusi"];
            self.informationNameLabel.text = @"舒适指数";
            self.informationLabel.text = model.comfBrf;
            break;
        default:
            break;
    }
}
@end
