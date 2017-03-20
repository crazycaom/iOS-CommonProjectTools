//
//  UIViewController+BFPopupViewController.h
//  弹出视图Demo
//
//  Created by CaoMeng on 16/8/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , BFPopupViewAnimation) {
    
    ////// 底部 -> 顶部
    BFPopupViewAnimationSlideBottomTop = 1,
    
    ////// 右边 -> 左边
    BFPopupViewAnimationSlideRightLeft,
    
    ////// 底部 -> 底部
    BFPopupViewAnimationSlideBottomBottom,
    
    ////// 渐变消失
    BFPopupViewAnimationFade
    
};

@interface UIViewController (BFPopupViewController)

// popViewAction
- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(BFPopupViewAnimation)animationType;

// dismissPopViewAction
- (void)dismissPopupViewControllerWithanimationType:(BFPopupViewAnimation)animationType;

@end
