//
//  BFTextField.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//  自定义UITextField

#import <UIKit/UIKit.h>

@interface BFTextField : UITextField


/**
 TextField 左边空出边距

 @param textField 要设置的textField
 @param leftWidth 左边距
 */
+ (void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth;

@end
