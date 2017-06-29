//
//  CustomEdgeTextField.m
//  JuCaiBang
//
//  Created by 21Lovetong on 15/10/28.
//
//

#import "CustomEdgeTextField.h"

@interface CustomEdgeTextField ()

@end

@implementation CustomEdgeTextField

- (void)setLeftView:(UIView *)leftView {
    [super setLeftView:leftView];
    [self setLeftViewRect:leftView.frame];
    [self setLeftViewMode:UITextFieldViewModeAlways];
}

- (void)setRightView:(UIView *)rightView {
    [super setRightView:rightView];
    [self setRightViewRect:rightView.frame];
    [self setRightViewMode:UITextFieldViewModeAlways];
}

- (void)setTextEditingLeft:(CGFloat)textEditingLeft {
    [self setTextInset:UIEdgeInsetsMake(0, textEditingLeft, 0, 0)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    [super editingRectForBounds:bounds];
    CGRect editingRect = CGRectMake([self textLeftForBounds:bounds], [self textTopForBounds:bounds], [self textWidthForBounds:bounds], [self textHeightForBounds:bounds]);
    return editingRect;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    [super textRectForBounds:bounds];
    CGRect editingRect = CGRectMake([self textLeftForBounds:bounds], [self textTopForBounds:bounds], [self textWidthForBounds:bounds], [self textHeightForBounds:bounds]);
    return editingRect;
}

- (CGFloat)textLeftForBounds:(CGRect)bounds {
    return bounds.origin.x + self.textInset.left + self.leftViewRect.origin.x + self.leftViewRect.size.width;
}

- (CGFloat)textTopForBounds:(CGRect)bounds {
    return bounds.origin.y + self.textInset.top;
}

- (CGFloat)textWidthForBounds:(CGRect)bounds {
    return bounds.size.width - [self textLeftForBounds:bounds] - self.textInset.right + self.rightViewRect.origin.x - self.bounds.size.width;
}

- (CGFloat)textHeightForBounds:(CGRect)bounds {
    return bounds.size.height - self.textInset.top - self.textInset.bottom;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    [super leftViewRectForBounds:bounds];
    return self.leftViewRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    [super rightViewRectForBounds:bounds];
    return self.rightViewRect;
    

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
