//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "UIView+CSFrame.h"

@implementation UIView (CSFrame)


/**
 *  autolayout
 */
- (void)autoLayout
{
    [self autolayoutWithoutFont];
//    [self setFont];
}
- (void)setFont {
    if ([self canSetText]) {
        UILabel *label = (UILabel *)self;
        CGFloat size = label.font.pointSize;
        if (iPhone5 || iPhone4) {
            
             label.font = kBaseSetFontOfSize_iPhone5(label.font.fontName, size);
        }else if (iPhone6Plus)
        {
            label.font = kBaseSetFontOfSize_iPhone6Plus(label.font.fontName, size);
        }else
        {
            label.font = kBaseSetFontOfSize(label.font.fontName, size);
        }
        
    } else if ([self isButton]) {
        UIButton *btn = (UIButton*)self;
        UILabel *titleLabel = btn.titleLabel;
//        UILabel *titleLabel = [(UIButton*)self titleLabel];
        CGFloat size = titleLabel.font.pointSize;
        if (iPhone5 || iPhone4) {
            
            titleLabel.font = kBaseSetFontOfSize_iPhone5(titleLabel.font.fontName, size);
        }else if (iPhone6Plus)
        {
            titleLabel.font = kBaseSetFontOfSize_iPhone6Plus(titleLabel.font.fontName, size);
        }else
        {
            titleLabel.font = kBaseSetFontOfSize(titleLabel.font.fontName, size);
        }
        
    }

    
    
}
- (BOOL)isButton {
    return [self respondsToSelector:@selector(titleLabel)];
}

- (BOOL)canSetText {
    return [self respondsToSelector:@selector(setText:)];
}
- (void)autolayoutWithoutFont {
    
    self.frame =  CGRectMake(self.frame.origin.x*kAUTOLAYOUTSCALE, self.frame.origin.y*kAUTOLAYOUTSCALE, self.frame.size.width*kAUTOLAYOUTSCALE, self.frame.size.height*kAUTOLAYOUTSCALE);
    
   
    
    if ([self isKindOfClass:[UILabel class]]||[self isMemberOfClass:[UITextField class]]||[self isMemberOfClass:[UITextView class]]) {
        UILabel *label = (UILabel *)self;
        CGFloat size = label.font.pointSize;
        if (iPhone5 || iPhone4) {
            
            label.font = kBaseSetFontOfSize_iPhone5(label.font.fontName, size);
        }
//        else if (iPhone6Plus)
//        {
//            label.font = kBaseSetFontOfSize_iPhone6Plus(label.font.fontName, size);
//        }else
//        {
//            label.font = kBaseSetFontOfSize(label.font.fontName, size);
//        }
        else
        {
            label.font = kBaseSetFontOfSize(label.font.fontName, size);
        }

    }
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton*)self;
        UILabel *label = btn.titleLabel;
        CGFloat size = label.font.pointSize;
        if (iPhone5 || iPhone4) {
            
            label.font = kBaseSetFontOfSize_iPhone5(label.font.fontName, size);
        }
//        else if (iPhone6Plus)
//        {
//            label.font = kBaseSetFontOfSize_iPhone6Plus(label.font.fontName, size);
//        }else
//        {
//            label.font = kBaseSetFontOfSize(label.font.fontName, size);
//        }
        else
        {
            label.font = kBaseSetFontOfSize(label.font.fontName, size);
        }
        
    }

}

- (void)autoLayoutAllSubViews {
    [self autoLayout];
    if (self.subviews.count) {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[UIView class]] && ![subView isKindOfClass:[UIButton class]]) {
                [subView autoLayoutAllSubViews];
            } else {
                [subView autoLayout];
            }
        }
    }
}

- (void)autoLayoutAllSubViewsWithoutFont {
    [self autolayoutWithoutFont];
//    [self autoLayout ];
    if (self.subviews.count) {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[UIView class]] && ![subView isKindOfClass:[UIButton class]]) {
                [subView autoLayoutAllSubViewsWithoutFont];
//                [subView autoLayoutAllSubViews];
            } else {
                [subView autolayoutWithoutFont];
                
//                if ([subView isKindOfClass:[UILabel class]]||[subView isMemberOfClass:[UITextField class]]||[subView isMemberOfClass:[UITextView class]]) {
//                    UILabel *label = (UILabel *)subView;
//                    CGFloat size = label.font.pointSize;
//                    if (iPhone5 || iPhone4) {
//                        
//                        label.font = kBaseSetFontOfSize_iPhone5(label.font.fontName, size);
//                    }else if (iPhone6Plus)
//                    {
//                        label.font = kBaseSetFontOfSize_iPhone6Plus(label.font.fontName, size);
//                    }else
//                    {
//                        label.font = kBaseSetFontOfSize(label.font.fontName, size);
//                    }
//                }
//                if ([subView isKindOfClass:[UIButton class]]) {
//                    UIButton *btn = (UIButton*)subView;
//                    UILabel *label = btn.titleLabel;
//                    CGFloat size = label.font.pointSize;
//                    if (iPhone5 || iPhone4) {
//                        
//                        label.font = kBaseSetFontOfSize_iPhone5(label.font.fontName, size);
//                    }else if (iPhone6Plus)
//                    {
//                        label.font = kBaseSetFontOfSize_iPhone6Plus(label.font.fontName, size);
//                    }else
//                    {
//                        label.font = kBaseSetFontOfSize(label.font.fontName, size);
//                    }
//                    
//                }

                
                
                
                
            }
        }
    }
}

- (void)setFrameWithCenterAndSize:(CGRect)centerAndSize {
    [self setSize:centerAndSize.size];
    [self setCenter:centerAndSize.origin];
}

- (void)setFrameWithCenterXAndSize:(CGRect)centerAndSize {
    [self setSize:centerAndSize.size];
    [self setCenterX:centerAndSize.origin.x];
    [self setTop:centerAndSize.origin.y];
}

- (void)setFrameWithCenterYAndSize:(CGRect)centerAndSize {
    [self setSize:centerAndSize.size];
    [self setCenterY:centerAndSize.origin.y];
    [self setLeft:centerAndSize.origin.x];
}


- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y{
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	self.frame = frame;
}

- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	self.frame = frame;
}

- (CGFloat)centerX {
	return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
	self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
	return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
	self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGFloat)ttScreenX {
	CGFloat x = 0.0f;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
	}
	return x;
}

- (CGFloat)ttScreenY {
	CGFloat y = 0.0f;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
	}
	return y;
}

- (CGFloat)screenViewX {
	CGFloat x = 0.0f;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			x -= scrollView.contentOffset.x;
		}
	}
	return x;
}

- (CGFloat)screenViewY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			y -= scrollView.contentOffset.y;
		}
	}
	return y;
}

- (CGRect)screenFrame {
	return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}

- (CGSize)size {
	return self.frame.size;
}

- (void)setSize:(CGSize)size {
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (CGFloat)orientationWidth {
  return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.height : self.width;
}

- (CGFloat)orientationHeight {
  return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.width : self.height;
}

- (UIView*)descendantOrSelfWithClass:(Class)cls {
	if ([self isKindOfClass:cls])
		return self;
	
	for (UIView* child in self.subviews) {
		UIView* it = [child descendantOrSelfWithClass:cls];
		if (it)
			return it;
	}
	
	return nil;
}

- (UIView*)ancestorOrSelfWithClass:(Class)cls {
	if ([self isKindOfClass:cls]) {
		return self;
		
	} else if (self.superview) {
		return [self.superview ancestorOrSelfWithClass:cls];
		
	} else {
		return nil;
	}
}

- (void)removeAllSubviews {
	while (self.subviews.count) {
		UIView* child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (CGPoint)offsetFromView:(UIView*)otherView {
	CGFloat x = 0.0f, y = 0.0f;
	for (UIView* view = self; view && view != otherView; view = view.superview) {
		x += view.left;
		y += view.top;
	}
	return CGPointMake(x, y);
}

- (void)addTapGestureRecogniserWithTarget:(id)target action:(SEL)action {
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tapGesture];
}




@end
