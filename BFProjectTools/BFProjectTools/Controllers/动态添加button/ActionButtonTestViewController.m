//
//  ActionButtonTestViewController.m
//  BFProjectTools
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "ActionButtonTestViewController.h"
#import "BFActionView.h"
#import "ToastManager.h"

@interface ActionButtonTestViewController ()
{
    BFActionView *_actionView;
}

@end

@implementation ActionButtonTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //deleteBtn
    //
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.center.y + 44, SCREEN_WIDTH / 9.0, 44)];
    [deleteBtn setTitle:@"-" forState:UIControlStateNormal];
    deleteBtn.layer.borderWidth = 1;
    deleteBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    [deleteBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    //actionView
    //
    _actionView = [[BFActionView alloc] initWithIdentify:@"1"];
    _actionView.frame = CGRectMake(deleteBtn.maxX, deleteBtn.y, SCREEN_WIDTH * 7.0 / 9, 44);
    [self.view addSubview:_actionView];
    
    //insertBtn
    //
    UIButton *insertBtn = [[UIButton alloc] initWithFrame:CGRectMake(_actionView.maxX, deleteBtn.y, SCREEN_WIDTH / 9.0, 44)];
    [insertBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    insertBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    insertBtn.layer.borderWidth = 1;
    [insertBtn setTitle:@"+" forState:UIControlStateNormal];
    [insertBtn addTarget:self action:@selector(insertBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insertBtn];
    
}

- (void)insertBtn {
    int number = arc4random() % 100 + 10;
    NSString *title = [NSString stringWithFormat:@"%d",number];
    UIColor *randomColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    [_actionView addButtonWithTitle:title titleColor:randomColor selectBlock:^{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
        label.backgroundColor = [UIColor darkGrayColor];
        label.layer.borderWidth = 1;
        label.layer.borderColor = [UIColor lightGrayColor].CGColor;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = title;
        
        [[ToastManager shareManager] toastAView:label];
    }];
}

- (void)deleteBtn {
    [_actionView removeButtonAtIndex:0];
}

@end
