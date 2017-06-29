//
//  ModelWXUser.h
//  JuCaiBang
//
//  Created by 陈全 on 15/9/21.
//
//

#import "BaseModel.h"

@interface ModelWXUser : BaseModel
//"openid":"OPENID",
//"nickname":"NICKNAME",
//"sex":1,
//"province":"PROVINCE",
//"city":"CITY",
//"country":"COUNTRY",
//"headimgurl": "http://wx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0",
//"privilege":[
//             "PRIVILEGE1",
//             "PRIVILEGE2"
//             ],
//"unionid": " o6_bmasdasdsad6_2sgVt7hMZOPfL"

@property (strong,nonatomic)NSString *openid;
@property (strong,nonatomic)NSString *nickname;
@property (strong,nonatomic)NSString *sex;
@property (strong,nonatomic)NSString *province;
@property (strong,nonatomic)NSString *city;
@property (strong,nonatomic)NSString *country;
@property (strong,nonatomic)NSString *headimgurl;
@property (strong,nonatomic)NSString *language;
@property (strong,nonatomic)NSString *unionid;
@property (strong,nonatomic)NSString *figureurl_2;
@property (nonatomic,strong)NSString *gender;


@end
