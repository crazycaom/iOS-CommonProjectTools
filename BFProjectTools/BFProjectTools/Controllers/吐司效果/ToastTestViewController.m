//
//  ToastTestViewController.m
//  BFProjectTools
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "ToastTestViewController.h"
#import "ToastManager.h"

@interface ToastTestViewController ()

@end

@implementation ToastTestViewController
int count = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(60, SCREEN_HEIGHT - 64 - 50, SCREEN_WIDTH - 120, 35)];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    [btn setTitle:@"显示一个toast" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showToast) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)showToast {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    label.backgroundColor = [UIColor darkGrayColor];
    label.layer.borderColor = [UIColor grayColor].CGColor;
    label.layer.borderWidth = 1;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"这是第%d次测试!",count];
    count ++;
    label.textColor = [UIColor whiteColor];
    
    [[ToastManager shareManager] toastAView:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
