//
//  ManyWeaherCollectionViewCell.m
//  MyWeather
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "ManyWeaherCollectionViewCell.h"

@implementation ManyWeaherCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self autoLayoutAllSubViewsWithoutFont];
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    DailyForecastModel *model = _arr[_index];
    DailyForecastModel *model1 = [[DailyForecastModel alloc] init];
    DailyForecastModel *model2 = [[DailyForecastModel alloc] init];
    if (_index + 1 < _arr.count) {
        model1 = _arr[_index+1];
    }
    if (_index  >0) {
        model2 = _arr[_index - 1];
    }
    NSArray *minArr = [_arr sortedArrayUsingComparator:^NSComparisonResult(DailyForecastModel * obj1, DailyForecastModel * obj2) {
        if (obj1.min > obj2.min) {
            return NSOrderedDescending;
        }else if (obj1.min == obj2.min)
        {
            return NSOrderedSame;
        }else
        {
            return NSOrderedAscending;
        }
    }];
    DailyForecastModel *minModel = minArr[0];
    //    NSLog(@"arr:%@",minModel.min);
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    if (_index < _arr.count - 1) {
        [linePath moveToPoint:CGPointMake(self.width/2, 230 * kAUTOLAYOUTSCALE  - ([model.max integerValue] - [minModel.min integerValue]) * 8)];
        [linePath addLineToPoint:CGPointMake(self.width , 230 * kAUTOLAYOUTSCALE  - (([model1.max integerValue] - [model.max integerValue]) / 2 + [model.max integerValue] - [minModel.min integerValue]) * 8)];
        
        [linePath moveToPoint:CGPointMake(self.width/2, 230 * kAUTOLAYOUTSCALE  - ([model.min integerValue] - [minModel.min integerValue]) * 5)];
        [linePath addLineToPoint:CGPointMake(self.width , 230 * kAUTOLAYOUTSCALE  - (([model1.min integerValue] - [model.min integerValue]) / 2 + [model.min integerValue] - [minModel.min integerValue]) * 5)];

    }
    if (_index > 0 ) {
        [linePath moveToPoint:CGPointMake(0,  230 * kAUTOLAYOUTSCALE  - (([model.max integerValue] - [model2.max integerValue] ) / 2 + [model2.max integerValue] - [minModel.min integerValue]) * 8)];
        [linePath addLineToPoint:CGPointMake(self.width / 2, 230 * kAUTOLAYOUTSCALE  - ([model.max integerValue] - [minModel.min integerValue]) * 8)];
        [linePath moveToPoint:CGPointMake(0,  230 * kAUTOLAYOUTSCALE  - (([model.min integerValue] - [model2.min integerValue] ) / 2 + [model2.min integerValue] - [minModel.min integerValue]) * 5)];
        [linePath addLineToPoint:CGPointMake(self.width / 2, 230 * kAUTOLAYOUTSCALE  - ([model.min integerValue] - [minModel.min integerValue]) * 5)];
    }
    [linePath setLineWidth:1];
    [kColorWhite setStroke];
    [linePath stroke];
    
    
    UIBezierPath *leastPath = [UIBezierPath bezierPath];
    [leastPath addArcWithCenter:CGPointMake(self.width/2, 230 * kAUTOLAYOUTSCALE  - ([model.max integerValue] - [minModel.min integerValue]) * 8) radius:3*kAUTOLAYOUTSCALE startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [leastPath addArcWithCenter:CGPointMake(self.width/2, 230 * kAUTOLAYOUTSCALE  - ([model.min integerValue] - [minModel.min integerValue]) * 5) radius:3*kAUTOLAYOUTSCALE startAngle:0 endAngle:2 * M_PI clockwise:YES];
    self.tmpNightLabel.frame = CGRectMake(5 * kAUTOLAYOUTSCALE, 230 * kAUTOLAYOUTSCALE  - ([model.min integerValue] - [minModel.min integerValue]) * 5 + 5 * kAUTOLAYOUTSCALE, 45 * kAUTOLAYOUTSCALE, 21 * kAUTOLAYOUTSCALE);
    self.tmpLabel.frame = CGRectMake(5 * kAUTOLAYOUTSCALE, 230 * kAUTOLAYOUTSCALE  - ([model.max integerValue] - [minModel.min integerValue]) * 8 - 25 * kAUTOLAYOUTSCALE, 45 * kAUTOLAYOUTSCALE, 21 * kAUTOLAYOUTSCALE);
    // 设置填充颜色
    [kColorBlack setFill];
    [leastPath fill];
}

-(void)updateUI:(NSMutableArray *)Arr Index:(NSInteger)index
{
    DailyForecastModel *model = Arr[index];
    self.nightLabel.text = model.txt_n;
    self.windLabel.text = [NSString stringWithFormat:@"%@\n%@级",model.sc,model.spd];
    self.tmpLabel.text = [NSString stringWithFormat:@"%@℃", model.max ];
    self.tmpNightLabel.text = [NSString stringWithFormat:@"%@℃",model.min];
    NSString *dateStr = [model.date substringWithRange:NSMakeRange(5, 5)];
    self.dateLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",[Common weekdayStringFromDate:[Common stringToDate:model.date]],dateStr,model.txt_d];
    NSString *file = [[NSBundle mainBundle] pathForResource:@"WeatherList" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
    NSString *nightfile = [[NSBundle mainBundle] pathForResource:@"nightWeatherList" ofType:@"plist"];
    NSDictionary *nightdict = [NSDictionary dictionaryWithContentsOfFile:nightfile];
    _nightImageView.image = [ UIImage imageNamed:[nightdict objectForKey:model.txt_n]];
    _dayImageView.image = [ UIImage imageNamed:[dict objectForKey:model.txt_d]];
    
    
}

@end
