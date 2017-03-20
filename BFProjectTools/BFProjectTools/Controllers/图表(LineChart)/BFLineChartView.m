//
//  BFLineChartView.m
//  BFProjectTools
//
//  Created by Janmy on 16/11/2.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFLineChartView.h"

@interface BFLineChartView ()<BEMSimpleLineGraphDelegate,BEMSimpleLineGraphDataSource>
{
    NSMutableArray *testNumberArray;
}
@end

@implementation BFLineChartView


- (void)createLineChart{
    if (_lineGraphView) {
        [_lineGraphView removeFromSuperview];
        _lineGraphView = nil;
    }
    _enableBezierCurve = NO;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    testNumberArray = [NSMutableArray array];
    
    for (int i = 0; i<10; i++) {
        int tempInt = arc4random()%100;
        NSNumber *tempNum = [NSNumber numberWithInt:tempInt];
        [testNumberArray addObject:tempNum];
    }
    
    
    _lineGraphView = [[BEMSimpleLineGraphView alloc]initWithFrame:CGRectMake(10, 10, self.bounds.size.width-20, self.bounds.size.height-20)];
    _lineGraphView.delegate = self;
    _lineGraphView.dataSource = self;
    [self settings];
    
    
    
    [self addSubview:_lineGraphView];
}
- (void)settings{
    _lineGraphView.autoScaleYAxis = YES;
    
    //待开放接口
    _lineGraphView.alwaysDisplayDots = YES;
    _lineGraphView.enableTouchReport = YES;
    _lineGraphView.animationGraphEntranceTime = 1.0;
    _lineGraphView.enablePopUpReport = YES;
    _lineGraphView.enableBezierCurve = _enableBezierCurve;
    
    _lineGraphView.colorTop = _colorTop?_colorTop:[UIColor clearColor];
    _lineGraphView.colorBottom = _colorBottom?_colorBottom:[UIColor clearColor];
    _lineGraphView.colorLine = _colorLine?_colorLine:[UIColor redColor];
    _lineGraphView.colorPoint = _colorPoint?_colorPoint:[UIColor redColor];
    
    //这里将X与Y轴网格统一处理了，若有需要可以在下面分开即可。
    _lineGraphView.enableReferenceAxisFrame = _enableReferenceAxisFrame;
    
    //Y轴相关
    _lineGraphView.enableYAxisLabel = _enableYAxisLabel;
    _lineGraphView.enableReferenceYAxisLines = _enableReferenceAxisFrame;
    
    //X轴相关
    _lineGraphView.enableXAxisLabel = _enableXAxisLabel;
    _lineGraphView.enableReferenceXAxisLines = _enableReferenceAxisFrame;
    _lineGraphView.colorBackgroundXaxis = [UIColor clearColor];
    _lineGraphView.alphaBackgroundXaxis = 1.0;
    _lineGraphView.colorXaxisLabel = [UIColor blackColor];
}
- (void)refreshGraph{
    [self settings];
    [_lineGraphView reloadGraph];
}

#pragma mark BEMSimpleLineGraphView Delegate && DataSource
- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return testNumberArray.count;
}
- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [testNumberArray[index] floatValue];
}


- (nullable NSString *)lineGraph:(nonnull BEMSimpleLineGraphView *)graph labelOnYAxisForIndex:(NSInteger)index{
    return [testNumberArray[index] string];
}


//从第几个值开始绘X轴label
//- (NSInteger)baseIndexForXAxisOnLineGraph:(BEMSimpleLineGraphView *)graph{
//    return 10;
//}
////自定义X轴坐标值间距。
//- (NSInteger)incrementIndexForXAxisOnLineGraph:(BEMSimpleLineGraphView *)graph{
//    return 10;
//}

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph{
    return 0;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index{
    return @"test";
}

- (NSString *)popUpPrefixForlineGraph:(BEMSimpleLineGraphView *)graph{
    return @"标题:";
}
- (NSString *)popUpSuffixForlineGraph:(BEMSimpleLineGraphView *)graph{
    return @"单位";
}

- (CGFloat)maxValueForLineGraph:(BEMSimpleLineGraphView *)graph{
    return 100;
}
- (CGFloat)minValueForLineGraph:(BEMSimpleLineGraphView *)graph{
    return 0;
}



@end
