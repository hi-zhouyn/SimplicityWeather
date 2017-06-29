//
//  Header.h
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h
/**
 *   随机色
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


#define kColorRGB(volue) volue/255.0f

//////////////////////////////项目颜色需求配置/////////////////////////

/*
 * 蓝色按钮颜色
 */
#define kColorBlue kSetRGBColor(109,204,250)//kSetColor(139,198,253)
#define kBlueButtonColor kSetRGBColor(56,162,236) //新的按钮颜色，控制蓝色按钮
#define kButtonHighlightedColor kSetRGBColor(45, 130, 189)//按钮高亮颜色

/*
 * 白色
 */
#define kColorWhite kSetRGBColor(255,255,255)

/*
 * 黑色
 */
#define kColorBlack kSetRGBColor(0,0,0)
#define kColorBlackFont kSetRGBColor(51,51,51)

/*
 * 透明色
 */
#define kColorClear [UIColor clearColor]

/*
 * ****************************线条颜色****************************
 */

/*
 * ****************************背景颜色****************************
 */
#define kColorBlueFont kSetRGBColor(40,90,146)//名字蓝色

#define kColorGrayFont_Bian kSetRGBColor(220,220,220)//边框灰色

#define kColorGrayFont_LookAll kSetRGBColor(136,136,136)//查看全部按钮灰色

#define kColorGrayFont kSetRGBColor(102,102,102)//字体灰色

#define kColorGrayFont1 kSetRGBColor(170,170,170)//字体灰色1

#define kColorGrayFont2 kSetRGBColor(216,216,216)//输入框灰色

#define kColorGrayFont3 kSetRGBColor(156,156,156)//字体灰3

#define kColorGray kSetRGBColor(242,242,242)//灰色

#define kColorDarkGray kSetRGBColor(152,152,152)//暗灰色

#define kColorBackgroundGray kSetRGBColor(239,239,244)//背景灰色

#define kColorSearchBg kSetRGBColor(220,122,170)//灰色

#define kColorOrange kSetRGBColor(246,159,40)//橘黄色

#define kColorYellow kSetRGBColor(240,223,46)//淡黄色

#define kColorOrangeRed kSetRGBColor(235,114,19)//橘红色

//#define kColorLightGray kSetRGBColor(234,236,238)//浅灰色
#define kColorLightGray kSetRGBColor(252,252,252)//浅灰色

#define kColorMiddleGray kSetRGBColor(248,248,248)//中灰色

#define kColorWhitek kSetRGBColor(255,255,255)//白色

#define kColorWhitekk kSetRGBColor(248,248,248)//白色
//----------------------------------------------------//

#define kColorPink kSetHEXColor(0xe173a4)//粉红

#define kColorTitle kSetHEXColor(0x222222)//标题/正文等主要文字

#define kColorMessage kSetHEXColor(0x666666)//辅助／一些默认等文字

#define kColorPrice kSetHEXColor(0xff2956)//价格

#define kColorTimeOut kSetHEXColor(0x929292)//失效／标志性等文字

#define kColorBg kSetHEXColor(0xf0f0f0)//背景颜色

#define kColorLine kSetHEXColor(0xe5e5e5)//分割线


#endif
