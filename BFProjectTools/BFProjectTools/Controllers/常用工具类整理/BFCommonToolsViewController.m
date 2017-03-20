//
//  BFCommonToolsViewController.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFCommonToolsViewController.h"

// 弹出框类型
typedef NS_ENUM(NSInteger , SelectType) {
    onlyTips = 0, // 提示消息
    tipAndSelect, // 提示和选择
    bottomPopTipSelect // 底部提示和选择
};

@interface BFCommonToolsViewController ()
{
    SelectType                               _popStyle;
}
@end

@implementation BFCommonToolsViewController

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
    
    // 只有一个返回按钮.
    [self createMyNavigationBarWithBgImageName:nil andTitle:@"常用工具类整理" andLeftItemTitles:nil andLeftItemBgImageNames:@[@"arrow_left"] andRightItemTitles:nil andRightItemBgImageNames:nil andClass:self andSEL:@selector(navigationAction:) andIsFullStateBar:YES];
    
    // 一个返回按钮. 右边两个按钮.
    //[self createMyNavigationBarWithBgImageName:nil andTitle:@"Common Tools" andLeftItemTitles:nil andLeftItemBgImageNames:@[@"arrow_left"] andRightItemTitles:@[@"查询",@"编辑"] andRightItemBgImageNames:@[@"arrow_left", @"arrow_left"] andClass:self andSEL:@selector(navigationAction:) andIsFullStateBar:YES];
}

- (void)initUI
{
    /*
     常用工具类整理: NSDate+BFDate.  NSString+Validation.  UIView+Rect.   BFNavigationBarView.  UIKitTools. 
     
     */
    
    BFLabel *tipsLabel = [UIKitTools labelWith:CGRectMake(OffSetX, NavigationBarHeight+30, SCREEN_WIDTH - OffSetX*2, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    tipsLabel.text = @"NSDate, NSString等常用方法整理见代码.";
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:tipsLabel];
    
    // 1. NSDate+BFDate
    
    // 判断当前日期是否是今天
    // 字符串转换成日期
    NSDate *date = [NSDate dateFromString:@"2016-10-20" dateFormatter:DateFormatterForYYMMDD];
    BOOL isToday = [date isToday];
    if (isToday) {
        NSLog(@"当前日期是今天");
    }else{
        NSLog(@"当前日期不是今天");
    }
    
    // 获得当前日期的是周几
    NSString *weekStr = [date weekString];
    NSLog(@"当前日期的周次是%@",weekStr);
    
    // ...
    
    
    // 2. NSString+Validation
    
    // 判断字符串是否为空
    NSString *isEmptyStr = @"I am not Empty Str";
    if (![NSString isNil:isEmptyStr]) {
        NSLog(@"非空字符串");
    }else{
        NSLog(@"空字符串");
    }
    
    // 3. 字符串去空处理
    NSString *removeNullStr = [NSString removeNull:isEmptyStr];
    NSLog(@"去除空格后的字符串=%@",removeNullStr);
    
    // 判断字符串是否是邮箱格式
    NSString *isEmailStr = @"clarence.cao@bizfocus.cn";
    if([NSString isEmailType:isEmailStr]){
        NSLog(@"邮箱格式");
    }else{
        NSLog(@"非邮箱格式");
    }
    
    // ...
    
    // 4. UIView + Rect
    
    BFLabel *borderTips = [UIKitTools labelWith:CGRectMake(OffSetX, CGRectGetMaxY(tipsLabel.frame)+20, SCREEN_WIDTH - OffSetX*2, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    borderTips.text = @"添加边框:";
    [self.view addSubview:borderTips];
    
    // 给控件添加边框
    BFView *borderView = [[BFView alloc] initWithFrame:CGRectMake(OffSetX, CGRectGetMaxY(tipsLabel.frame)+50, SCREEN_WIDTH - 2*OffSetX, 60)];
    [borderView addBorderLineWithLineColor:[UIColor redColor] width:2 cornerRadius:5];
    [self.view addSubview:borderView];
    
    // 5. UIKitTools
    
    BFLabel *kitToolsTipsLabel = [UIKitTools labelWith:CGRectMake(OffSetX, CGRectGetMaxY(borderView.frame)+20, SCREEN_WIDTH - OffSetX*2, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    kitToolsTipsLabel.text = @"UIKitTools 创建常用控件:";
    [self.view addSubview:kitToolsTipsLabel];
    
    // 创建控件
    
    // Button
    BFButton *button = [UIKitTools buttonWith:CGRectMake(OffSetX, CGRectGetMaxY(kitToolsTipsLabel.frame)+10, 100, 30) font:[UIKitTools defaultFont] title:@"测试Button" textColor:[UIKitTools defaultColor] tag:0];
    button.backgroundColor = [UIColor cyanColor];
    [button addBorderLineWithLineColor:[UIColor redColor] width:2 cornerRadius:5];
    [self.view addSubview:button];
    
    // Label
    BFLabel *label = [UIKitTools labelWith:CGRectMake(SCREEN_WIDTH - (OffSetX + 100), button.y, 100, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    label.text = @"测试Text";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor cyanColor];
    [label addBorderLineWithLineColor:[UIColor redColor] width:2 cornerRadius:5];
    [self.view addSubview:label];
    
    // TextField
    BFTextField *textField = [UIKitTools textFieldWith:CGRectMake(OffSetX, CGRectGetMaxY(label.frame)+10, SCREEN_WIDTH - OffSetX*2, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    textField.placeholder = @"Please input...";
    textField.backgroundColor = NavigationBackgroundColor;
    [self.view addSubview:textField];
    
    
    // 6. UIImageView+BFImageView
    
    BFLabel *imageViewTips = [UIKitTools labelWith:CGRectMake(OffSetX, CGRectGetMaxY(textField.frame)+10, SCREEN_WIDTH - OffSetX*2, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    imageViewTips.text = @"绘制圆型头像:";
    [self.view addSubview:imageViewTips];
    
    // 绘制圆形头像图片
    UIImageView *imageView = [UIImageView circleImageViewWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, imageViewTips.y+30, 100, 100) andImageName:@"big.jpg" andBorderColor:[UIColor redColor] andBorderWidth:5];
    [self.view addSubview:imageView];
    
    BFButton *tipButton = [UIKitTools buttonWith:CGRectMake((SCREEN_WIDTH - 100)/2, imageView.y + 100 + 20, 100, 30) font:[UIKitTools defaultFont] title:@"弹出框测试" textColor:[UIKitTools defaultColor] tag:0];
    tipButton.backgroundColor = [UIColor cyanColor];
    [tipButton addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tipButton];
    
    // 选择样式
    BFLabel *styleTipLabel = [UIKitTools labelWith:CGRectMake(OffSetX, CGRectGetMaxY(tipButton.frame)+10, SCREEN_WIDTH - OffSetX*2, 30) font:[UIKitTools defaultFont] textColor:[UIKitTools defaultColor]];
    styleTipLabel.text = @"请选择弹出框样式:";
    [self.view addSubview:styleTipLabel];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300)/2, CGRectGetMaxY(styleTipLabel.frame)+10, 300, 30)];
    [seg insertSegmentWithTitle:@"提示框" atIndex:0 animated:YES];
    [seg insertSegmentWithTitle:@"提示选择框" atIndex:1 animated:YES];
    [seg insertSegmentWithTitle:@"底部弹出选择框" atIndex:2 animated:YES];
    [self.view addSubview:seg];
    
    [seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    
    seg.selectedSegmentIndex = onlyTips;
    
}

- (void)segAction:(UISegmentedControl *)seg
{
    _popStyle = seg.selectedSegmentIndex;
}

- (void)navigationAction:(BFButton *)btn
{
    [self backToPreviousViewIfPop:YES];
}

- (void)btnAction
{
    // 7. BFShowBox
    
    if(_popStyle == onlyTips){
        [BFShowBox showMessage:@"我是弹出Tips"];
    }else if (_popStyle == tipAndSelect){
        [BFShowBox showAlertViewWithTitle:@"tisp" message:@"请填写" delegate:self tag:0 cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
    }else if(_popStyle == bottomPopTipSelect){
        [BFShowBox showActionSheetInView:self.view delegate:self tag:0 title:@"ActionSheet" cancelButtonTitle:@"取消" destructiveButtonTitle:@"撤销" otherButtonTitles:@"确定"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
