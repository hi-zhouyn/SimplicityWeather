//
//  FontMacro.h
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#ifndef FontMacro_h
#define FontMacro_h

//打印所有字体

#define kShowAllFonts {\
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];\
    NSArray *fontNames;\
    NSInteger indFamily, indFont;\
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily){\
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);\
        fontNames = [[NSArray alloc] initWithArray:\
                     [UIFont fontNamesForFamilyName:\
                      [familyNames objectAtIndex:indFamily]]];\
        for (indFont=0; indFont<[fontNames count]; ++indFont){\
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);\
        }\
    }\
}\


#define kBaseSetFontOfSize(fontName,customsize) [UIFont fontWithName:fontName size:customsize*kAUTOLAYOUTSCALE]
#define kBaseSetFontOfSize_iPhone5(fontName,customsize) [UIFont fontWithName:fontName size:customsize*kAUTOLAYOUTSCALE_iPhone5]
#define kBaseSetFontOfSize_iPhone6Plus(fontName,customsize) [UIFont fontWithName:fontName size:customsize*kAUTOLAYOUTSCALE_iPhone6Plus]

#define kSetSystemFontOfSize(FONTSIZE) [UIFont systemFontOfSize:FONTSIZE * kAUTOLAYOUTSCALE]

#define kCustomFontOfSize(customsize) kBaseSetFontOfSize(@"PingHei-Text",customsize)

//STHeiti

#define kFontHuaWenOfSize(customsize) kBaseSetFontOfSize(@"STHeiti",customsize)

//FZLTCHJW--GB1-0

#define kFontLanTingOfSize(customsize) kBaseSetFontOfSize(@"FZLTCHJW--GB1-0",customsize)


//////////////////////////项目字体需求配置//////////////////////////////
//中文／价格 kFontHuaWenOfSize
//粗体价格 kFontLanTingOfSize


#define kFontNavBarPink kFontTitle//导航栏

#define kFontNavBarGray kFontTitle

#define kFontTitle kFontHuaWenOfSize(18) //导航栏/大标题

#define kFontButton kFontHuaWenOfSize(17) //常用按钮

#define kFontHeader kFontHuaWenOfSize(16) //表单头部

#define kFontProName kFontHuaWenOfSize(14) //正文／零食名称

#define kFontMessage kSetSystemFontOfSize(12) //属性数量辅助性文字



#define kFontTitle_blod kFontHuaWenOfSize(18) //导航栏/大标题

#define kFontButton_blod kFontHuaWenOfSize(17) //常用按钮

#define kFontHeader_blod kFontHuaWenOfSize(16) //表单头部

#define kFontProName_blod kFontHuaWenOfSize(14) //正文／零食名称

#define kFontMessage_blod kSetSystemFontOfSize(12) //属性数量辅助性文字

#endif
