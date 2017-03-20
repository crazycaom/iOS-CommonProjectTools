//
//  BFShowBox.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//  自定义提醒框

#import <Foundation/Foundation.h>

@interface BFShowBox : NSObject


/**
 showMessage

 @param content 要显示的内容
 */
+(void)showMessage:(NSString *)content;


/**
 showAlertView

 @param title             标题
 @param message           显示的内容
 @param delegate          代理
 @param tag               alertView的Tag值
 @param cancelButtonTitle 取消按钮
 @param otherButtonTitles 其他按钮
 */
+(void)showAlertViewWithTitle:(NSString *)title
                      message:(NSString *)message
                     delegate:(id)delegate
                          tag:(NSInteger)tag
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles ;


/**
 ActionSheet

 @param view                   显示所在的View
 @param delegate               delegate
 @param tag                    ActionSheet Tag
 @param title                  标题
 @param cancelButtonTitle      取消按钮
 @param destructiveButtonTitle 销毁按钮
 @param otherButtonTitles      其他按钮
 */
+(void)showActionSheetInView:(UIView *)view
                    delegate:(id)delegate
                         tag:(NSInteger)tag
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelButtonTitle
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           otherButtonTitles:(NSString *)otherButtonTitles;


@end
