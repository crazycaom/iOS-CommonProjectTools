//
//  BezierCurveBarView.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//


#import "BFView.h"

// BarChat 线条和字体的统一颜色
#define BarChartLineAndFontColor            [UIColor darkGrayColor]

// 点击Bar 显示TextView背景颜色
#define ShowViewBackgroundColor [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f]

// Bar未选中颜色
#define BarUnSelectColor [UIColor colorWithRed:0.94f green:0.60f blue:0.60f alpha:1.00f]
// Bar选中颜色
#define BarSelectColor [UIColor redColor]

// y坐标轴左边距
#define YLeftMargin            30
// x坐标轴下边距
#define XBottomMargin          40
// y轴每一个刻度值
#define YMarkValue             (CGRectGetHeight(myFrame)-XBottomMargin-_topMargin)/6
// x轴每一个刻度值
#define XMarkValue             (self.contentScrollView.contentSize.width)/xNames.count

typedef enum : NSInteger {
    Default = 0, // 默认柱状图高亮
    BarHighLight, // 点击柱状图高亮
    BarBackgroudHighLight, // 点击柱状图背景高亮
    BarUnHighLight // 不进行高亮效果
} BarHighLightType;


@interface BezierCurveBarView : BFView

/**
 是否显示刻度
 */
@property(nonatomic) BOOL                   isShowAxiMark;

/**
 是否显示Y轴单位
 */
@property(nonatomic) BOOL                   isShowYAxiUnit;

/**
 Bar上是否显示数值
 */
@property(nonatomic) BOOL                   aboveBarShowTargetValue;

/**
 是否旋转X轴文本
 */
@property(nonatomic) BOOL                   isTransfromXText;

/**
 是否显示网格
 */
@property(nonatomic) BOOL                   isShowGride;

/**
 Bar是否可以点击
 */
@property(nonatomic) BOOL                   enableClickBar;

/**
 Bar 点击高亮类型
 */
@property(nonatomic) BarHighLightType       highLightType;

/**
 点击Bar是否显示详情信息
 */
@property(nonatomic) BOOL                   isShowInfoView;

/**
 初始化画布

 @param frame BarChartFrame

 @return BezierCurveBarView
 */
+ (instancetype) initWithFrame:(CGRect)frame;

/**
 是否显示XY轴

 @param isShow     YES: 显示. NO: 不显示
 @param xNames     x轴坐标
 @param maxYTarget y轴最大值
 */
- (void)isShowXYAXi:(BOOL)isShow andShowArrow:(BOOL)showArrow andXNames:(NSMutableArray *)xNames andMaxYTarget:(CGFloat)maxYTarget;

/**
 绘制BarChart

 @param targetsValues  Y目标数组
 @param maxTargetValue Y目标最大值
 @param xNames         X轴数组
 */
- (void)drawBarChartWithTargets:(NSMutableArray *)targetsValues andMaxTargetValue:(CGFloat)maxTargetValue andXNames:(NSMutableArray *)xNames;

@end
