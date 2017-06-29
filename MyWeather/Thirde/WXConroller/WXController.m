//
//  WXController.m
//  JuCaiBang
//
//  Created by kings on 15/9/22.
//
//

#import "WXController.h"

//#import "WXLoginViewController.h"
//#import "RegisteredViewController.h"


@implementation WXController
{
    BaseModel *modelWX;
    BOOL isUpdate;
}


+ (WXController*)shareInstance
{
    static WXController* wxc = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        wxc = [[[self class] alloc] init];
    });
    
    return wxc;
}
/*
- (void)wxLoginBackground
{
    [self refreshWXToken];
    isUpdate = YES;
}

#pragma mark -- WXApiDelegate

-(void) onReq:(BaseReq*)req
{

}

-(void) onResp:(BaseResp*)resp
{
    isUpdate = NO; 
    if([resp isKindOfClass:[SendAuthResp class]])
    {
        //微信登录
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        if (temp.errCode==-4) {

            return;
        }
        if (temp.errCode == -2) {
            return;
        }
        
        [self getWXToken:temp];

    }
}

#pragma mark -- 获取用户授权，getToken
- (void)getWXToken:(SendAuthResp *)temp
{
    [[NetWorkUtil getManager] GET:@"https://api.weixin.qq.com/sns/oauth2/access_token" parameters:@{@"appid":WXAppKey,@"code":temp.code,@"grant_type":@"authorization_code",@"secret":WXAppSecret} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取用户授权:%@",responseObject);
        // 保存用户信息
        ModelWXToken *model = [ModelWXToken objectFromJSON:responseObject];
        [model save];
        
        [self checkOutAccessToken:model];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -- 根据refresh_token，刷新Token
- (void)refreshWXToken
{
    [[NetWorkUtil getManager] GET:@"https://api.weixin.qq.com/sns/oauth2/refresh_token" parameters:@{@"appid":WXAppKey,@"grant_type":@"refresh_token",@"refresh_token":[[ModelWXToken shareWXToken] refresh_token]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
#warning 失效问题
        NSLog(@"根据refresh_token，刷新Token:%@",responseObject);
        ModelWXToken *model = [ModelWXToken objectFromJSON:responseObject];
        [model save];
        
        [self checkOutAccessToken:model];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -- 校验 access_token
- (void)checkOutAccessToken:(ModelWXToken *)model
{
    [[NetWorkUtil getManager] GET:@"https://api.weixin.qq.com/sns/auth" parameters:@{@"access_token":model.access_token,@"openid":model.openid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![[responseObject objectForKey:@"errmsg"] isEqualToString:@"ok"]) {
            return ;
        }
        [self getUserInfoFromWX:model];
         NSLog(@"校验 access_token:%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"waaaaawawawawawawawa");
    }];
    
}

#pragma mark -- 获取用户信息
- (void)getUserInfoFromWX:(ModelWXToken *)model
{
    //获取用户信息?access_token=ACCESS_TOKEN&openid=OPENID
    
    [[NetWorkUtil getManager] GET:@"https://api.weixin.qq.com/sns/userinfo" parameters:@{@"access_token":model.access_token,@"openid":model.openid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取用户信息:%@",responseObject);
        ModelWXUser *uers = [ModelWXUser objectFromJSON:responseObject];
        [self wxLogin:uers];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取用户信息失败");
    }];
}

#pragma mark -- 微信登录
- (void)wxLogin:(ModelWXUser *)uers
{
    [SVPHUDUtil show];
     //微信登录成功 进行上传用户数据调用
    if ([uers.sex isEqualToString:@"2"]) {
        uers.sex = @"0";
    }
    NSDictionary *dict = @{@"type":@"wechat",@"openId":uers.openid,@"nickname":uers.nickname,@"avatar":uers.headimgurl,@"sex":uers.sex};
    [NetWorkUtil postPath:API_POST_thirdParty parameter:dict sessionID:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"上传成功:%@",responseObject);
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"index"] != NULL && [[[NSUserDefaults standardUserDefaults] objectForKey:@"index"] integerValue] > 0) {
            [[NSUserDefaults standardUserDefaults] setInteger:0  forKey:@"index"];
        }
        [SVPHUDUtil hiden];
        NSLog(@"sessionID:%@",responseObject[@"user"][@"sessionID"]);
        [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"isLogin"];
       [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"user"][@"sessionID"] forKey:@"sessionID"];
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"user"][@"account"][@"_id"] forKey:@"accountID"];
         [[NSUserDefaults  standardUserDefaults] setObject:responseObject[@"user"][@"account"][@"basic"][@"name"] forKey:@"accountName"];
        //登录未添加宝贝
        [AppDelegateTableBar showMain];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败");
        [SVPHUDUtil hiden];
         kprogressHudOnlyStr(@"授权失败");
    }];
 
}


#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self setWXLogin];
    }else{
        [self setWXRegist];
    }
}

- (void)setWXLogin
{
//    WXLoginViewController *vc = [[WXLoginViewController alloc]init];
//    vc.weiXinID = modelWX.msg;
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.wxRootVc.navigationController pushViewController:vc animated:YES];
}

- (void)setWXRegist
{
//    RegisteredViewController *vc = [[RegisteredViewController alloc]init];
//    vc.weiXinID = modelWX.msg;
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.wxRootVc.navigationController pushViewController:vc animated:YES];
}
*/

@end
