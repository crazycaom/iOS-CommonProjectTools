//
//  PieChartTestViewController.m
//  BFProjectTools
//
//  Created by mac on 16/11/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "PieChartTestViewController.h"
#import "BFPieChartView.h"

#define kPieOffSetX 30
#define OffSetY NavigationBarHeight+30

#define PIE_HEIGHT 340

@interface PieChartTestViewController ()<PieChartDelegate >
{
    // pieValueArray
    NSMutableArray                          *_valueArray;
    
    // pieColors
    NSMutableArray                          *_colorsArray;
    
}
// pieChart
@property (nonatomic,strong) BFPieChartView *pieChartView;

// container
@property (nonatomic,strong) BFView *pieContainer;

@end

@implementation PieChartTestViewController

- (void)updateViewController
{
    _valueArray = [NSMutableArray array];
    _colorsArray = [NSMutableArray array];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"1" forKey:@"lineId"];
    
    [self initPieChartWithTargetValueCount:9];

}

- (void)createViewController
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"饼状图";
    [self initUI];
    
}

#pragma mark - init

- (void)initUI
{
    // initNavigationBar
    NSString *titleStr = @"Work Orders by Repairing Group";
    [self createMyNavigationBarWithBgImageName:nil andTitle:titleStr andLeftItemTitles:nil andLeftItemBgImageNames:@[@"back"] andRightItemTitles:nil andRightItemBgImageNames:nil andClass:self andSEL:@selector(navigationBarAction:) andIsFullStateBar:YES];
    
    // addPieContainer
    [self initPieContainer];
    
}

- (void)initPieContainer
{
    // pie容器
    CGFloat     tempWidth = SCREEN_WIDTH-(kPieOffSetX*2);
    self.pieContainer = [[BFView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-tempWidth)/2, OffSetY, tempWidth, 350)];
    self.pieContainer.backgroundColor = [UIColor clearColor];
    
    // 背景圆环图
    CGFloat width = MIN(self.pieContainer.width, self.pieContainer.height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    imageView.image = [UIImage imageNamed:@"outerRing"];
    imageView.center = CGPointMake(self.pieContainer.width / 2.0, self.pieContainer.height / 2.0);
    [self.pieContainer addSubview:imageView];
    [self.view addSubview:self.pieContainer];
    
}

#pragma mark - Action

#pragma - NavigationBarAction

- (void)navigationBarAction:(UIButton *)btn
{
    [self backToPreviousViewIfPop:YES];
}

#pragma mark - PieViewDelegate

- (void) initPieChartWithTargetValueCount:(int)count
{
    [_colorsArray removeAllObjects];
    
    if(count <= 10){
        
        NSArray *enumColors = @[
                                [UIColor colorWithRed:0.47f green:0.82f blue:0.38f alpha:1.00f],
                                [UIColor colorWithRed:0.95f green:0.89f blue:0.00f alpha:1.00f],
                                [UIColor colorWithRed:0.73f green:0.94f blue:0.67f alpha:1.00f],
                                [UIColor colorWithRed:0.94f green:0.87f blue:0.67f alpha:1.00f],
                                [UIColor colorWithRed:0.94f green:0.14f blue:0.05f alpha:1.00f],
                                [UIColor colorWithRed:0.95f green:0.65f blue:0.00f alpha:1.00f],
                                [UIColor colorWithRed:0.01f green:0.46f blue:0.95f alpha:1.00f],
                                [UIColor colorWithRed:0.64f green:0.72f blue:0.98f alpha:1.00f],
                                [UIColor colorWithRed:0.95f green:0.29f blue:0.68f alpha:1.00f],
                                [UIColor colorWithRed:0.94f green:0.67f blue:0.83f alpha:1.00f]
                                ];
        
        for(int i = 0 ; i < count ; i ++){
            [_valueArray addObject:@(arc4random()%20)];
            [_colorsArray addObject:enumColors[i]];
        }
        
    }else{
        for(int i = 0 ; i < count ; i ++){
            UIColor *randomColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
            [_colorsArray addObject:randomColor];
            [_valueArray addObject:@(arc4random()%20)];
        }
    }
    
    
    // pieChartView
    self.pieChartView = [[BFPieChartView alloc]initWithFrame:CGRectMake(5, 5, self.pieContainer.width-10, self.pieContainer.height-10) withValue:_valueArray withColor:_colorsArray];
    self.pieChartView.delegate = self;
    [self.pieContainer addSubview:self.pieChartView];
    
}

- (void)dealloc
{
    _colorsArray = nil;
    _valueArray = nil;
    self.pieContainer = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.pieChartView reloadChart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


