//
//  BFTestPopViewController.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFTestPopViewController.h"

@interface BFTestPopViewController ()

@end

@implementation BFTestPopViewController

- (void)createViewController
{
    self.view.frame = CGRectMake((self.view.frame.size.width - 300)/2, (self.view.frame.size.height - 250)/2, 300, 250);
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 可以设置点击背景进行关闭弹出视图.也可以设置点击关闭按钮关闭弹出视图.
    BFButton *closeButton = [UIKitTools buttonWith:CGRectMake((self.view.frame.size.width - 120)/2, (self.view.frame.size.height) - 40, 120, 30) font:[UIKitTools defaultFont] title:@"CloseButton" textColor:[UIKitTools defaultColor] tag:0];
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeButton addBorderLineWithLineColor:[UIColor redColor] width:1 cornerRadius:2];
    
    [self.view addSubview:closeButton];
}

- (void)closeAction
{
    if(_delegate && [_delegate respondsToSelector:@selector(closeButtonOnClick:)]){
        [_delegate closeButtonOnClick:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
