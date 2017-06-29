//
//  ModelWXToken.m
//  JuCaiBang
//
//  Created by 陈全 on 15/9/21.
//
//

#import "ModelWXToken.h"

#define USER_DEFAULTS_KEY_WXTOKEN @"wxktoken"

@implementation ModelWXToken

+(ModelWXToken *) shareWXToken{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString *json=   [accountDefaults objectForKey:USER_DEFAULTS_KEY_WXTOKEN];
    ModelWXToken *user= [[ModelWXToken alloc ]initWithString:json error:nil];
    
    if(user==nil){
        user=[[ModelWXToken alloc]init];
    }
    return user;
}
//存user
-(void)save{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[self toJSONString]);
    [accountDefaults setObject:[self toJSONString] forKey:USER_DEFAULTS_KEY_WXTOKEN];
    [accountDefaults synchronize];
}
//删user
+(void)clear{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults removeObjectForKey:USER_DEFAULTS_KEY_WXTOKEN];
    [accountDefaults synchronize];
}

@end
