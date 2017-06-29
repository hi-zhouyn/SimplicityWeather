//
//  CSTextFieldView.m
//  JuCaiBangManager
//
//  Created by 21Lovetong on 15/10/28.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import "CSTextFieldView.h"

#define PhoneNumberCount    11

@interface CSTextFieldView ()<UITextFieldDelegate>

@property (nonatomic, assign) BOOL needTextFieldChangeTextCallBack;
@property (nonatomic, assign) BOOL needKeyboardStateChangeCallBack;
@property (nonatomic, strong) void(^textFieldTextDidChangeCallBack)(NSString *text);
@property (nonatomic, strong) void(^keyboardStateChangeCallBack)(CGSize keyboardSize);
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation CSTextFieldView

@synthesize text = _text;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initial];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)initial {
    [self addSubview:self.textField];
}

- (NSString *)text {
    return self.textField.text;
}

- (void)setText:(NSString *)text {
    _text = text;
    [self.textField setText:text];
}

- (CustomEdgeTextField *)textField {
    if (!_textField) {
        _textField = [[CustomEdgeTextField alloc] initWithFrame:self.bounds];
        [_textField setDelegate:self];
    }
    return _textField;
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode {
    _clearButtonMode = clearButtonMode;
    [self.textField setClearButtonMode:clearButtonMode];
}

- (void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    [self.textField setLeftView:leftView];
    [self.textField setLeftViewRect:leftView.frame];
}

- (void)setRightView:(UIView *)rightView {
    _rightView = rightView;
    [self.textField setRightView:rightView];
    [self.textField setRightViewRect:rightView.frame];
}

- (void)setLeftViewMode:(UITextFieldViewMode)leftViewMode {
    _leftViewMode = leftViewMode;
    [self.textField setLeftViewMode:leftViewMode];
}

- (void)setRightViewMode:(UITextFieldViewMode)rightViewMode {
    _rightViewMode = rightViewMode;
    [self.textField setRightViewMode:rightViewMode];
}

- (void)setLeftViewNormal:(UIView *)leftViewNormal {
    _leftViewNormal = leftViewNormal;
    if (_leftViewNormal != leftViewNormal) {
        [self addSubview:leftViewNormal];
    }
    if (leftViewNormal) {
        [self.textField setLeft:leftViewNormal.right];
        [self.textField setWidth:self.width - leftViewNormal.right - self.rightViewNormal.left];
    }
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setUserInteractionEnabled:NO];
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setUserInteractionEnabled:NO];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (void)setLeftViewNormalWithText:(NSString *)txt frame:(CGRect)frame {
    [self.leftBtn setTitle:txt forState:UIControlStateNormal];
    [self.leftBtn setFrame:frame];
    [self.leftBtn setCenterY:self.height / 2.0f];
    [self setTextFieldFrame];
}

- (void)setLeftViewEditingWithText:(NSString *)txt frame:(CGRect)frame {
    [self.leftBtn setTitle:txt forState:UIControlStateSelected];
    [self.leftBtn setFrame:frame];
    [self.leftBtn setCenterY:self.height / 2.0f];
    [self setTextFieldFrame];
}

- (void)setRightViewNormalWithText:(NSString *)txt frame:(CGRect)frame {
    [self.rightBtn setTitle:txt forState:UIControlStateNormal];
    [self.rightBtn setFrame:frame];
    [self.rightBtn setCenterY:self.height / 2.0f];
    [self setTextFieldFrame];
}

- (void)setRightViewEditingWithText:(NSString *)txt frame:(CGRect)frame {
    [self.rightBtn setTitle:txt forState:UIControlStateSelected];
    [self.rightBtn setFrame:frame];
    [self.rightBtn setCenterY:self.height / 2.0f];
    [self setTextFieldFrame];
}

- (void)setLeftViewNormalWithImageName:(NSString *)imgName frame:(CGRect)frame {
    [self.leftBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [self.leftBtn setFrame:frame];
    [self.leftBtn setCenterY:self.height / 2.0f];
    [self setTextFieldFrame];
}

- (void)setLeftViewNormalWithImageName:(NSString *)imgName frame:(CGRect)frame size:(CGSize)size {
    [self.leftBtn setImage:[[UIImage imageNamed:imgName] transformtoSize:size] forState:UIControlStateNormal];
    [self.leftBtn setFrame:frame];
    [self.leftBtn setCenterY:self.height / 2.0f];
    [self setTextFieldFrame];
}

- (void)setLeftViewEditingWithImageName:(NSString *)imgName frame:(CGRect)frame {
    [self.leftBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateSelected];
    [self.leftBtn setFrame:frame];
    [self.leftBtn setCenterY:self.height / 2.0f];
    [self setTextFieldFrame];
}

- (void)setRightViewNormalWithImageName:(NSString *)imgName frame:(CGRect)frame {
    [self.rightBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [self.rightBtn setFrame:frame];
    [self.rightBtn setCenterY:self.height / 2.0f];
    [self setTextFieldFrame];
}

- (void)setRightViewNormalWithImageName:(NSString *)imgName frame:(CGRect)frame size:(CGSize)size {
    [self.rightBtn setImage:[[UIImage imageNamed:imgName] transformtoSize:size] forState:UIControlStateNormal];
    [self.rightBtn setFrame:frame];
    [self.rightBtn setCenterY:self.height / 2.0f];
    [self setTextFieldFrame];
}

- (void)setRightViewEditingWithImageName:(NSString *)imgName frame:(CGRect)frame {
    [self.rightBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateSelected];
    [self.rightBtn setFrame:frame];
    [self.rightBtn setCenterY:self.height / 2.0f];
    [self setTextFieldFrame];
}

- (void)setRightViewNormal:(UIView *)rightViewNormal {
    _rightViewNormal = rightViewNormal;
    if (_rightViewNormal != rightViewNormal) {
        [self addSubview:rightViewNormal];
    }
    if (rightViewNormal) {
        [self.textField setLeft:self.leftViewNormal.right];
        [self.textField setWidth:self.width - self.leftViewNormal.right - rightViewNormal.left];
    }
}

- (void)setLeftViewEditing:(UIView *)leftViewEditing {
    _leftViewEditing = leftViewEditing;
    if (_leftViewEditing != leftViewEditing) {
        [self addSubview:leftViewEditing];
    }
    if (leftViewEditing) {
        [self.textField setLeft:leftViewEditing.right];
        [self.textField setWidth:self.width - leftViewEditing.right - self.rightViewEditing.left];
    }
}

- (void)setRightViewEditing:(UIView *)rightViewEditing {
    _rightViewEditing = rightViewEditing;
    if (_rightViewNormal != rightViewEditing) {
        [self addSubview:rightViewEditing];
    }
    if (rightViewEditing) {
        [self.textField setLeft:self.leftViewNormal.right];
        [self.textField setWidth:self.width - self.leftViewEditing.right - rightViewEditing.left];
    }
}

- (void)setTextFieldFrame {
    [self.textField setLeft:self.leftBtn.right];
    [self.textField setWidth:self.width - self.leftBtn.right - self.rightBtn.left];
}

- (void)setTextEditingLeft:(CGFloat)textEditingLeft {
    _textEditingLeft = textEditingLeft;
    [self.textField setTextEditingLeft:textEditingLeft];
}

- (void)setTextInset:(UIEdgeInsets)textInset {
    _textInset = textInset;
    [self.textField setTextInset:textInset];
}

- (void)setCursorColor:(UIColor *)cursorColor {
    _cursorColor = cursorColor;
    [self.textField setTintColor:cursorColor];
}

- (void)setPhoneNumMode:(BOOL)phoneNumMode {
    _phoneNumMode = phoneNumMode;
    if (phoneNumMode) {
        [self setMaxTextCount:PhoneNumberCount];
        [self.textField setKeyboardType:UIKeyboardTypePhonePad];
    }
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    [self.textField setSecureTextEntry:secureTextEntry];
}

- (void)setTextFieldChangeTextCallBack:(void(^)(NSString *text))textFieldChangeTextCallBack {
    [self registerForTextFieldTextChangeNotification];
    [self setTextFieldTextDidChangeCallBack:textFieldChangeTextCallBack];
}

- (void)registerForTextFieldTextChangeNotification {
    if (!self.needTextFieldChangeTextCallBack) {
        [self setNeedTextFieldChangeTextCallBack:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self.textField];
    }
}

- (void)setKeyboardShowOrHideCallBack:(void(^)(CGSize keyboardSize))keyboardShowOrHideCallBack {
    [self registerForKeyboardNotifications];
    [self setKeyboardStateChangeCallBack:keyboardShowOrHideCallBack];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.leftViewEditing) {
        [self setLeftViewEditing:self.leftViewEditing];
    } if (self.rightViewEditing) {
        [self setRightViewEditing:self.rightViewEditing];
    } if (self.editingStateChangedCallBack) {
        self.editingStateChangedCallBack(YES);
    }
    [_leftBtn setSelected:YES];
    [_rightBtn setSelected:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.leftViewNormal) {
        [self setLeftViewNormal:self.leftViewNormal];
    } if (self.rightViewNormal) {
        [self setRightViewNormal:self.rightViewNormal];
    } if (self.editingStateChangedCallBack) {
        self.editingStateChangedCallBack(NO);
    }
    [_leftBtn setSelected:NO];
    [_rightBtn setSelected:NO];
}

- (void)setMaxTextCount:(NSInteger)maxTextCount {
    _maxTextCount = maxTextCount;
    [self registerForTextFieldTextChangeNotification];
}

- (void)textFieldTextDidChange {
    if (self.maxTextCount) {
        if (self.textField.text.length > self.maxTextCount) {
            [self.textField setText:[self.textField.text substringToIndex:self.maxTextCount]];
        }
    }
    if (self.textFieldTextDidChangeCallBack) {
        self.textFieldTextDidChangeCallBack(self.textField.text);
    }
}

- (void)registerForKeyboardNotifications {
    if (!self.needKeyboardStateChangeCallBack) {
        [self setNeedKeyboardStateChangeCallBack:YES];
        //使用NSNotificationCenter 键盘弹出
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
        
        //使用NSNotificationCenter 键盘隐藏
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWillShown:(NSNotification *)aNotification {
    NSDictionary* info = [aNotification userInfo];
    //kbSize即为键盘尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到键盘的高度
    if (self.keyboardStateChangeCallBack) {
        self.keyboardStateChangeCallBack(kbSize);
    }
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    if (self.keyboardStateChangeCallBack) {
        self.keyboardStateChangeCallBack(CGSizeZero);
    }
}

- (void)dealloc {
    if ([self needTextFieldChangeTextCallBack]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.textField];
    } if ([self needKeyboardStateChangeCallBack]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
