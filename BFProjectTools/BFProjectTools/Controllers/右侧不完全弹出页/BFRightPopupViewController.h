//
//  BFRightPopupViewController.h
//  BFProjectTools
//
//  Created by Janmy on 16/10/25.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFRootViewController.h"

@interface BFRightPopupViewController : BFRootViewController
{
    CGFloat _screenWidth;
    CGFloat _screenHeight;
    UIButton *hideButton;
    UIView *_superView;
    UIView *_coverView;
}


/**
 初始化

 @param senderView 需要弹出侧栏的父视图

 @return 弹出页控制器
 */
- (instancetype)initWithSuperView:(UIView*)senderView;

/**
 弹出
 */
- (void)showPopupView;

/**
 收起
 */
- (void)hidePopupView;



/**
 是否使用导航栏（弹出页需要进行多级跳转时建议使用），default is NO
 */
@property (nonatomic,assign) BOOL naviEnable;

/**
 naviEnable = YES 时的导航控制器
 */
@property (nonatomic,strong) UINavigationController *navi;

/**
 弹出页缩进宽度
 */
@property (nonatomic,assign) CGFloat offSet;

/**
 从右侧还是左侧弹出，default is YES
 */
@property (nonatomic,assign) BOOL isFromRight;



@end
