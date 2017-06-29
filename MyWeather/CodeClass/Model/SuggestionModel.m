//
//  SuggestionModel.m
//  MyWeather
//
//  Created by admin on 16/8/17.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "SuggestionModel.h"

@implementation SuggestionModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"comf"])
    {
        _comfBrf = value[@"brf"];
        _comfTxt = value[@"txt"];
    }
    if ([key isEqualToString:@"cw"])
    {
        _cwBrf = value[@"brf"];
        _cwTxt = value[@"txt"];
    }
    if ([key isEqualToString:@"drsg"])
    {
        _drsgBrf = value[@"brf"];
        _drsgTxt = value[@"txt"];
    }
    if ([key isEqualToString:@"flu"])
    {
        _fluBrf = value[@"brf"];
        _fluTxt = value[@"txt"];
    }
    if ([key isEqualToString:@"sport"])
    {
        _sportBrf = value[@"brf"];
        _sportTxt = value[@"txt"];
    }
    if ([key isEqualToString:@"trav"])
    {
        _travBrf = value[@"brf"];
        _travTxt = value[@"txt"];
    }
    if ([key isEqualToString:@"uv"]){
        _uvBrf = value[@"brf"];
        _uvTxt = value[@"txt"];
    }
    
}
@end
