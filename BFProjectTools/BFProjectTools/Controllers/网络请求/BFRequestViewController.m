//
//  BFRequestViewController.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFRequestViewController.h"

@interface BFRequestViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray                          *_muArrNotice;
}

@property(nonatomic,strong) UITableView     *noticeTableView;
@end

@implementation BFRequestViewController

- (void)createViewController
{
    _muArrNotice = [NSMutableArray array];
    
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
    [self createMyNavigationBarWithBgImageName:nil andTitle:@"网络请求" andLeftItemTitles:nil andLeftItemBgImageNames:@[@"arrow_left"] andRightItemTitles:nil andRightItemBgImageNames:nil andClass:self andSEL:@selector(navigationAction:) andIsFullStateBar:YES];
}

- (void)initUI
{
    BFButton *requestButton = [UIKitTools buttonWith:CGRectMake(OffSetX, NavigationBarHeight + 20, SCREEN_WIDTH - OffSetX*2, 30) font:[UIKitTools defaultFont] title:@"点击进行测试请求数据" textColor:[UIKitTools defaultColor] tag:0];
    requestButton.backgroundColor = [UIColor cyanColor];
    [requestButton addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:requestButton];
    
    [self.view addSubview:self.noticeTableView];

}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_muArrNotice count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    BFMyNoticeModel *notice = [_muArrNotice objectAtIndex:indexPath.row];
    cell.textLabel.text = notice.content;
    
    return cell;
}

#pragma mark - RequestAndResponse

// 请求网络成功
- (void)serviceDidSucceed:(NSDictionary *)responseData method:(NSString *)aMethod
{
    [BFUtils hudSuccessHidden];
    
    if([aMethod isEqualToString:MyNotice]){
        
        NSArray *noticeArray = [responseData objectForKey:@"data"];
        for (NSDictionary *dict in noticeArray) {
            BFMyNoticeModel *notice = [[BFMyNoticeModel alloc] init];
            [notice parseFromDictionary:dict];
            [_muArrNotice addObject:notice];
        }
        
        [_noticeTableView reloadData];
    }
}

// 请求网络失败
- (void)serviceDidFailed:(NSString *)failedMessage method:(NSString *)aMethod
{
    [BFUtils hudSuccessHidden];
    [BFShowBox showMessage:@"获取失败!"];
}

#pragma mark - ButtonAction

- (void)btnAction
{
    // 请求数据 (application/json)
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"dgcs11" forKey:@"userName"];
    [dict setObject:@"8" forKey:@"pageSize"];
    [dict setObject:@"1" forKey:@"pageNumber"];
    [BFUtils hudShow];
    [self executeRequestWithURL:MyNotice para:dict];
}

- (void)navigationAction:(BFButton *)btn
{
    [self backToPreviousViewIfPop:YES];
}

#pragma mark - get

- (UITableView *)noticeTableView
{
    if(_noticeTableView){
        return _noticeTableView;
    }
    
    _noticeTableView = [[UITableView alloc] initWithFrame:CGRectMake(OffSetX, NavigationBarHeight+70, SCREEN_WIDTH-OffSetX*2, SCREEN_HEIGHT - NavigationBarHeight-90) style:UITableViewStylePlain];
    _noticeTableView.delegate = self;
    _noticeTableView.dataSource = self;
    
    return _noticeTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
