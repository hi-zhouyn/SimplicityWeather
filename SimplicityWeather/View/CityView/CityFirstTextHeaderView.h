//
//  CityFirstTextHeaderView.h
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/18.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CityFirstTextHeaderViewMode) {
    CityFirstTextHeaderViewModeWhite,
    CityFirstTextHeaderViewModeGray,
};

@interface CityFirstTextHeaderView : UITableViewHeaderFooterView

@property (nonatomic, assign) CityFirstTextHeaderViewMode viewMode;
@property (nonatomic, copy) NSString *title;
@end
