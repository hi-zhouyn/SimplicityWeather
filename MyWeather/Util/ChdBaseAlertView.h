//
//  ChdBaseAlertView.h
//  GYY
//
//  Created by kings on 15/11/18.
//  Copyright © 2015年 kings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChdBaseAlertView : UIAlertView

/**
 *  显示单行标题及确认按钮
 *
 *  @return
 */
+(void)showAlertViewWithMessage:(nullable NSString *)message;
/**
 *  显示单行标题及确认按钮 实现代理
 *
 *  @return
 */

+(void)showAlertViewWithMessage:(nullable NSString *)message delegate:(nullable id /*<ChdBaseAlertViewDelegate>*/)delegate;
/**
 *  显示单行标题及自定义按钮
 *
 *  @return
 */
+(void)showAlertViewWithMessage:(nullable NSString *)message cusButtonTitle:(nullable NSString *)cusButtonTitles,...;
/**
 *  显示单行标题及自定义按钮 实现代理
 *
 *  @return
 */
+(void)showAlertViewWithMessage:(nullable NSString *)message delegate:(nullable id /*<ChdBaseAlertViewDelegate>*/)delegate cusButtonTitle:(nullable NSString *)cusButtonTitles,...;

/**
 *  显示多行标题及确认按钮
 *
 *  @return
 */
+(void)showAlertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message;
/**
 *  显示多行标题及确认按钮 实现代理
 *
 *  @return
 */
+(void)showAlertViewWithTitle:(nullable NSString *)title  message:(nullable NSString *)message delegate:(nullable id /*<ChdBaseAlertViewDelegate>*/)delegate;
/**
 *  显示多行标题及自定义按钮
 *
 *  @return
 */
+(void)showAlertViewWithTitle:(nullable NSString *)title  message:(nullable NSString *)message  otherButtonTitles:(nullable NSString *)otherButtonTitles,...;
/**
 *  显示多行标题及自定义按钮 实现代理
 *
 *  @return
 */
+(void)showAlertViewWithTitle:(nullable NSString *)title  message:(nullable NSString *)message delegate:(nullable id /*<ChdBaseAlertViewDelegate>*/)delegate otherButtonTitles:(nullable NSString *)otherButtonTitles,...;
@end
