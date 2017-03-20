//
//  BFMultiTapViewController.h
//  BFProjectTools
//
//  Created by Janmy on 16/10/24.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFRootViewController.h"

@interface BFMultiTapViewController : BFRootViewController
{
    NSArray *_multiViews;
    NSArray *_titles;
    
    CGFloat _screenWidth;
    CGFloat _screenHeight;
    
    UISegmentedControl *_segment;
    UIView *_indicatorLine;//分页下标指示线
    
    UIScrollView *_mainScrollView;
    
}

/**
 分页视图控制器初始化方法

 @param multiViews 子视图数组
 @param titles     子视图标题数组

 @return 分页视图控制器
 */
- (instancetype)initWithViews:(NSArray*)multiViews
                       titles:(NSArray*)titles;

/**
 导航tap页高度，default is 40.0
 */
@property (nonatomic,assign) CGFloat segmentHeight;

/**
 默认选中视图，default is 0
 */
@property (nonatomic,assign) NSInteger selectedIndex;

/**
 segment分页控制器背景色，default is clear
 */
@property (nonatomic,strong) UIColor *segmentBackgroundColor;

/**
 segment分页控制器标题常规颜色，default is black
 */
@property (nonatomic,strong) UIColor *segmentTextColor_Normal;

/**
 segment分页控制器选中颜色，default is blue
 */
@property (nonatomic,strong) UIColor *segmentTextColor_Selected;

/**
 segment分页控制器下方选中下划线颜色,default is blue
 */
@property (nonatomic,strong) UIColor *indicatorLineColor;













@end
