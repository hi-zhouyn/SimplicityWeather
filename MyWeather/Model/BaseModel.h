//
//  BaseModel.h
//  JuCaiBang
//
//  Created by 陈全 on 15/8/21.
//
//

#import "JSONModelCS.h"


@interface BaseModel : JSONModelCS

@property (assign,nonatomic)NSInteger status;
@property (strong,nonatomic)NSString *msg;

@end
