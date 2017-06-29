//
//  ModelWXToken.h
//  JuCaiBang
//
//  Created by 陈全 on 15/9/21.
//
//

#import "BaseModel.h"

@interface ModelWXToken : BaseModel
//"access_token" = "OezXcEiiBSKSxW0eoylIeJEwyug85PjJceWOdH_FKl0RuTkcai3Xr3gYfQ7EKd4sJifRfFZ4dj6ni-23eGBPTfrDhT69tXxpITFpEOBlyhgSJgARXevQ7HXsjJ5X_MmUpZ9CTjD6DkJ_rootL6x3_Q";
//"expires_in" = 7200;
//openid = omrYiwv3GTgasYR6StuhbBJMwqAA;
//"refresh_token" = "OezXcEiiBSKSxW0eoylIeJEwyug85PjJceWOdH_FKl0RuTkcai3Xr3gYfQ7EKd4sQXRYoU7yRIcA4uxzdVGmatelsoAQD4OmV1Lv9R5-oSlKXO_-2XUtAOhtTri9MNoFHf4yqP4mJh4-oUvbo0Waww";
//scope = "snsapi_userinfo";
//unionid = "oy0exvynS8zju0_2gQ3SOYHeoP4k";

@property (strong,nonatomic)NSString *access_token;
@property (strong,nonatomic)NSString *expires_in;
@property (strong,nonatomic)NSString *openid;
@property (strong,nonatomic)NSString *refresh_token;
@property (strong,nonatomic)NSString *scope;
@property (strong,nonatomic)NSString *unionid;

+(ModelWXToken *) shareWXToken;

-(void)save;

+(void)clear;

@end
