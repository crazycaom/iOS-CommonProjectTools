//
//  BFLineChartViewController.m
//  BFProjectTools
//
//  Created by Janmy on 16/11/2.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFLineChartViewController.h"
#import "BFLineChartView.h"

@interface BFLineChartViewController ()
{
    UIView *_buttonView;
    BFLineChartView *_chartView;
}

@end

@implementation BFLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //present页面本来就没有navigation
//    [self.navigationController.navigationBar setHidden:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    //自定义导航栏
    UINavigationBar *naviBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [naviBar setBackgroundColor:[UIColor whiteColor]];
    UINavigationItem *centerItem = [[UINavigationItem alloc]initWithTitle:@"LineChart"];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTag:110];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [centerItem setLeftBarButtonItem:leftButtonItem];
    [naviBar setItems:@[centerItem]];

    [self.view addSubview:naviBar];
    [self.view setBackgroundColor:[UIColor redColor]];
    
    
    _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 40)];
    [_buttonView setBackgroundColor:[UIColor yellowColor]];
    
    UIButton *refreshButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 20)];
    [refreshButton setBackgroundColor:[UIColor blueColor]];

    [refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshButton setTag:1];
    [refreshButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView addSubview:refreshButton];
    
    UIButton *curveButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(refreshButton.frame)+10, 10, 40, 20)];
    [curveButton setBackgroundColor:[UIColor blueColor]];
    [curveButton setTitle:@"弧线" forState:UIControlStateNormal];
    [curveButton setTag:2];
    [curveButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView addSubview:curveButton];
    
    UIButton *frameButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(curveButton.frame)+10, 10, 40, 20)];
    [frameButton setBackgroundColor:[UIColor blueColor]];
    [frameButton setTitle:@"网格" forState:UIControlStateNormal];
    [frameButton setTag:3];
    [frameButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView addSubview:frameButton];
    
    UIButton *lineColor = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(frameButton.frame)+10, 10, 40, 20)];
    [lineColor setBackgroundColor:[UIColor blueColor]];
    [lineColor setTitle:@"换色" forState:UIControlStateNormal];
    [lineColor setTag:4];
    [lineColor addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView addSubview:lineColor];
    
    UIButton *restore = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineColor.frame)+10, 10, 40, 20)];
    [restore setBackgroundColor:[UIColor blueColor]];
    [restore setTitle:@"还原" forState:UIControlStateNormal];
    [restore setTag:5];
    [restore addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView addSubview:restore];
    
    //X轴坐标值展示与否
    UIButton *XLabel = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(restore.frame)+10, 10, 40, 20)];
    [XLabel setBackgroundColor:[UIColor blueColor]];
    [XLabel setTitle:@"X值" forState:UIControlStateNormal];
    [XLabel setTag:6];
    [XLabel addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView addSubview:XLabel];
    
    //Y轴坐标值展示与否
    UIButton *YLabel = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(XLabel.frame)+10, 10, 40, 20)];
    [YLabel setBackgroundColor:[UIColor blueColor]];
    [YLabel setTitle:@"Y值" forState:UIControlStateNormal];
    [YLabel setTag:7];
    [YLabel addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView addSubview:YLabel];
    
    _chartView = [[BFLineChartView alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, self.view.height-90)];
    [_chartView createLineChart];
    
    [self.view addSubview:_buttonView];
    [self.view addSubview:_chartView];
}

#pragma mark - buttonAction
- (void)buttonClick:(UIButton*)sender{
    switch (sender.tag) {
        case 110:
            [self dismissViewControllerAnimated:YES completion:nil];

            break;
        case 1:
            [_chartView createLineChart];
            break;
        case 2:
            _chartView.enableBezierCurve = !_chartView.enableBezierCurve;
            [_chartView refreshGraph];
            break;
        case 3:
            _chartView.enableReferenceAxisFrame = !_chartView.enableReferenceAxisFrame;
            [_chartView refreshGraph];
            break;
        case 4:
            _chartView.colorLine = [UIColor blackColor];
            _chartView.colorTop = [UIColor blueColor];
            _chartView.colorBottom = [UIColor grayColor];
            _chartView.colorPoint = [UIColor yellowColor];
            
            [_chartView refreshGraph];
            break;
        case 5:
            _chartView.colorLine = nil;
            _chartView.colorTop = nil;
            _chartView.colorBottom = nil;
            _chartView.colorPoint = nil;
            
            [_chartView refreshGraph];
            break;
        case 6:
            _chartView.enableXAxisLabel = !_chartView.enableXAxisLabel;
            
            [_chartView refreshGraph];
            break;
        case 7:
            _chartView.enableYAxisLabel = !_chartView.enableYAxisLabel;
            
            [_chartView refreshGraph];
            break;
            
        default:
            break;
    }
}
#pragma mark - 强制进行右屏处理

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
