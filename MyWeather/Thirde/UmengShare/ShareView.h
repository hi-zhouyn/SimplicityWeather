//
//  ShareView.h
//  WaterDeliVer
//
//  Created by Bean on 15-7-17.
//  Copyright (c) 2015年 CodeSpace. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import "WXApi.h"
#define kShareViewHeight 200*kAUTOLAYOUTSCALE

@protocol ShareViewDelegate <NSObject>
-(void) weilineShareAction: (UIButton *) sender;
-(void) weiCriShareAction: (UIButton *) sender;
-(void) QQShareAction: (UIButton *) sender;
@end
@interface ShareView : BaseViewFromXib

- (void)initClick;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic,weak) id<ShareViewDelegate> delegate;
@property (nonatomic,strong) NSString *url; // 分享URL
@property (nonatomic,strong) NSString *title; // 标题ç
@property (nonatomic,strong) NSString *descriptionStr; // 描述语
@property (nonatomic,strong) NSString *previewImageUrl; // 预览图URL


@end
