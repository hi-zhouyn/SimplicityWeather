//
//  SuggestionModel.h
//  MyWeather
//
//  Created by admin on 16/8/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "BaseModel.h"

@interface SuggestionModel : BaseModel
@property (nonatomic,strong) NSString *comfBrf;
@property (nonatomic,strong) NSString *comfTxt;
@property (nonatomic,strong) NSString *cwBrf;
@property (nonatomic,strong) NSString *cwTxt;
@property (nonatomic,strong) NSString *drsgBrf;
@property (nonatomic,strong) NSString *drsgTxt;
@property (nonatomic,strong) NSString *fluBrf;
@property (nonatomic,strong) NSString *fluTxt;
@property (nonatomic,strong) NSString *sportBrf;
@property (nonatomic,strong) NSString *sportTxt;
@property (nonatomic,strong) NSString *travBrf;
@property (nonatomic,strong) NSString *travTxt;
@property (nonatomic,strong) NSString *uvBrf;
@property (nonatomic,strong) NSString *uvTxt;
@end
