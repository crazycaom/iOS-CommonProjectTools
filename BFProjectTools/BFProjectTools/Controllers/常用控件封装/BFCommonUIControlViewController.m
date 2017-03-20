//
//  BFCommonUIControlViewController.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/17.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFCommonUIControlViewController.h"

@interface BFCommonUIControlViewController ()

@end

@implementation BFCommonUIControlViewController

- (void)createViewController
{
     [self initNavigationBar];
    
     [self initUI];
}

- (void)initNavigationBar
{
    // 用自定义的NavigationBarView 定义导航栏
    
    // 隐藏真实的NavigationBar
    self.navigationController.navigationBarHidden = YES;
    
    // 调用继承至父类的创建方法.
    [self createMyNavigationBarWithBgImageName:nil andTitle:@"常用控件封装" andLeftItemTitles:nil andLeftItemBgImageNames:@[@"arrow_left"] andRightItemTitles:nil andRightItemBgImageNames:nil andClass:self andSEL:@selector(navigationAction:) andIsFullStateBar:YES];
}

- (void)initUI
{
    // BFButton
    
    // button
    BFButton *button = [UIKitTools buttonWith:CGRectMake((SCREEN_WIDTH - 200)/2, NavigationBarHeight + 30, 200, 30) font:[UIKitTools defaultFont] title:@"我是BFButton" textColor:[UIKitTools defaultColor] tag:0];
    button.backgroundColor = [UIColor whiteColor];
    [button addBorderLineWithLineColor:[UIColor darkTextColor] width:2 cornerRadius:5];
    [button setUnread:YES];
    [self.view addSubview:button];
    
    
    // badgeButton
    BFButton *badgeButton = [UIKitTools buttonWith:CGRectMake((SCREEN_WIDTH - 200)/2, button.y + 50, 200, 30) font:[UIKitTools defaultFont] title:@"设置徽标(Button)" textColor:[UIKitTools defaultColor] tag:0];
    //[badgeButton setBadgeValue:@"10"];
    [badgeButton setBadgeValue:@"100"];
    [self.view addSubview:badgeButton];
    
    
    // BFLabel
    BFLabel *isDIYLabel = [UIKitTools labelWith:CGRectMake((SCREEN_WIDTH - 200)/2, CGRectGetMaxY(badgeButton.frame)+20, 200, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    isDIYLabel.text = @"我是BFLabel(DIY)";
    [isDIYLabel setIsDIYStyle:YES];
    isDIYLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:isDIYLabel];
    
    BFLabel *normalLabel = [UIKitTools labelWith:CGRectMake((SCREEN_WIDTH - 200)/2, CGRectGetMaxY(isDIYLabel.frame)+20, 200, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    normalLabel.text = @"我是BFLabel(Normal)";
    normalLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:normalLabel];
    
    // BFTextField
    BFTextField *textField = [UIKitTools textFieldWith:CGRectMake((SCREEN_WIDTH - 200)/2, CGRectGetMaxY(normalLabel.frame)+20, 200, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    [textField addBorderLineWithLineColor:[UIColor redColor] width:1 cornerRadius:5];
    textField.placeholder = @"BFTextField(Normal)";
    [self.view addSubview:textField];
    
    BFTextField *leftMarginTF = [UIKitTools textFieldWith:CGRectMake((SCREEN_WIDTH - 200)/2, CGRectGetMaxY(textField.frame)+20, 200, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    [leftMarginTF addBorderLineWithLineColor:[UIColor darkGrayColor] width:1 cornerRadius:5];
    [BFTextField setTextFieldLeftPadding:leftMarginTF forWidth:10];
    leftMarginTF.placeholder = @"BFTextField(Margin)";
    [self.view addSubview:leftMarginTF];
    
    // BFTextView
    NSString *placeHolderStr = @"Please input...";
    BFTextView *textView = [UIKitTools textViewWith:CGRectMake(OffSetX, CGRectGetMaxY(leftMarginTF.frame)+20, SCREEN_WIDTH - OffSetX*2, 50) font:[UIKitTools defaultFont] placeholder:placeHolderStr textColor:[UIKitTools defaultColor]];
    CGSize placeHolderSize = [placeHolderStr newCustomSizeWithFont:[UIKitTools defaultFont] constrainedToSize:CGSizeMake(textView.width, textView.height) lineBreakMode:NSLineBreakByCharWrapping];
    textView.backgroundColor = NavigationBackgroundColor;
    // TextView的PlaceHolder居中显示
    textView.placeholderFrame = CGRectMake((textView.width - placeHolderSize.width)/2, (textView.height - placeHolderSize.height)/2, placeHolderSize.width, placeHolderSize.height);
    [self.view addSubview:textView];
    
    // BFView
    BFCommonUIControlTestView *testBFView = [[BFCommonUIControlTestView alloc] initWithFrame:CGRectMake(OffSetX, CGRectGetMaxY(textView.frame)+20, SCREEN_WIDTH - OffSetX*2, 170)];
    testBFView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:testBFView];
    
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
