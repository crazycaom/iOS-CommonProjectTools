//
//  BFPieChartView.h
//  LineView
//
//  Created by CaoMeng on 16/9/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFView.h"
#import "BFPieRotatedView.h"

@class BFPieChartView;

@protocol PieChartDelegate <NSObject>

@optional

// 点击pie旋转到点击的位置
- (void)selectedFinish:(BFPieChartView *)pieChartView index:(NSInteger)index percent:(float)per;

// 点击中间按钮切换显示
- (void)onCenterClick:(BFPieChartView *)PieChartView;

@end


@interface BFPieChartView : BFView<RotatedViewDelegate>

@property(nonatomic, assign) id<PieChartDelegate> delegate;

// 创建pieChartView
- (id)initWithFrame:(CGRect)frame withValue:(NSMutableArray *)valueArr withColor:(NSMutableArray *)colorArr;

// 刷新数据
- (void)reloadChart;

// 设置中间数值
- (void)setAmountText:(NSString *)text;

// 设置中间标题
- (void)setTitleText:(NSString *)text;

@end
