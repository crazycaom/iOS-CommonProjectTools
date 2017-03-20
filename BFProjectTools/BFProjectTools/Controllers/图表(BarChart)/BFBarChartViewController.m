//
//  BFBarChartViewController.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFBarChartViewController.h"
#import "BezierCurveBarView.h"

@interface BFBarChartViewController ()
{
    BFView                                  *_navigationView;
    
    UIButton                                *_allStyle;
}

// barChartView
@property(nonatomic,strong) BezierCurveBarView *barChartView;

// x轴坐标值
@property (strong,nonatomic)NSMutableArray  *x_names;

// y轴目标设定值
@property (strong,nonatomic)NSMutableArray  *y_targets;

// 选中类型
@property(nonatomic,strong) UISegmentedControl  *segSelectType;

@end

@implementation BFBarChartViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initUI];
}

#pragma mark - init

- (void)initUI
{
    // 隐藏真实的NavigationBar
    self.navigationController.navigationBarHidden = YES;
    
    _navigationView = [[BFView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight-40)];
    _navigationView.backgroundColor = NavigationBackgroundColor;
    [self.view addSubview:_navigationView];
    
    BFButton *backButton = [UIKitTools buttonWith:CGRectMake(OffSetX, (_navigationView.height-20)/2, 20, 20) font:nil title:nil textColor:nil tag:0];
    [backButton setBackgroundImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(navigationAction:) forControlEvents:UIControlEventTouchUpInside];
    backButton.transform = CGAffineTransformScale(backButton.transform, 0.8, 0.8);
    [_navigationView addSubview:backButton];
    
    BFLabel *titleLabel = [UIKitTools labelWith:CGRectMake(0, (_navigationView.height - 24)/2, SCREEN_WIDTH, 24) font:[UIKitTools projectBorderFontWith:13] textColor:NavigationBarFontColor];
    titleLabel.text = @"BarChart";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    [self.view addSubview:self.segSelectType];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(OffSetX, CGRectGetMaxY(self.segSelectType.frame)+4, 50, 20)];
    [btn setTitle:@"绘制" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blueColor];
    btn.tag = 1;
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:btn];
    
    UIButton *btnDraw = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, CGRectGetMaxY(self.segSelectType.frame)+4, 50, 20)];
    [btnDraw setTitle:@"刷新" forState:UIControlStateNormal];
    [btnDraw addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    btnDraw.backgroundColor = [UIColor blueColor];
    btnDraw.tag = 2;
    btnDraw.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:btnDraw];
    
    // 所有样式
    _allStyle = [[UIButton alloc]initWithFrame:CGRectMake((self.view.width - 100)/2, CGRectGetMaxY(self.segSelectType.frame)+4, 100, 20)];
    _allStyle.backgroundColor = [UIColor whiteColor];
    [_allStyle addBorderLineWithLineColor:[UIColor blueColor] width:1 cornerRadius:5];
    [_allStyle setTitle:@"所有样式" forState:UIControlStateNormal];
    [_allStyle setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_allStyle addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    _allStyle.tag = 3;
    [self.view addSubview:_allStyle];
}

#pragma mark - ButtonAction

- (void)change:(UIButton *)btn
{
    if(btn.tag == 1){
        // 绘制
        if(_barChartView){
            _barChartView = nil;
            [_barChartView removeFromSuperview];
        }
        
        [self.view addSubview:self.barChartView];
        
        [self initBarChart];
        
    }else if(btn.tag == 2){
        // 刷新
        [_y_targets removeAllObjects];
        _y_targets = [NSMutableArray arrayWithArray:@[@(arc4random()%6),@(arc4random()%6),@(arc4random()%6),@(arc4random()%6),@(arc4random()%6),@(arc4random()%6),@(arc4random()%6),@(arc4random()%6),@(arc4random()%6),@(arc4random()%6),@(arc4random()%6),@(arc4random()%6),@(arc4random()%6)]];
        
        // 绘制Bar
        [_barChartView drawBarChartWithTargets:_y_targets andMaxTargetValue:6 andXNames:self.x_names];
    }else{
        
        // 绘制
        if(_barChartView){
            _barChartView = nil;
            [_barChartView removeFromSuperview];
        }
        
        [self.view addSubview:self.barChartView];
    
        _segSelectType.selectedSegmentIndex = -1;
        
        // 所有样式
        // 显示XY轴刻度
        _barChartView.isShowAxiMark = YES;
        
        // 显示Y轴单位
        _barChartView.isShowYAxiUnit = YES;
        
        // bar上是否显示数值
        _barChartView.aboveBarShowTargetValue = YES;
        
        // 是否旋转X文本值
        _barChartView.isTransfromXText = YES;
        
        // 显示网格
        _barChartView.isShowGride =YES;
        
        // bar可以点击
        _barChartView.enableClickBar = YES;
        
        // bar点击高亮类型
        _barChartView.highLightType = BarHighLight;
        
        // bar点击显示showInfoView
        _barChartView.isShowInfoView = NO;
        
        // XY轴
        [_barChartView isShowXYAXi:YES andShowArrow:YES andXNames:self.x_names andMaxYTarget:6];
        
        // 绘制Bar
        [_barChartView drawBarChartWithTargets:self.y_targets andMaxTargetValue:6 andXNames:self.x_names];
    }
}

- (void)navigationAction:(BFButton *)btn
{
    [self backToPreviousViewIfPop:NO];
}

- (void)initBarChart
{
    NSInteger selectIndex = _segSelectType.selectedSegmentIndex;
    
    BOOL showAxi = NO;
    
    // 显示XY轴
    if(selectIndex == 0){
        showAxi = YES;
        // bar可以点击
        _barChartView.enableClickBar = YES;
        // bar点击高亮类型
        _barChartView.highLightType = BarHighLight;
        // bar点击显示showInfoView
        _barChartView.isShowInfoView = YES;
    }
    
    if (selectIndex == 1) {
        // 显示XY轴刻度
        _barChartView.isShowAxiMark = selectIndex == 1? YES : NO;
        // 显示XY轴
        showAxi = YES;
        // bar可以点击
        _barChartView.enableClickBar = YES;
        // bar点击高亮类型
        _barChartView.highLightType = BarHighLight;
        // bar点击显示showInfoView
        _barChartView.isShowInfoView = NO;
    }
    
    BOOL showArrow = YES;
    if(selectIndex == 2){
        // 显示Y轴单位
        _barChartView.isShowYAxiUnit = selectIndex == 2? YES : NO;
        showArrow = NO;
        showAxi = YES;
    }
    
    // bar上是否显示数值
    _barChartView.aboveBarShowTargetValue = selectIndex == 3? YES : NO;
    
    // 是否旋转X文本值
    _barChartView.isTransfromXText = selectIndex == 4? YES : NO;
    
    // 显示网格
    if(selectIndex == 5){
        _barChartView.isShowGride =YES;
        _barChartView.isShowAxiMark = YES;
        showAxi = YES;
        showArrow = NO;
        // bar可以点击
        _barChartView.enableClickBar = YES;
        // bar点击高亮类型
        _barChartView.highLightType = BarBackgroudHighLight;
        // bar点击显示showInfoView
        _barChartView.isShowInfoView = YES;
    }
    
    // 高亮样式
    if(selectIndex == 6){
        // bar可以点击
        _barChartView.enableClickBar = YES;
        // bar点击高亮类型
        _barChartView.highLightType = BarBackgroudHighLight;
        // bar点击显示showInfoView
        _barChartView.isShowInfoView = YES;
    }
    
    // XY轴
    [_barChartView isShowXYAXi:showAxi andShowArrow:showArrow andXNames:self.x_names andMaxYTarget:6];
    
    // 绘制Bar
    [_barChartView drawBarChartWithTargets:self.y_targets andMaxTargetValue:6 andXNames:self.x_names];

}

#pragma mark - get

- (BFView *)barChartView
{
    if(_barChartView){
        return _barChartView;
    }
    
    CGFloat tempWidth = 0.0;
    tempWidth = SCREEN_WIDTH-(OffSetX*2);
    
    _barChartView = [BezierCurveBarView initWithFrame:CGRectMake((SCREEN_WIDTH-tempWidth)/2, CGRectGetMaxY(_allStyle.frame)+10, tempWidth, SCREEN_HEIGHT - (CGRectGetMaxY(_allStyle.frame)+15))];
        
    return _barChartView;
}


- (NSMutableArray *)x_names
{
    if (!_x_names) {
        _x_names = [NSMutableArray arrayWithArray:@[@"1月份",@"2月份",@"3月份",@"4月份",@"5月份",@"6月份",@"7月份",@"8月份",@"9月份",@"10月份",@"11月份",@"12月份",@"test"]];
    }
    
    return _x_names;
}

-(NSMutableArray *)y_targets
{
    if (!_y_targets) {
        _y_targets = [NSMutableArray arrayWithArray:@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]];
    }
    
    return _y_targets;
}


- (UISegmentedControl *)segSelectType
{
    if(_segSelectType){
        return _segSelectType;
    }
    
    _segSelectType = [[UISegmentedControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-520)/2, CGRectGetMaxY(_navigationView.frame)+4, 520, 20)];
    [_segSelectType insertSegmentWithTitle:@"XY轴" atIndex:0 animated:NO];
    [_segSelectType insertSegmentWithTitle:@"XY轴刻度" atIndex:1 animated:NO];
    [_segSelectType insertSegmentWithTitle:@"Y轴单位" atIndex:2 animated:NO];
    [_segSelectType insertSegmentWithTitle:@"barText" atIndex:3 animated:NO];
    [_segSelectType insertSegmentWithTitle:@"旋转X文本" atIndex:4 animated:NO];
    [_segSelectType insertSegmentWithTitle:@"网格" atIndex:5 animated:NO];
    [_segSelectType insertSegmentWithTitle:@"高亮样式" atIndex:6 animated:NO];
    
    [_segSelectType addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventValueChanged];
    
    return _segSelectType;
}

- (void)selectType:(UISegmentedControl *)seg
{
    //NSLog(@"----selectIndex = %ld",seg.selectedSegmentIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
