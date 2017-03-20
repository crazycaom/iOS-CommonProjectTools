//
//  BFMultiTapViewController.m
//  BFProjectTools
//
//  Created by Janmy on 16/10/24.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFMultiTapViewController.h"

@interface BFMultiTapViewController ()<UIScrollViewDelegate>

@end

@implementation BFMultiTapViewController

#pragma mark - init

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
    }
    
    return self;
    
}
- (instancetype)initWithViews:(NSArray *)multiViews titles:(NSArray *)titles{
    if (self) {
        
        _multiViews = [multiViews copy];
        
        _titles = [titles copy];
        
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        _segmentHeight = 40;
        _selectedIndex = 0;
        _segmentBackgroundColor = [UIColor clearColor];
        _segmentTextColor_Normal = [UIColor redColor];
        _segmentTextColor_Selected = [UIColor blueColor];
        _indicatorLineColor = [UIColor blueColor];
        

    }
    
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self createView];

}


#pragma mark - 视图创建
- (void)createView{
    
    [self createSegment];
    
    [self createMainScrollView];
}

- (void)createSegment{
    //2为下标线高度
    _segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, _screenWidth, self.segmentHeight-2)];
    [_segment setSelectedSegmentIndex:self.selectedIndex];
    [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    _segment.backgroundColor = self.segmentBackgroundColor;
    _segment.tintColor = self.segmentBackgroundColor;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.segmentTextColor_Normal,NSForegroundColorAttributeName, [UIFont systemFontOfSize:15],NSFontAttributeName ,nil];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:_segmentTextColor_Selected,NSForegroundColorAttributeName, [UIFont systemFontOfSize:15],NSFontAttributeName,nil];
    [_segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    [_segment setTitleTextAttributes:dic1 forState:UIControlStateSelected];
    
    
    for (int i = 0; i < _multiViews.count; i++) {
        NSString *title = _titles[i];
        [_segment insertSegmentWithTitle:title atIndex:i animated:YES];
    }
    
    //分页指示器下方标示线
    _indicatorLine = [[UIView alloc]init];
    CGFloat indicatorWidth = _screenWidth/_multiViews.count;
    [_indicatorLine setFrame:CGRectMake(indicatorWidth*self.selectedIndex, CGRectGetMaxY(_segment.frame), indicatorWidth, 2)];
    [_indicatorLine setBackgroundColor:self.indicatorLineColor];
    
    [self.view addSubview:_indicatorLine];
    
    [self.view addSubview:_segment];
}

- (void)createMainScrollView{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.segmentHeight, _screenWidth, _screenHeight-_segmentHeight)];
    [_mainScrollView setDelegate:self];
    [_mainScrollView setContentSize:CGSizeMake(_screenWidth*_multiViews.count, CGRectGetHeight(_mainScrollView.frame))];
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];
    [_mainScrollView setScrollEnabled:YES];
    [_mainScrollView setPagingEnabled:YES];
    [_mainScrollView setContentOffset:CGPointMake(_screenWidth*self.selectedIndex, 0)];

    
    for (int i = 0; i<_multiViews.count; i++) {
        UIView *subView = _multiViews[i];
        [subView setFrame:CGRectMake(_screenWidth*i, 0, _screenWidth, _screenHeight)];
        [_mainScrollView addSubview:subView];
    }
    
    [self.view addSubview:_mainScrollView];
}

#pragma mark - 页面切换事件
- (void)segmentValueChanged:(UISegmentedControl*)sender{
    
    self.selectedIndex = sender.selectedSegmentIndex;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [_indicatorLine setFrame:CGRectMake(sender.selectedSegmentIndex*CGRectGetWidth(_indicatorLine.frame), CGRectGetMaxY(_segment.frame), CGRectGetWidth(_indicatorLine.frame), CGRectGetHeight(_indicatorLine.frame))];

    [UIView commitAnimations];
    [_mainScrollView setContentOffset:CGPointMake(_screenWidth*sender.selectedSegmentIndex, 0) animated:YES];
    
    
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_indicatorLine setFrame:CGRectMake(_screenWidth*(scrollView.contentOffset.x/scrollView.contentSize.width), CGRectGetMaxY(_segment.frame), CGRectGetWidth(_indicatorLine.frame), CGRectGetHeight(_indicatorLine.frame))];
    
    //取滚动页中心点作为segment的选中更改依据。
    NSInteger scrollIndex = (scrollView.contentOffset.x+0.5*_screenWidth)/_screenWidth;
    [_segment setSelectedSegmentIndex:scrollIndex];

    self.selectedIndex = scrollIndex;
}







@end
