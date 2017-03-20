//
//  BFRootViewController.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFRootViewController.h"

@interface BFRootViewController ()

@end

@implementation BFRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createViewController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self updateViewController];
}

// 创建视图
- (void)createViewController
{
    
}

// 更新视图
- (void)updateViewController
{
    
}

// 创建导航栏
- (void)createMyNavigationBarWithBgImageName:(NSString *)bgImageName andTitle:(NSString *)title andLeftItemTitles:(NSArray *)leftItemTitles andLeftItemBgImageNames:(NSArray *)leftItemBgImageNames andRightItemTitles:(NSArray *)rightItemTitles andRightItemBgImageNames:(NSArray *)rightItemBgImageNames andClass:(id)classObject andSEL:(SEL)sel andIsFullStateBar:(BOOL)isFillStateBar
{
    
    CGFloat navigationBarHeight = 44;
    CGFloat offSetY = 20;
    if (isFillStateBar) {
        navigationBarHeight = 64;
        offSetY = 0;
    }
    
    BFNavigationBarView *mnb=[[BFNavigationBarView alloc]init];
    mnb.frame=CGRectMake(0, offSetY, self.view.frame.size.width, navigationBarHeight);
    mnb.backgroundColor = NavigationBackgroundColor;
    [mnb createMyNavigationBarWithBgImageName:bgImageName andTitle:title andLeftItemTitles:leftItemTitles andLeftItemBgImageNames:leftItemBgImageNames andRightItemTitles:rightItemTitles andRightItemBgImageNames:rightItemBgImageNames andClass:classObject andSEL:sel andIsFullStateBar:isFillStateBar];
    [self.view addSubview:mnb];
    
    
    
}

// 返回上一个界面
- (void)backToPreviousViewIfPop:(BOOL)isPop
{
    [self closeKeyboard];
    
    if (isPop) {
        // Navigation
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        // Model
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

// 关闭键盘
- (void)closeKeyboard
{
    [self.view endEditing:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self closeKeyboard];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 所有页面控制为竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
