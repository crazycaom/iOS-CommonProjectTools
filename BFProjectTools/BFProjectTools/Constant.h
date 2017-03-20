//
//  Constant.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

// 定义项目常量

// 左边距
#define OffSetX 10

// 屏幕宽高
#define SCREEN_WIDTH           [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT          [UIScreen mainScreen].bounds.size.height

// 导航栏高度
#define NavigationBarHeight 64

// 导航栏背景颜色
#define NavigationBackgroundColor [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1.00f]

// 导航栏字体颜色
#define NavigationBarFontColor [UIColor colorWithRed:0.54f green:0.76f blue:0.22f alpha:1.00f]

// 常用日期格式
#define DateFormatterForYYMMDD @"yyyy-MM-dd"
#define FormatterForYearMonth @"yyyy-MM"
#define YYMMDDFORMATTER     @"yy/MM/dd"
#define DateFormatterForHourMm @"HH:mm"
#define FormatterForYYMMDDHHMM @"yy/MM/dd HH:mm"
#define DateFormatterForCompleteYMDHM @"yyyy年MM月dd日 HH:mm"

#endif /* Constant_h */
