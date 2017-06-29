//
//  CustomTableViewCell.h
//  CrazyBox
//
//  Created by Jack on 15/12/11.
//  Copyright © 2015年 陈全. All rights reserved.
//

#import "BaseTableViewCell.h"
#define kCustomTableViewCellID @"kCustomTableViewCellID"
#define kCustomTableViewCellHirght 49*kAUTOLAYOUTSCALE
@interface CustomTableViewCell : BaseTableViewCell
@property (strong, nonatomic)NSString *title;
@end
