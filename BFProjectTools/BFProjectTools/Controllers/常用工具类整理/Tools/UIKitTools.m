//
//  UIKitTools.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "UIKitTools.h"
#import "BFLabel.h"
#import "BFTextField.h"
#import "BFTextView.h"
#import "BFButton.h"

@implementation UIKitTools

#pragma mark - 默认 字体 & 颜色

+ (UIFont *)projectFontWith:(CGFloat)size
{
    //return [UIFont fontWithName:@"Avenir-Book" size:size];
    return [UIFont systemFontOfSize:size];
}

+ (UIFont *)projectBorderFontWith:(CGFloat)size
{
    //return [UIFont fontWithName:@"Avenir-Book" size:size];
    return  [UIFont boldSystemFontOfSize:size];
}

+ (UIFont *)defaultFont
{
    return [UIKitTools projectFontWith:17];
}

+ (UIColor *)defaultColor
{
    return [UIColor darkTextColor];
}

#pragma mark - CreateTools

+ (BFTextField *)textFieldWith:(CGRect)frame
                          font:(UIFont *)font
                     textColor:(UIColor *)textColor
{
    BFTextField *textField =  [[BFTextField alloc]initWithFrame:frame];
    if (font == nil) {
        font  = [UIKitTools defaultFont];
    }
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (textColor == nil) {
        textColor = [UIKitTools defaultColor];
    }
    
    textField.textColor = textColor;
    textField.font = font;
    return textField;
}

+ (BFLabel *)labelWith:(CGRect)frame
                  font:(UIFont *)font
             textColor:(UIColor *)textColor
{
    if (font == nil) {
        font  = [UIKitTools defaultFont];
    }
    
    if (textColor == nil) {
        textColor = [UIKitTools defaultColor];
    }
    
    BFLabel *label = [[BFLabel alloc]initWithFrame:frame];
    label.font = font;
    label.textColor = textColor;
    return label;
}

+ (BFTextView *)textViewWith:(CGRect)frame
                        font:(UIFont *)font
                 placeholder:(NSString *)placeholder
                   textColor:(UIColor *)textColor
{
    if (font == nil) {
        font  = [UIKitTools defaultFont];
    }
    
    if (textColor == nil) {
        textColor = [UIKitTools defaultColor];
    }
    
    BFTextView *textView = [[BFTextView alloc]initWithFrame:frame];
    [textView setFont:font];
    textView.placeholder = placeholder;
    textView.textColor = textColor;
    return textView;
}


+ (BFButton *)buttonWith:(CGRect)frame
                    font:(UIFont *)font
                   title:(NSString *)titleText
               textColor:(UIColor *)textColor
                     tag:(NSInteger)tag
{
    BFButton *customButton = [BFButton buttonWithType:UIButtonTypeCustom];
    [customButton setFrame:frame];
    customButton.tag = tag;
    
    if (titleText) {
        if (font == nil) {
            font = [UIKitTools defaultFont];
        }
        
        if (textColor == nil) {
            textColor = [UIKitTools defaultColor];
        }
        [customButton setTitle:titleText forState:UIControlStateNormal];
        customButton.titleLabel.font = font;
        [customButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    
    return customButton;
}


@end
