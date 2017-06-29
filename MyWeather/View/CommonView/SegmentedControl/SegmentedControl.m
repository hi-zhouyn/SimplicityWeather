//
//  SegmentedControl.m
//  JuCaiBang
//
//  Created by 21Lovetong on 15/7/23.
//
//

#import "SegmentedControl.h"

@interface SegmentedControl ()
{
    NSInteger _buttonCount;
}

@property (nonatomic, strong) UIButton *lastPressedButton;
@property (nonatomic, assign) id<SegmentedControlDelegate> delegate;
@end

@implementation SegmentedControl

-(void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex
{
    _currentSelectedIndex = currentSelectedIndex;
    [self buttonDidSelected:self.btns[currentSelectedIndex]];
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    if (self.btns) {
        [titles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *  stop) {
            UIButton *btn = self.btns[idx];
            [btn setTitle:obj forState:UIControlStateNormal];
        }];
    }
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<SegmentedControlDelegate>)delegate titles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:kColorWhite];
        self.titles = titles;
        _buttonCount = titles.count;
        self.delegate = delegate;
        [self addButtonsWithFrame:frame];
    }
    return self;
}

/*
 *  根绝按钮标题添加按钮
 */
- (void)addButtonsWithFrame:(CGRect)frame {
    self.btns = [NSMutableArray array];
    CGFloat buttonLeft = 0;
    NSString *title;
    CGFloat buttonWidth = (frame.size.width - Space * (_buttonCount - 1)) / _buttonCount;
    for (int i = 0; i < _buttonCount; i++) {
        if (i) {
            buttonLeft = i * (buttonWidth + Space);
        }
        title = [self.titles objectAtIndex:i];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonLeft, 0, buttonWidth, frame.size.height)];
        if (!i) {
            self.lastPressedButton = button;
            [button setSelected:YES];
            [button.layer setBorderWidth:0];
        }
        [button setTag:i];
//        [button.titleLabel setFont:kCustomFontOfSize(17)];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTintColor:[UIColor clearColor]];
        [button addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
        [button addTarget:self action:@selector(buttonDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.btns addObject:button];
    }
    [self setDefault];
}

/*
 *  设置默认属性（各个颜色）
 */
- (void)setDefault {
    _currentSelectedIndex = 0;
    [self setSelectedBackgroundColor:kSetRGBColor(210, 42, 33)];
    [self setSelectedTitleColor:[UIColor whiteColor]];
    [self setTitleColor:kSetRGBColor(67, 67, 67)];
    [self setButtonsbackgroundColor:kSetRGBColor(241, 241, 241)];
    [self setButtonsCornerRadius:0];
    [self setBorderColor:kSetRGBColor(128, 128, 128)];
    [self setBorderWidth:0.5f];
}

/*
 *  设置未选中状态背景颜色
 */
- (void)setButtonsbackgroundColor:(UIColor *)buttonsbackgroundColor {
    _buttonsbackgroundColor = buttonsbackgroundColor;
    for (UIButton *button in self.subviews) {
        if (!button.selected) {
            [button setBackgroundColor:buttonsbackgroundColor];
        }
    }
}

/*
 *  设置选中状态背景颜色
 */
- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
    _selectedBackgroundColor = selectedBackgroundColor;
    for (UIButton *button in self.subviews) {
        if (button.selected) {
            [button setBackgroundColor:selectedBackgroundColor];
        }
    }
}

/*
 *  设置未选中状态字体颜色
 */
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    for (UIButton *button in self.subviews) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

/*
 *  设置选中状态字体颜色
 */
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    for (UIButton *button in self.subviews) {
        [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
}

/*
 *  设置边框颜色
 */
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    for (UIButton *button in self.subviews) {
        [button.layer setBorderColor:borderColor.CGColor];
    }
}

/*
 *  设置边框宽度
 */
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    for (UIButton *button in self.subviews) {
        if (button.selected && !self.selectedBackgroundImage) {
            [button.layer setBorderWidth:0];
        } else {
            [button.layer setBorderWidth:borderWidth];
        }
    }
}

/*
 *  按钮设置圆角半径
 */
- (void)setButtonsCornerRadius:(CGFloat)buttonsCornerRadius {
    _buttonsCornerRadius = buttonsCornerRadius;
    for (UIButton *button in self.subviews) {
        [button.layer setCornerRadius:buttonsCornerRadius];
    }
}

/*
 *  设置按钮间距
 */
- (void)setItemSpace:(CGFloat)itemSpace {
    _itemSpace = itemSpace;
    CGFloat buttonLeft = 0;
    CGFloat buttonWidth = (self.frame.size.width - itemSpace * (_buttonCount - 1)) / _buttonCount;
    for (int i = 0; i < _buttonCount; i++) {
        if (i) {
            buttonLeft = i * (buttonWidth + itemSpace);
        }
        UIButton *button = [self.subviews objectAtIndex:i];
        [button setWidth:buttonWidth];
        [button setLeft:buttonLeft];
    }
}

/*
 *  按钮的点击事件
 */
- (void)buttonDidSelected:(UIButton *)button {
    _currentSelectedIndex=button.tag;
    [button setSelected:YES];
    [button setUserInteractionEnabled:NO];
    if (self.lastPressedButton && self.lastPressedButton != button) {
        [self.lastPressedButton setSelected:NO];
        [self.lastPressedButton setUserInteractionEnabled:YES];
    }
    self.lastPressedButton = button;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedControl:didSelectButtonAtIndex:)]) {
        [self.delegate segmentedControl:self didSelectButtonAtIndex:button.tag];
    }
}

/*
 *  KVO 监听按钮的选中状态
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selected"]) {
        [self setBorderWidth:_borderWidth];
        [self setSelectedBackgroundColor:_selectedBackgroundColor];
        [self setButtonsbackgroundColor:_buttonsbackgroundColor];
    }
}

/*
 *  注销 KVO监听
 */
- (void)dealloc {
    for (UIButton *button in self.subviews) {
        [button removeObserver:self forKeyPath:@"selected" context:nil];
    }
}

/*
 *  选中的按钮背景图片
 */
- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage {
    _selectedBackgroundImage = selectedBackgroundImage;
    for (UIButton *button in self.subviews) {
        [button setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
        [self setSelectedBackgroundColor:[UIColor clearColor]];
        [self setButtonsbackgroundColor:[UIColor clearColor]];
    }
}

- (void)setSeperaterHeight:(CGFloat)seperaterHeight {
    _seperaterHeight = seperaterHeight;
    [self setNeedsDisplay];
}

/*
 *  字体
 */
- (void)setFont:(UIFont *)font {
    _font = font;
    for (UIButton *button in self.subviews) {
        [button.titleLabel setFont:font];
    }
}

/**
 *  设置tag
 */
- (void)setTags:(NSArray *)tags {
    for (int i = 0; i < tags.count; i++) {
        UIButton *button = self.subviews[i];
        [button setTag:[tags[i] integerValue]];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.seperaterHeight) {
        NSMutableArray *pointArr = [NSMutableArray arrayWithCapacity:0];
        [self setButtonsbackgroundColor:kColorClear];
        for (int i = 0; i < self.subviews.count - 1; i++) {
            UIButton *button = self.subviews[i];
            CGFloat spase = (self.height - self.seperaterHeight) / 2.0f;
            [pointArr addObject:kLinePointSet(button.right, spase, button.right, self.height - spase)];
        }
        [DrawUtil drawLinePointArr:pointArr LineColor:kColorLine];
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
