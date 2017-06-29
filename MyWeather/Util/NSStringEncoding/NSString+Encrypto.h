//
//  Security.h
//  xunqiu
//
//  Created by seastar on 15/4/1.
//
//

#import <Foundation/Foundation.h>


@interface NSString (Encrypto)
- (NSString *) md5;
- (NSString *) sha1;
- (NSString *) sha1_base64;
- (NSString *) md5_base64;
- (NSString *) base64;

@end