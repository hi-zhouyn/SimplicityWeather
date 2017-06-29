//
//  CSTextFieldView.h
//  JuCaiBangManager
//
//  Created by 21Lovetong on 15/10/28.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomEdgeTextField.h"

@interface CSTextFieldView : UIView

@property (nonatomic, strong) NSString *text;

/**
 *  textField
 */
@property (nonatomic, strong) CustomEdgeTextField *textField;
/**
 *  clearButtonMode
 */
@property (nonatomic)        UITextFieldViewMode  clearButtonMode; // sets when the clear button shows up. default is UITextFieldViewModeNever
/**
 *  leftView
 *  需要设置 frame（完全按照设置的 view的 frame）
 */
@property (nonatomic, strong) UIView              *leftView;        // e.g. magnifying glass
@property (nonatomic)         UITextFieldViewMode  leftViewMode;    // sets when the left view shows up. default is UITextFieldViewModeNever
/**
 *  rightView
 *  需要设置 frame（完全按照设置的 view的 frame）
 */
@property (nonatomic, strong) UIView              *rightView;       // e.g. bookmarks button
@property (nonatomic)         UITextFieldViewMode  rightViewMode;   // sets when the right view shows up. default is UITextFieldViewModeNever

@property (nonatomic, strong) UIView *leftViewNormal;
@property (nonatomic, strong) UIView *leftViewEditing;

@property (nonatomic, strong) UIView *rightViewNormal;
@property (nonatomic, strong) UIView *rightViewEditing;

@property (nonatomic, strong) void(^editingStateChangedCallBack)(BOOL isEditing);

/**
 *  输入的是电话号（键盘是九宫格数字键盘，限制可输入文字 11位）
 */
@property (nonatomic, getter=isPhoneNumMode, assign) BOOL phoneNumMode;
/**
 *  密文输入
 */
@property (nonatomic, getter=isSecureTextEntry, assign) BOOL secureTextEntry;
/**
 *  光标离左边距离
 */
@property (nonatomic, assign) CGFloat textEditingLeft;
/**
 *  文字范围（文字可见范围）
 */
@property (nonatomic, assign) UIEdgeInsets textInset;
/**
 *  输入的字符长度限制
 */
@property (nonatomic, assign) NSInteger maxTextCount;
/**
 *  光标颜色
 */
@property (nonatomic, strong) UIColor *cursorColor;

/**
 *  textField 文字发生改变回调
 */
- (void)setTextFieldChangeTextCallBack:(void(^)(NSString *text))textFieldChangeTextCallBack;

/**
 *  键盘弹出或回收回调
 */
- (void)setKeyboardShowOrHideCallBack:(void(^)(CGSize keyboardSize))keyboardShowOrHideCallBack;

- (void)setLeftViewNormalWithText:(NSString *)txt frame:(CGRect)frame;

- (void)setLeftViewEditingWithText:(NSString *)txt frame:(CGRect)frame;

- (void)setRightViewNormalWithText:(NSString *)txt frame:(CGRect)frame;

- (void)setRightViewEditingWithText:(NSString *)txt frame:(CGRect)frame;

- (void)setLeftViewNormalWithImageName:(NSString *)imgName frame:(CGRect)frame;
- (void)setLeftViewNormalWithImageName:(NSString *)imgName frame:(CGRect)frame size:(CGSize)size;

- (void)setLeftViewEditingWithImageName:(NSString *)imgName frame:(CGRect)frame;

- (void)setRightViewNormalWithImageName:(NSString *)imgName frame:(CGRect)frame;
- (void)setRightViewNormalWithImageName:(NSString *)imgName frame:(CGRect)frame size:(CGSize)size;

- (void)setRightViewEditingWithImageName:(NSString *)imgName frame:(CGRect)frame;

@end
