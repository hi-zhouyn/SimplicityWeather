//
//  Prompt.h
//  Fortune
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Prompt : UILabel

@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) id target;

+ (void)promptWithMemessage:(NSString *)msg;

+ (void)promptWithMemessage:(NSString *)msg target:(id)target action:(SEL)action;

+ (Prompt *)promptWithMemessage:(NSString *)msg withFrame:(CGRect)frame withTime:(NSInteger)time;

+ (Prompt *)promptWithMemessage:(NSString *)msg withFrame:(CGRect)frame withTime:(NSInteger)time target:(id)target action:(SEL)action;

@end
