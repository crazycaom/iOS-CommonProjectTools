//
//  BFShowBox.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//  

#import "BFShowBox.h"

@implementation BFShowBox

+ (void)showMessage:(NSString *)content
{
    #if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString removeNull:content] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    #else
        //  UIAlertController *  
        //  适配iOS9以上
    #endif
}

+ (void)showAlertViewWithTitle:(NSString *)title
                      message:(NSString *)message
                     delegate:(id)delegate
                          tag:(NSInteger)tag
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles
{
    #if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:[NSString removeNull:message] delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
        alert.tag = tag;
        [alert show];
    #else
        //  UIAlertController *
        //  适配iOS9以上
    #endif
    
}

+ (void)showActionSheetInView:(UIView *)view
                    delegate:(id)delegate
                         tag:(NSInteger)tag
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelButtonTitle
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           otherButtonTitles:(NSString *)otherButtonTitles
{
    #if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
    
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
        actionSheet.tag = tag;
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:view];
    #else
        //  UIAlertController *
        //  适配iOS9以上
    #endif
}

@end
