//
//  UIKitTools.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//  自定义创建控件工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BFLabel;
@class BFTextField;
@class BFTextView;
@class BFButton;

@interface UIKitTools : NSObject

/**
 简体字体

 @param size 字体大小

 @return 字体
 */
+ (UIFont *)projectFontWith:(CGFloat)size;

/**
 加粗字体

 @param size 字体大小

 @return 加粗字体
 */
+ (UIFont *)projectBorderFontWith:(CGFloat)size;

/**
 生成BFTextField

 @param frame     frame
 @param font      字体大小
 @param textColor 字体颜色

 @return textField
 */
+ (BFTextField *)textFieldWith:(CGRect)frame
                          font:(UIFont *)font
                     textColor:(UIColor *)textColor;

/**
 生成BFLabel

 @param frame     frame

 @param font      字体大小
 @param textColor 字体颜色

 @return label
 */
+ (BFLabel *)labelWith:(CGRect)frame
                  font:(UIFont *)font
             textColor:(UIColor *)textColor;

/**
 生成BFTextView

 @param frame       frame
 @param font        字体大小
 @param placeholder 默认显示
 @param textColor   字体颜色

 @return textView
 */
+ (BFTextView *)textViewWith:(CGRect)frame
                        font:(UIFont *)font
                 placeholder:(NSString *)placeholder
                   textColor:(UIColor *)textColor;

/**
 生成 BFButton

 @param frame     frame
 @param font      标题文字
 @param titleText 字体大小
 @param textColor 字体颜色
 @param tag       背景图片

 @return button
 */
+ (BFButton *)buttonWith:(CGRect)frame
                    font:(UIFont *)font
                   title:(NSString *)titleText
               textColor:(UIColor *)textColor
                     tag:(NSInteger)tag;


/**
 默认字体

 @return font
 */
+ (UIFont *)defaultFont;


/**
 默认颜色

 @return color
 */
+ (UIColor *)defaultColor;

@end
