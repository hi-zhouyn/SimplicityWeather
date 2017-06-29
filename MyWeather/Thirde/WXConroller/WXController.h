//
//  WXController.h
//  JuCaiBang
//
//  Created by kings on 15/9/22.
//
//

//#import "WXApi.h"

#define JPUSHAppKey @"df7ace70fd80105fda7f8acf"//线上
//#define JPUSHAppKey @"be1d6fa61e32184f68d33406"

#define CHANNEL @"App Store"
#define APS_FOR_PRODUCTION 0

#define BaiDuApiKey @"9d352c2ec2226e0b51b98b498e81704c"
#define BaiDuMapKey @"0DRMykP4XrOtXzVaqnLRZxGAnOSwyxQW"

#define WXAppKey @"wxb0290782ab5b55b5"
#define WXAppSecret @"4f9abfe554a6f081fba8b9de028f1381"

#define qqAPPID @"1105023462"
#define qqAPPKEY @"wUUMIqqcGUEj81KB"
@interface WXController : NSObject/*<WXApiDelegate>*/
@property (nonatomic,strong)UIViewController *wxRootVc;

+ (WXController*)shareInstance;

- (void)wxLoginBackground;

@end
