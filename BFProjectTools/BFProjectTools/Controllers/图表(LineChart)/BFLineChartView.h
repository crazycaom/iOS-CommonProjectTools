//
//  BFLineChartView.h
//  BFProjectTools
//
//  Created by Janmy on 16/11/2.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BEMSimpleLineGraphView.h>

@interface BFLineChartView : UIView
{
    BEMSimpleLineGraphView *_lineGraphView;
}

/**
 创建图标界面
 */
- (void)createLineChart;

/**
 重绘图表
 */
- (void)refreshGraph;

/**
 是否自动缩放Y轴值
 */
@property (nonatomic,assign) BOOL autoScaleYAxis;

/**
 是否显示折点
 */
@property (nonatomic,assign) BOOL alwaysDisplayDots;

/**
 是否显示触摸位置提示
 */
@property (nonatomic,assign) BOOL enableTouchReport;

/**
 是否允许弹出详情
 */
@property (nonatomic,assign) BOOL enablePopUpReport;

/**
 绘制动画持续时间
 */
@property (nonatomic,assign) CGFloat animationGraphEntranceTime;

/**
 是否展示坐标轴网格
 */
@property (nonatomic,assign) BOOL enableReferenceAxisFrame;

/**
 是否采用弧线绘制
 */
@property (nonatomic,assign) BOOL enableBezierCurve;

/**
 是否显示Y轴坐标
 */
@property (nonatomic,assign) BOOL enableYAxisLabel;

/**
 是否显示X轴坐标
 */
@property (nonatomic,assign) BOOL enableXAxisLabel;

/**
 是否显示X轴网格竖线
 */
@property (nonatomic,assign) BOOL enableReferenceXAxisLines;

/**
 是否显示Y轴网格横线
 */
@property (nonatomic,assign) BOOL enableReferenceYAxisLines;

/**
 是否显示特殊Y轴横线
 */
@property (nonatomic,assign) BOOL enableLeftReferenceAxisFrameLine;

/**
 是否显示特殊X轴竖线
 */
@property (nonatomic,assign) BOOL enableBottomReferenceAxisFrameLine;

/**
 折线下方填充色
 */
@property (nonatomic,strong) UIColor *colorBottom;

/**
 折线上方填充色
 */
@property (nonatomic,strong) UIColor *colorTop;

/**
 折线色
 */
@property (nonatomic,strong) UIColor *colorLine;

/**
 折点色
 */
@property (nonatomic,strong) UIColor *colorPoint;

/**
 X轴坐标值颜色
 */
@property (nonatomic,strong) UIColor *colorXaxisLabel;

/**
 X坐标轴背景色
 */
@property (nonatomic,strong) UIColor *colorBackgroundXaxis;

/**
 Y坐标轴背景色
 */
@property (nonatomic,strong) UIColor *colorBackgroundYaxis;

/**
 Y轴坐标值颜色
 */
@property (nonatomic,strong) UIColor *colorYaxisLabel;

/**
 折点弹出详情框背景色
 */
@property (nonatomic,strong) UIColor *colorBackgroundPopUplabel;






@end
