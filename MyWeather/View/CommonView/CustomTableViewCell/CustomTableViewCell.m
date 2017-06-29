//
//  CustomTableViewCell.m
//  CrazyBox
//
//  Created by Jack on 15/12/11.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import "CustomTableViewCell.h"
@interface CustomTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation CustomTableViewCell
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setSeparatorLineType:SeparatorLineTypeBottom];
    
}
- (void)setTitle:(NSString *)title{
    [self.titleLabel setText:title];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
