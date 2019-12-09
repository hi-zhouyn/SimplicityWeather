//
//  UIImage+Common.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

-(NSString *)saveImageToTmpWithCompressLevel:(CGFloat)compressionQuality
{
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *fileName = [NSString stringWithFormat:@"%.0lf.jpg",[NSDate date].timeIntervalSince1970*1000];
    tmpPath = [tmpPath stringByAppendingPathComponent:fileName];
    [UIImageJPEGRepresentation(self, compressionQuality) writeToFile:tmpPath  atomically:YES];
    return tmpPath;
}

- (NSString *)saveImageToTmpWithSize:(CGFloat)maxFileSize
{
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *fileName = [NSString stringWithFormat:@"%.0lf.jpg",[NSDate date].timeIntervalSince1970*1000];
    tmpPath = [tmpPath stringByAppendingPathComponent:fileName];
    [imageData writeToFile:tmpPath atomically:YES];
    return tmpPath;
}

+ (UIImage *)imageWithUIView:(UIView*)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

+ (UIImage *)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (UIImage *)roundedRectWithSize:(CGSize)size radius:(CGFloat)r
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, r, r);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

- (UIImage *)transformtoSize:(CGSize)newSize
{
    // 创建一个bitmap的context
    UIGraphicsBeginImageContext(newSize);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *TransformedImg=UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return TransformedImg;
}

+(UIImage *)imageWithBase64String:(NSString *)base64String
{
    if (!base64String.length) {
        return nil;
    }
    
    if ([base64String hasPrefix:@"data"]) {
        
        NSArray * dataArr = [base64String componentsSeparatedByString:@","];
        if (dataArr.count == 2) {
            base64String = dataArr.lastObject;
        }else{
            return nil;
        }
    }
    
    NSData * data = [[NSData alloc]initWithBase64EncodedString:base64String options:0];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

-(NSString *)toBase64String
{
    NSData *imageData = UIImageJPEGRepresentation(self, 0.5);
    NSString * dataString = [imageData base64EncodedStringWithOptions:0];
    
    return [NSString stringWithFormat:@"data:image/jpeg;base64,%@",dataString];
}


@end
