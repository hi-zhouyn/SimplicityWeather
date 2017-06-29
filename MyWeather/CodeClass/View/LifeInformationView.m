//
//  LifeInformationView.m
//  MyWeather
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "LifeInformationView.h"

@implementation LifeInformationView

-(void)awakeFromNib
{
    [super awakeFromNib ];
    [self autoLayoutAllSubViewsWithoutFont];
    
    [self setCircleWithRadius:12 * kAUTOLAYOUTSCALE];
    
}
-(void)updateUI:(SuggestionModel *)model Index:(NSInteger)index
{
    switch (index) {
        case 0:
            
            self.informationNameLabel.text = @"运动指数";
            self.informationLabel.text = model.comfBrf;
            self.informationDetailsLabel.text = model.comfTxt;
            break;
        case 1:
            self.informationDetailsLabel.text = model.cwTxt;
            self.informationNameLabel.text = @"洗车指数";
            self.informationLabel.text = model.cwBrf;
            break;
        case 2:
            self.informationDetailsLabel.text = model.uvTxt;
            self.informationNameLabel.text = @"紫外线指数";
            self.informationLabel.text = model.uvBrf;
            break;
        case 3:
            self.informationDetailsLabel.text = model.travTxt;
            self.informationNameLabel.text = @"旅游指数";
            self.informationLabel.text = model.travBrf;
            break;
        case 4:
            self.informationDetailsLabel.text = model.uvTxt;
            self.informationNameLabel.text = @"防晒指数";
            self.informationLabel.text = model.uvBrf;
            break;
        case 5:
            self.informationDetailsLabel.text = model.fluTxt;
            self.informationNameLabel.text = @"感冒指数";
            self.informationLabel.text = model.fluBrf;
            break;
        case 6:
            self.informationDetailsLabel.text = model.drsgTxt;
            self.informationNameLabel.text = @"穿衣指数";
            self.informationLabel.text = model.drsgBrf;
            break;
        case 7:
            self.informationDetailsLabel.text = model.comfTxt;
            self.informationNameLabel.text = @"舒适指数";
            self.informationLabel.text = model.comfBrf;
            break;
        default:
            break;
    }
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
