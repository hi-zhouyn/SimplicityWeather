//
//  CustomEdgeTextField.h
//  JuCaiBang
//
//  Created by 21Lovetong on 15/10/28.
//
//

#import <UIKit/UIKit.h>

@interface CustomEdgeTextField : UITextField

@property (nonatomic, assign) CGRect leftViewRect;

@property (nonatomic, assign) CGRect rightViewRect;

@property (nonatomic, assign) CGFloat textEditingLeft;

@property (nonatomic, assign) UIEdgeInsets textInset;

@end
