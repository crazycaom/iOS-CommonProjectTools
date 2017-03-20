//
//  BFDIYPopViewController.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFDIYPopViewController.h"
#import "BFTestPopViewController.h"
#import "UIViewController+BFPopupViewController.h"

@interface BFDIYPopViewController ()<DismissPopControllerDelegate>
{
    BFTestPopViewController                 *_popVC;
    
    NSInteger                               _popType;
}

@property(nonatomic,strong) UISegmentedControl  *segSelectType;

@end

@implementation BFDIYPopViewController

- (void)createViewController
{
    [self initNavigationBar];
    
    [self initUI];
}

#pragma mark - init

- (void)initNavigationBar
{
    // 用自定义的NavigationBarView 定义导航栏
    
    // 隐藏真实的NavigationBar
    self.navigationController.navigationBarHidden = YES;
    
    // 调用继承至父类的创建方法.
    [self createMyNavigationBarWithBgImageName:nil andTitle:@"自定义弹出视图" andLeftItemTitles:nil andLeftItemBgImageNames:@[@"arrow_left"] andRightItemTitles:nil andRightItemBgImageNames:nil andClass:self andSEL:@selector(navigationAction:) andIsFullStateBar:YES];
}

- (void)initUI
{
    BFButton *requestButton = [UIKitTools buttonWith:CGRectMake(OffSetX, NavigationBarHeight + 20, SCREEN_WIDTH - OffSetX*2, 30) font:[UIKitTools defaultFont] title:@"点击PopVC" textColor:[UIKitTools defaultColor] tag:0];
    requestButton.backgroundColor = [UIColor cyanColor];
    [requestButton addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:requestButton];
    
    [self.view addSubview:self.segSelectType];
    
    _popType = BFPopupViewAnimationSlideBottomTop;
    
}

#pragma mark - ButtonAction

- (void)btnAction
{
    _popVC = [[BFTestPopViewController alloc] init];
    _popVC.delegate = self;
    // 可以设置弹出的方向(四个方向)
    [self.parentViewController presentPopupViewController:_popVC animationType:_popType];
}

- (void)navigationAction:(BFButton *)btn
{
    [self backToPreviousViewIfPop:YES];
}

- (void)segSelectAction:(UISegmentedControl *)seg
{
    if(seg.selectedSegmentIndex == 0){
        _popType = BFPopupViewAnimationSlideBottomTop;
    }else if(seg.selectedSegmentIndex == 1){
        _popType = BFPopupViewAnimationSlideRightLeft;
    }else if(seg.selectedSegmentIndex == 2){
        _popType = BFPopupViewAnimationSlideBottomBottom;
    }else{
        _popType = BFPopupViewAnimationFade;
    }
}

#pragma mark - DismissPopControllerDelegate

- (void)closeButtonOnClick:(BFTestPopViewController *)popVC
{
    [self.parentViewController dismissPopupViewControllerWithanimationType:_popType];
    _popVC = nil;
}


#pragma mark - get

- (UISegmentedControl *)segSelectType
{
    if(_segSelectType){
        return _segSelectType;
    }
    
    _segSelectType = [[UISegmentedControl alloc] initWithFrame:CGRectMake(OffSetX, 150, SCREEN_WIDTH - OffSetX*2, 40)];
    [_segSelectType insertSegmentWithTitle:@"底部到顶部" atIndex:0 animated:YES];
    [_segSelectType insertSegmentWithTitle:@"左到右" atIndex:1 animated:YES];
    [_segSelectType insertSegmentWithTitle:@"底部到底部" atIndex:2 animated:YES];
    [_segSelectType insertSegmentWithTitle:@"渐变" atIndex:3 animated:YES];
    
    [_segSelectType addTarget:self action:@selector(segSelectAction:) forControlEvents:UIControlEventValueChanged];
    _segSelectType.selectedSegmentIndex = 0;
    
    return _segSelectType;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
