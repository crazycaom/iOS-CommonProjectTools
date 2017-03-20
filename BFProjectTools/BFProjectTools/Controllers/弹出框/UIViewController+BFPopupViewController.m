//
//  UIViewController+BFPopupViewController.m
//  弹出视图Demo
//
//  Created by CaoMeng on 16/8/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "UIViewController+BFPopupViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BFPopupBackgroundView.h"

#define kPopupModalAnimationDuration 0.35
#define kBFSourceViewTag 23941
#define kBFPopupViewTag 23942
#define kBFBackgroundViewTag 23943
#define kBFOverlayViewTag 23945

@interface UIViewController (BFPopupViewControllerPrivate)

- (UIView*)topView;

- (void)presentPopupView:(UIView*)popupView;

@end

@implementation UIViewController (BFPopupViewController)

#pragma mark - popViewController && dismissViewController

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(BFPopupViewAnimation)animationType
{
    [self presentPopupView:popupViewController.view animationType:animationType];
}

- (void)dismissPopupViewControllerWithanimationType:(BFPopupViewAnimation)animationType
{
    UIView *sourceView = [self topView];
    UIView *popupView = [sourceView viewWithTag:kBFPopupViewTag];
    UIView *overlayView = [sourceView viewWithTag:kBFOverlayViewTag];
    
    if(animationType == BFPopupViewAnimationSlideBottomTop || animationType == BFPopupViewAnimationSlideBottomBottom || animationType == BFPopupViewAnimationSlideRightLeft) {
        [self slideViewOut:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
    } else {
        [self fadeViewOut:popupView sourceView:sourceView overlayView:overlayView];
    }
}


#pragma mark - 弹出视图处理
#pragma - View Handling

- (void)presentPopupView:(UIView*)popupView animationType:(BFPopupViewAnimation)animationType
{
    UIView *sourceView = [self topView];
    sourceView.tag = kBFSourceViewTag;
    popupView.tag = kBFPopupViewTag;
    
    // check if source view controller is not in destination
    if ([sourceView.subviews containsObject:popupView]) return;
    
    // customize popupView
    popupView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popupView.bounds].CGPath;
    popupView.layer.masksToBounds = NO;
    popupView.layer.shadowOffset = CGSizeMake(5, 5);
    popupView.layer.shadowRadius = 5;
    popupView.layer.shadowOpacity = 0.5;
    
    // Add semi overlay
    UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
    overlayView.tag = kBFOverlayViewTag;
    overlayView.backgroundColor = [UIColor clearColor];
    
    // BackgroundView
    BFPopupBackgroundView *backgroundView = [[BFPopupBackgroundView alloc] initWithFrame:sourceView.bounds];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.tag = kBFBackgroundViewTag;
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.alpha = 0.0f;
    [overlayView addSubview:backgroundView];
    
    // 背景添加一个Button 点击背景也可以dismissPopView
    UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.backgroundColor = [UIColor clearColor];
    dismissButton.frame = sourceView.bounds;
    [overlayView addSubview:dismissButton];
    
    popupView.alpha = 0.0f;
    [overlayView addSubview:popupView];
    [sourceView addSubview:overlayView];
    
    if(animationType == BFPopupViewAnimationSlideBottomTop) {
        [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimationTypeSlideBottomTop) forControlEvents:UIControlEventTouchUpInside];
        [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
    } else if (animationType == BFPopupViewAnimationSlideRightLeft) {
        [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimationTypeSlideRightLeft) forControlEvents:UIControlEventTouchUpInside];
        [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
    } else if (animationType == BFPopupViewAnimationSlideBottomBottom) {
        [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimationTypeSlideBottomBottom) forControlEvents:UIControlEventTouchUpInside];
        [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
    } else {
        [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimationTypeFade) forControlEvents:UIControlEventTouchUpInside];
        [self fadeViewIn:popupView sourceView:sourceView overlayView:overlayView];
    }    
}

- (UIView*)topView {
    
    UIViewController *recentView = self;
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

#pragma mark - 不同方向dismissPopViewController

// 底部 -> 顶部
- (void)dismissPopupViewControllerWithanimationTypeSlideBottomTop
{
    //[self dismissPopupViewControllerWithanimationType:BFPopupViewAnimationSlideBottomTop];
}

// 底部 -> 底部
- (void)dismissPopupViewControllerWithanimationTypeSlideBottomBottom
{
    //[self dismissPopupViewControllerWithanimationType:BFPopupViewAnimationSlideBottomBottom];
}

// 右边 -> 左边
- (void)dismissPopupViewControllerWithanimationTypeSlideRightLeft
{
    //[self dismissPopupViewControllerWithanimationType:BFPopupViewAnimationSlideRightLeft];
}

// 渐变消失
- (void)dismissPopupViewControllerWithanimationTypeFade
{
    //[self dismissPopupViewControllerWithanimationType:BFPopupViewAnimationFade];
}


#pragma mark - Animations处理

#pragma mark --- Slide

- (void)slideViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(BFPopupViewAnimation)animationType
{
    UIView *backgroundView = [overlayView viewWithTag:kBFBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupStartRect;
    if(animationType == BFPopupViewAnimationSlideBottomTop || animationType == BFPopupViewAnimationSlideBottomBottom) {
        popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2, 
                                    sourceSize.height, 
                                    popupSize.width, 
                                    popupSize.height);
    } else {
        popupStartRect = CGRectMake(sourceSize.width, 
                                    (sourceSize.height - popupSize.height) / 2,
                                    popupSize.width, 
                                    popupSize.height);
    }
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2, 
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width, 
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupStartRect;
    popupView.alpha = 1.0f;
    
    
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        backgroundView.alpha = 1.0f;
        popupView.frame = popupEndRect;
    } completion:^(BOOL finished) {
    }];
}

- (void)slideViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(BFPopupViewAnimation)animationType
{
    UIView *backgroundView = [overlayView viewWithTag:kBFBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect;
    if(animationType == BFPopupViewAnimationSlideBottomTop) {
        popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2, 
                                  -popupSize.height, 
                                  popupSize.width, 
                                  popupSize.height);
    } else if(animationType == BFPopupViewAnimationSlideBottomBottom) {
        popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2, 
                                  sourceSize.height, 
                                  popupSize.width, 
                                  popupSize.height);
    } else {
        popupEndRect = CGRectMake(-popupSize.width, 
                                  popupView.frame.origin.y, 
                                  popupSize.width, 
                                  popupSize.height);
    }
    
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        popupView.frame = popupEndRect;
        backgroundView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
    }];
}

#pragma mark --- Fade

- (void)fadeViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    UIView *backgroundView = [overlayView viewWithTag:kBFBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2, 
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width, 
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupEndRect;
    popupView.alpha = 0.0f;
    
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        backgroundView.alpha = 0.5f;
        popupView.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
}

- (void)fadeViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    UIView *backgroundView = [overlayView viewWithTag:kBFBackgroundViewTag];
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        backgroundView.alpha = 0.0f;
        popupView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
    }];
}


@end
