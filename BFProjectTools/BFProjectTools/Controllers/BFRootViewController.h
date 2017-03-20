//
//  BFRootViewController.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFRootViewController : UIViewController


/**
 创建画面，在viewDidLoad中调用
 */
- (void)createViewController;


/**
 更新画面，在viewWillAppear中调用
 */
- (void)updateViewController;


/**
 设置导航栏

 @param bgImageName           背景图片
 @param title                 标题
 @param leftItemTitles        左边按钮标题数组
 @param leftItemBgImageNames  左边按钮背景图片数组
 @param rightItemTitles       右边按钮标题数组
 @param rightItemBgImageNames 右边按钮背景图片数组
 @param classObject           classObject
 @param sel                   方法
 @param isFillStateBar        是否空出状态栏20高度
 */
- (void)createMyNavigationBarWithBgImageName:(NSString *)bgImageName andTitle:(NSString *)title andLeftItemTitles:(NSArray *)leftItemTitles andLeftItemBgImageNames:(NSArray *)leftItemBgImageNames andRightItemTitles:(NSArray *)rightItemTitles andRightItemBgImageNames:(NSArray *)rightItemBgImageNames andClass:(id)classObject andSEL:(SEL)sel andIsFullStateBar:(BOOL)isFillStateBar;

/**
 返回上一个界面

 @param isPop YES: Navigation跳转. NO: 模式对话窗体跳转.
 */
- (void)backToPreviousViewIfPop:(BOOL)isPop;


/**
 关闭键盘
 */
- (void)closeKeyboard;

@end
