//
//  BFCrashLogViewController.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFCrashLogViewController.h"

@interface BFCrashLogViewController ()

@end

@implementation BFCrashLogViewController

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
    [self createMyNavigationBarWithBgImageName:nil andTitle:@"程序崩溃日志" andLeftItemTitles:nil andLeftItemBgImageNames:@[@"arrow_left"] andRightItemTitles:nil andRightItemBgImageNames:nil andClass:self andSEL:@selector(navigationAction:) andIsFullStateBar:YES];
}

- (void)initUI
{
    BFButton *requestButton = [UIKitTools buttonWith:CGRectMake(OffSetX, NavigationBarHeight + 20, SCREEN_WIDTH - OffSetX*2, 30) font:[UIKitTools defaultFont] title:@"点击进行测试" textColor:[UIKitTools defaultColor] tag:0];
    requestButton.backgroundColor = [UIColor cyanColor];
    [requestButton addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:requestButton];
}

#pragma mark - ButtonAction

- (void)btnAction
{
    // 常见异常崩溃示例
    
    // 不存在方法引用
    //[self performSelector:@selector(thisMthodDoesNotExist) withObject:nil];
    
    // 键值对引用nil
    //[[NSMutableDictionary dictionary] setObject:nil forKey:@"nil"];
    
    // 数组越界
    [[NSArray array] objectAtIndex:1];
    
    // memory warning 级别3以上
    //[self performSelector:@selector(killMemory) withObject:nil];
}

// 模拟内存警告
- (void) killMemory

{
    for (int i = 0; i < 30000; i ++){
        UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 200)];
        tmpLabel.layer.masksToBounds = YES;
        tmpLabel.layer.cornerRadius = 10;
        tmpLabel.backgroundColor = [UIColor redColor];
        [self.view addSubview:tmpLabel];
    }
}

- (void)navigationAction:(BFButton *)btn
{
    [self backToPreviousViewIfPop:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
