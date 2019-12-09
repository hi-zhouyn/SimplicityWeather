//
//  ColorMacro.h
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/28.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

/**
 *  随机色
 */
#define HRRandomColor HRColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/**
 *  RGB 设置颜色
 */
#define kBaseSetRGBColor(rd,ge,be,al) ([UIColor colorWithRed:rd/255.0f green:ge/255.0f blue:be/255.0f alpha:al])

#define kSetRGBColorWithAlpha(rd,ge,be,al) kBaseSetRGBColor(rd,ge,be,al)

#define kSetRGBColor(rd,ge,be) kBaseSetRGBColor(rd,ge,be,1)

/**
 *  HEX 16进制 设置颜色
 */
#define kBaseSetHEXColor(rgbValue,al) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(al)])

#define kSetHEXColorWithAlpha(rgbValue,al) kBaseSetHEXColor(rgbValue,al)

#define kSetHEXColor(rgbValue) kBaseSetHEXColor(rgbValue,1)


//////////////////////////////项目颜色需求配置/////////////////////////

#define KColorClear     [UIColor clearColor] //透明色
#define KColorWhite     [UIColor whiteColor] //白色
#define KColorBlack     [UIColor blackColor] //黑色
#define KColorBlue      kSetHEXColor(0x8fe0fb)//蓝色
#define kColorTextGray  kSetHEXColor(0x858585)//文字灰
#define KColorBGBlue    kSetHEXColor(0xCCE1E5)//背景淡蓝色

#define kColorMain   kSetHEXColor(0x707070)//主题颜色
#define kColorBg     kSetHEXColor(0xeeeeee)//背景颜色
#define kColorLine   kSetHEXColor(0xe5e5e5)//分割线


#define kColorGreen        kSetHEXColor(0x07fd04)//绿色
#define kColorYellow       kSetHEXColor(0xffff00)//黄色
#define kColorOrange       kSetHEXColor(0xff7805)//橙色
#define kColorRed          kSetHEXColor(0xfa0400)//红色
#define kColorPurple       kSetHEXColor(0x9e014f)//紫色
#define kColorDeepPurple   kSetHEXColor(0x790222)//深紫色

#endif /* ColorMacro_h */
