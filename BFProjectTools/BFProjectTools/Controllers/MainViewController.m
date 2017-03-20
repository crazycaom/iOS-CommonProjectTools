//
//  MainViewController.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "MainViewController.h"
#import "BFDatebaseTestViewController.h"
#import "Base64TestViewController.h"
#import "FileHelpTestViewController.h"
#import "ToastTestViewController.h"
#import "ActionButtonTestViewController.h"
#import "PieChartTestViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray                                 *_listArray;
    
    //示例用参数
    BOOL _isRight;
}

@property(nonatomic,strong) UITableView     *listTableView;

@end

@implementation MainViewController

- (void)updateViewController
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)createViewController
{
    [self initData];
    
    [self initUI];
}

- (void)initData
{
    NSString *path = [NSString stringWithFormat:@"%@/mainList.plist", [[NSBundle mainBundle] resourcePath]];
    _listArray = [NSArray arrayWithContentsOfFile:path];
    _isRight = YES;
    //NSLog(@"---%@",_listArray);
}

- (void)initUI
{
    self.navigationItem.title = @"功能模块列表";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : NavigationBarFontColor}];
    
    [self.view addSubview:self.listTableView];
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"listCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.textLabel.text = [_listArray objectAtIndex:indexPath.row];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BFRootViewController *jumpToVC;
    UIViewController *leftVC = [[UIViewController alloc]init];
    [leftVC.view setBackgroundColor:[UIColor blackColor]];
    UIViewController *mainVC = [[UIViewController alloc]init];
    [mainVC.view setBackgroundColor:[UIColor redColor]];
    UIViewController *rightVC = [[UIViewController alloc]init];
    [rightVC.view setBackgroundColor:[UIColor greenColor]];
    
    UIView *view1 = [[UIView alloc]init];
    [view1 setBackgroundColor:[UIColor orangeColor]];
    UIView *view2 = [[UIView alloc]init];
    [view2 setBackgroundColor:[UIColor redColor]];
    UIView *view3 = [[UIView alloc]init];
    [view3 setBackgroundColor:[UIColor blackColor]];
    UIView *view4 = [[UIView alloc]init];
    [view4 setBackgroundColor:[UIColor yellowColor]];
    
    BFMultiTapViewController *multiVC = [[BFMultiTapViewController alloc]initWithViews:@[view1,view2,view3,view4] titles:@[@"橙色",@"红色",@"黑色",@"黄色"]];
    BFRightPopupViewController *popVC;
    UINavigationController *popNavi;
    CGRect rect;
    
    // 跳转到具体VC
    switch (indexPath.row) {
        case 0:
            
            jumpToVC = [[BFSlideViewController alloc]initWithLeftVC:leftVC MainVC:mainVC rightVC:rightVC];
            
            break;
        case 1:
            
            jumpToVC = multiVC;
            
            
            break;
        case 2:
            
            popVC = [[BFRightPopupViewController alloc]initWithSuperView:self.view.superview.superview.superview];
            popNavi = [[UINavigationController alloc]initWithRootViewController:popVC];
            popVC.navigationItem.title = @"弹出页";
            popVC.isFromRight = _isRight;
            popVC.navi = popNavi;
            popVC.offSet = 40;
            
            _isRight = !_isRight;
            
            break;
        case 3:
            jumpToVC = [[BFImagePickerViewController alloc]init];
            
            break;
        case 4:
            // 常用工具
            jumpToVC = [[BFCommonToolsViewController alloc] init];
            break;
        case 5:
            // 常用控件
            jumpToVC = [[BFCommonUIControlViewController alloc] init];
            break;
        case 6:
            // 网络请求
            jumpToVC = [[BFRequestViewController alloc] init];
            break;
        case 7:
            // 崩溃日志
            jumpToVC = [[BFCrashLogViewController alloc] init];
            break;
        case 8:
            // 弹出框
            jumpToVC = [[BFDIYPopViewController alloc] init];
            break;
        case 9:
            jumpToVC = [[BFDatebaseTestViewController alloc] init];
            break;
        case 10:
            jumpToVC = [[ToastTestViewController alloc] init];
            break;
        case 11:
            jumpToVC = [[Base64TestViewController alloc] init];
            break;
        case 12:
            jumpToVC = [[FileHelpTestViewController alloc] init];
            break;
        case 13:
            jumpToVC = [[ActionButtonTestViewController alloc] init];
            break;
        case 14:
            jumpToVC = [[BFLineChartViewController alloc]init];
            
            break;
        case 15:
            jumpToVC = [[BFBarChartViewController alloc] init];
            break;
        case 16:
            jumpToVC = [[PieChartTestViewController alloc] init];
            break;
        default:
            break;
    }
    
    if (indexPath.row == 2) {
        [popVC showPopupView];
    }else{
        if([jumpToVC isKindOfClass:[BFBarChartViewController class]]||[jumpToVC isKindOfClass:[BFLineChartViewController class]]){
            [self presentViewController:jumpToVC animated:YES completion:nil];
        }else{
            [self.navigationController pushViewController:jumpToVC animated:YES];
        }
    }
}


#pragma mark - get

- (UITableView *)listTableView
{
    if(_listTableView){
        return _listTableView;
    }
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight) style:UITableViewStylePlain];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    //_listTableView.backgroundColor = [UIColor redColor];
    
    return _listTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
