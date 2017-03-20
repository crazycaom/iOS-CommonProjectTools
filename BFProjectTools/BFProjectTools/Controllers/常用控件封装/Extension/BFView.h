//
//  BFView.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//  自定义UIView

#import <UIKit/UIKit.h>

@interface BFView : UIView

/**
 创建画面
 */
- (void)createView;

/**
 刷新画面
 */
- (void)refreshView;

/**
 关闭键盘
 */
- (void)closeKeyboard;

@end
