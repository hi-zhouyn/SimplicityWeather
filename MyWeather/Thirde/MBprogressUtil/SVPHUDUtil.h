//
//  SVPHUDUtil.h
//  SocialKids
//
//  Created by admin on 16/6/27.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SVPHUDUtil : NSObject
// 开始展示
+(void) show;
// 开始展示并且带文字
+(void) show : (NSString *) title;
// 消失
+(void) hiden;
// 消失并带提示文字
+(void) hiden : (NSString *) title;
@end
