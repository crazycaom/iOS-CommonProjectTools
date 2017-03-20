//
//  BFRightPopupViewController.m
//  BFProjectTools
//
//  Created by Janmy on 16/10/25.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFRightPopupViewController.h"

@interface BFRightPopupViewController ()

@end

@implementation BFRightPopupViewController

#pragma mark - init
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
    }
    
    return self;
    
}

- (instancetype)initWithSuperView:(UIView *)senderView{
    if (self) {
        
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        _superView = senderView;
        
        _offSet = 40.0;
        
    }
    
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)createView{
    //遮盖视图阴影效果
    _coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_coverView setBackgroundColor:[UIColor blackColor]];
    [_coverView setAlpha:0.0];
    
    UIButton *coverButton = [[UIButton alloc]initWithFrame:_coverView.bounds];
    [coverButton setBackgroundColor:[UIColor clearColor]];
    [coverButton addTarget:self action:@selector(hidePopupView) forControlEvents:UIControlEventTouchUpInside];
    
    [_coverView addSubview:coverButton];
    
    
    [_superView addSubview:_coverView];
    
    if (_isFromRight) {
        [self.navi.view setFrame:CGRectMake(_screenWidth, 0, _screenWidth - _offSet, _screenHeight)];
    }else{
        [self.navi.view setFrame:CGRectMake(-_screenWidth, 0, _screenWidth - _offSet, _screenHeight)];
    }
    [self.view setBackgroundColor:[UIColor redColor]];
    
    hideButton = [[UIButton alloc]initWithFrame:CGRectMake(150, 150, 60,40)];
    [hideButton setTitle:@"收起" forState:UIControlStateNormal];
    [hideButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [hideButton setBackgroundColor:[UIColor orangeColor]];
    [hideButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:hideButton];
    [_superView addSubview:self.navi.view];
}

- (void)buttonAction:(UIButton*)sender{
    [self hidePopupView];
}

#pragma mark - animation

- (void)showPopupView{
    [self createView];
    
    CGRect rect;
    
    if (_isFromRight) {
        rect = CGRectMake(_offSet, 0, _screenWidth - _offSet, _screenHeight);
    }else{
        rect = CGRectMake(0, 0, _screenWidth - _offSet, _screenHeight);
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    [_coverView setAlpha:0.5];
    [self.navi.view setFrame:rect];
    
    [UIView commitAnimations];
    
}
- (void)hidePopupView{
    
    CGRect rect;
    
    if (_isFromRight) {
        rect = CGRectMake(_screenWidth, 0, _screenWidth - _offSet, _screenHeight);
    }else{
        rect = CGRectMake(-(_screenWidth-_offSet), 0, _screenWidth - _offSet, _screenHeight);
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDidStopSelector:@selector(didHidenPopupView)];
    
    [_coverView setAlpha:0.0];
    [self.navi.view setFrame:rect];
    
    [UIView commitAnimations];
    
}
- (void)didHidenPopupView{
    [_coverView removeFromSuperview];
    [self.view removeFromSuperview];

}


@end
