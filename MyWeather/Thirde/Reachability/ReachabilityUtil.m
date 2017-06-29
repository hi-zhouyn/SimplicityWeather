//
//  ReachabilityUtil.m
//  SocialKids
//
//  Created by admin on 16/6/29.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "ReachabilityUtil.h"
#import "Reachability.h"
@implementation ReachabilityUtil
+(BOOL) isConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.taobao.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break; 
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        default:
            break;
    }
    return isExistenceNetwork;
}
@end
