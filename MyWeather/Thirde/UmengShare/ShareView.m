//
//  ShareView.m
//  WaterDeliVer
//
//  Created by Bean on 15-7-17.
//  Copyright (c) 2015年 CodeSpace. All rights reserved.
//

#import "ShareView.h"
#import "UmengUtil.h"

@implementation ShareView

- (void)awakeFromNib
{
   [AutoLayoutUtil autoLayoutWith:self.subviews];    
    self.lineView.size = CGSizeMake(kSCREEN_WIDTH, 0.6 * kAUTOLAYOUTSCALE);
}

- (IBAction)weilineClick:(id)sender {
//    [self doDismissAnimation];
//    [self.delegate weilineShareAction:sender];
//    
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = self.title;
//    if (self.descriptionStr.length >= 25) {
//      self.descriptionStr = [self.descriptionStr substringToIndex:25];
//    }
//    NSString *description = [[NSString alloc] init];
//    if (self.descriptionStr.length == 0 || self.descriptionStr == NULL) {
//        description = @"超有料的亲子生活主题社区";
//    }else
//    {
//        description = self.descriptionStr;
//    }
//    message.description = description;
//    [message setThumbImage:[UIImage imageNamed:@"shareLogo.png"]];
//    WXWebpageObject *webpageObject = [WXWebpageObject object];
//    webpageObject.webpageUrl = self.url;
//    message.mediaObject = webpageObject;
//    
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    req.scene =WXSceneSession;
//    [WXApi sendReq:req];
    
}
- (IBAction)weiCriCLick:(id)sender {
//    [self doDismissAnimation];
//    [self.delegate weiCriShareAction:sender];
//    
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = self.title;
//    if (self.descriptionStr.length >= 25) {
//        self.descriptionStr = [self.descriptionStr substringToIndex:25];
//    }
//    NSString *description = [[NSString alloc] init];
//    if (self.descriptionStr.length == 0 || self.descriptionStr == NULL) {
//        description = @"超有料的亲子生活主题社区";
//    }else
//    {
//        description = self.descriptionStr;
//    }
//    message.description = description;
//    [message setThumbImage:[UIImage imageNamed:@"shareLogo.png"]];
//    WXWebpageObject *webpageObject = [WXWebpageObject object];
//    webpageObject.webpageUrl = self.url;
//    message.mediaObject = webpageObject;
//    
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    req.scene =WXSceneTimeline;
//    [WXApi sendReq:req];

}
- (IBAction)QQShareClick:(id)sender {
//    [self doDismissAnimation];
//    [self.delegate QQShareAction:sender];
//    
//    NSString *url = self.url;
//    NSString *title = self.title;
//    if (self.descriptionStr.length >= 25) {
//        self.descriptionStr = [self.descriptionStr substringToIndex:25];
//    }
//    NSString *description = [[NSString alloc] init];
//    if (self.descriptionStr.length == 0 || self.descriptionStr == NULL) {
//       description = @"超有料的亲子生活主题社区";
//    }else
//    {
//        description = self.descriptionStr;
//    }
//    
//    //分享图预览图URL地址
//    NSLog(@"url:%@",self.previewImageUrl);
//    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:description previewImageURL:[NSURL URLWithString:self.previewImageUrl]];
//
//    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
//    [QQApiInterface sendReq:req];
//    QQApiSendResultCode sent =
}

- (IBAction)dismissClick:(id)sender {

    [self doDismissAnimation];
}

- (void)doDismissAnimation
{
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        UIView *view = weakSelf.superview;
        view.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        weakSelf.frame = CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kShareViewHeight);
        
    }completion:^(BOOL finished) {
        [weakSelf.superview removeFromSuperview];
        
    }];
}

- (void)initClick
{
    UIView *view = self.superview;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [view addGestureRecognizer:tap];
}

- (void)tapClick
{
    [self doDismissAnimation];

}


@end
