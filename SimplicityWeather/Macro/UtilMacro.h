//
//  UtilMacro.h
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/28.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#ifndef UtilMacro_h
#define UtilMacro_h

//========================================弱引用========================================

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define SS(strongSelf)  __strong __typeof(&*self)strongSelf = weakSelf
#define KWeakSelf __weak typeof(self) weakSelf = self;
#define KAppDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define KKeyWindow [UIApplication sharedApplication].keyWindow

#define recourcesPath [[NSBundle mainBundle] resourcePath]

//========================================获取设备大小========================================

#define iPhone4                                                                 \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                   \
? CGSizeEqualToSize(CGSizeMake(640, 960),                                       \
[[UIScreen mainScreen] currentMode].size)                                       \
: NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6                                                                 \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                   \
? CGSizeEqualToSize(CGSizeMake(750, 1334),                                      \
[[UIScreen mainScreen] currentMode].size)                                       \
: NO)
#define iPhone6Plus                                                             \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                   \
? CGSizeEqualToSize(CGSizeMake(1242, 2208),                                     \
[[UIScreen mainScreen] currentMode].size)                                       \
: NO)

#define iPhoneX                                                             \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                   \
? CGSizeEqualToSize(CGSizeMake(1125, 2436),                                     \
[[UIScreen mainScreen] currentMode].size)                                       \
: NO)

#define iPad                                                                    \
(([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)?YES:NO)

#define KMaxValue 10000000000
#define KZero     0

#define KSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define KSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define KStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define KNavBarHeight self.navigationController.navigationBar.frame.size.height
#define KNavbarAndStatusHieght (KStatusBarHeight+KNavBarHeight)
#define KTabBarHeight self.tabBarController.tabBar.height

#define KFrameScreen ([UIScreen mainScreen].bounds)
#define KFrameWithoutBar (CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-KNavbarAndStatusHieght-KTabBarHeight))
#define KFrameWithoutNav (CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-KNavbarAndStatusHieght))
#define KFrameWithoutNavNotStatus (CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-KNavBarHeight - KTabBarHeight))
#define KFrame (CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT))
#define KFrameWithoutTabBar (CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-KTabBarHeight))



//========================================系统版本========================================
//版本大于等于iOS11
#define GHoEIOS11   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define IOS11_OR_GREATER ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 11)

#define iOS11   @available(iOS 11.0, *)
#define iOS10   @available(iOS 10.0, *)
#define iOS9    @available(iOS 9.0, *)
#define iOS8    @available(iOS 8.0, *)
#define iOS7    @available(iOS 7.0, *)

//当前设备系统版本号
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//获取设备当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//========================================URL========================================

#define KURL(string) [NSURL URLWithString:string.length?string:@""]

//========================================UIImage图片========================================

//读取本地图片
#define LoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:type]]

//定义UIImage对象
#define ImageNamed(imageName) [UIImage imageNamed:imageName]
#define ImageNamedOriginal(imageName) [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]


//========================================错误描述信息========================================

#define ERROR_Description(error) [error.userInfo objectForKey:NSLocalizedDescriptionKey]


//========================================UserDefaults========================================

//UserDefaults
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//========================================NotificationCenter========================================

#define NoteCenter [NSNotificationCenter defaultCenter]


//========================================GCD========================================

#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

//========================================打印日志========================================

#ifdef DEBUG
#define D_LOG(fmt, ...) NSLog((@"===> %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define D_LOG(...)
#endif

#define _po(o) D_LOG(@"%@", (o))
#define _pn(o) D_LOG(@"%d", (o))
#define _pf(o) D_LOG(@"%f", (o))
#define _ps(o) D_LOG(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) D_LOG(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)
#define DOBJ(obj)  D_LOG(@"%s: %@", #obj, [(obj) description])
#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)

//解决NSLOG打印不全的问题
//#ifdef DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
//#else
//#define NSLog(FORMAT, ...) nil
//#endif


//========================================字符串格式化========================================

#define StringValue(object) [NSString stringWithFormat:@"%@",object]
#define StringFormat(format,...) [NSString stringWithFormat:format, ##__VA_ARGS__]
#define String_F(...) [NSString stringWithFormat:__VA_ARGS__]


//========================================页面跳转========================================

#define _Nav2Board(__T__)\
UIStoryboard *board = [UIStoryboard storyboardWithName:__T__ bundle:nil];\
UIViewController *ctrl = [board instantiateInitialViewController];\
[self.navigationController pushViewController:ctrl animated:YES];\

#define _Nav2SelfViewControl(__storyBoardID__)\
UIViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:__storyBoardID__];\
[self.navigationController pushViewController:ctrl animated:YES];

#define _Nav2ViewControl(__boardName__,__storyBoardID__)\
UIStoryboard *board = [UIStoryboard storyboardWithName:__boardName__ bundle:nil];\
UIViewController *ctrl = [board instantiateViewControllerWithIdentifier:__storyBoardID__];\
[self.navigationController pushViewController:ctrl animated:YES];\


#define KPushVC(ViewController)\
{\
ViewController *VC = [[ViewController alloc] init];\
[self.navigationController pushViewController:VC animated:YES];\
}

#define KPushVCNotTabBar(ViewController)\
{\
ViewController *VC = [[ViewController alloc] init];\
[VC setHidesBottomBarWhenPushed:YES];\
[self.navigationController pushViewController:VC animated:YES];\
}


#define _LoadXib(__N__,__O__,__D__) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([__N__ class]) owner:__O__ options:__D__] lastObject];


//========================================NSIndexPath========================================

#define IndexZero                   [NSIndexPath indexPathForRow:0 inSection:0]
#define Index(row)                  [NSIndexPath indexPathForRow:row inSection:0]
#define IndexPath(row, section)     [NSIndexPath indexPathForRow:row inSection:section]


//========================================其它========================================

#define KAUTOLAYOUTSCALE_HEIGHT (KSCREEN_HEIGHT / 667.0 )
#define KAUTOLAYOUTSCALE_WIDTH (KSCREEN_WIDTH/375.0)
#define KAUTOLAYOUTSCALE_iPhone5 0.95
#define KAUTOLAYOUTSCALE_iPhone6Plus 1.2

#define KLineHeight 10
#define KIphoneXSafeBottonHeight 24
#define KIphoneXNavHeight 88

//由角度获取弧度
#define DegreesToRadian(x) (M_PI * (x) / 180.0)
//有弧度获取角度
#define RadianToDegrees(radian) (radian*180.0)/(M_PI)


#define Tel(phoneNumber) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]])
#define _RMB(num) (_F(@"¥%.2f",[num intValue]/1.0))


//========================================提示框========================================

#define KPrompt(msg)        [Prompt promptWithMemessage:msg]


//========================================指示器========================================

#define KProgressHudOnlyStr(title) [[MBprogressUtil shareInstance] showMessage:title]
#define KProgressHudOnlyStrAndAfterDelay(ktitle,time) [[MBprogressUtil shareInstance] showMessage:ktitle afterDelay:time]
#define KProgressHudShowGif [SVPHUDUtil showMineGIF]
#define KProgressHudShow [SVPHUDUtil show]
#define KProgressHudHide [SVPHUDUtil hiden]


#ifdef iOS9

#define KShowAlert(ktitle,kmessage)\
{\
UIAlertController *alert = [UIAlertController alertControllerWithTitle:ktitle message:kmessage preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];\
[alert addAction:okAction];\
[kAppDelegate.window.rootViewController presentViewController:alert animated:YES completion:nil];\
}

#else

#define KShowAlert(ktitle,kmessage)\
{\
UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ktitle message:kmessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil , nil];\
[alertView show];\
}

#endif


#define kShowError KShowAlert(@"错误",[error description])

#endif /* UtilMacro_h */
