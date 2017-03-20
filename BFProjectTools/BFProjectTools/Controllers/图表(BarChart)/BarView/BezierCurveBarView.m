//
//  BezierCurveView.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//


#import "BezierCurveBarView.h"

static CGRect myFrame;

@interface BezierCurveBarView ()
{
    // 顶部是否显示单位Margin
    CGFloat                                 _topMargin;
    
    // 绘制X,Y轴的刻度网格
    NSMutableArray                          *_xGrideArray;
    
    NSMutableArray                          *_yGrideArray;
    
    // shapeLayerArray
    NSMutableArray                          *_shapeLayerArray;
    
    // 选中的背景View高亮
    UIView                                  *_selectHighlightView;

    // showInfoView
    UIView                                  *_infoView;
    
    // showInfoView位置
    NSMutableArray                          *_targetsArray;
    
    // xNames.count
    NSUInteger                              _xNamesCount;
    
    // maxTargetValue
    CGFloat                                 _maxTargetsValue;
    
    // barClickArray
    NSMutableArray                          *_barClickArray;
}

// contentScrollView
@property(nonatomic,strong) UIScrollView    *contentScrollView;

@end

@implementation BezierCurveBarView

#pragma mark - 初始化画布
+ (instancetype)initWithFrame:(CGRect)frame
{
    BezierCurveBarView *bezierCurveView = [[BezierCurveBarView alloc] initWithFrame:frame];
    
    // 设定背景颜色
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)];
    //backgroundView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [bezierCurveView addSubview:backgroundView];
    
    myFrame = frame;
    
    return bezierCurveView;
}

#pragma mark - 绘制XY轴

-(void)isShowXYAXi:(BOOL)isShow andShowArrow:(BOOL)showArrow andXNames:(NSMutableArray *)xNames andMaxYTarget:(CGFloat)maxYTarget
{
    _xGrideArray = [NSMutableArray array];
    _yGrideArray = [NSMutableArray array];
    
    UIBezierPath *yPath = [UIBezierPath bezierPath];
    UIBezierPath *xPath = [UIBezierPath bezierPath];
    
    // AddContentScrollView
    [self addSubview:self.contentScrollView];
    
    CGFloat scrollViewContentWidth = CGRectGetWidth(myFrame)-YLeftMargin-1;
    if(xNames.count > 12){
        // 如果XNames.count > 12
        scrollViewContentWidth = ((CGRectGetWidth(myFrame)-YLeftMargin-1)/12)*xNames.count;
    }
    self.contentScrollView.contentSize = CGSizeMake(scrollViewContentWidth, self.contentScrollView.height);
    CGRect contentScrollViewFrame = self.contentScrollView.frame;
    
    // 显示单位
    _topMargin = 5.0;
    if(_isShowYAxiUnit){
        _topMargin = 20;
        
        UILabel *yUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(OffSetX, 0, 60, 18)];
        yUnitLabel.text = @"单位:XXX";
        yUnitLabel.font = [UIFont systemFontOfSize:10];
        yUnitLabel.textColor = BarChartLineAndFontColor;
        yUnitLabel.tag = 1000;
        [self addSubview:yUnitLabel];
    }
    
    CGFloat xFirstMark = 0.0;
    if(_isShowAxiMark){
        // X轴第一个刻度,用Y轴绘制.
        xFirstMark = 3.0;
    }
    
    // 绘制X,Y轴坐标轴
    if(isShow){
        
        // 添加Y轴
        [yPath moveToPoint:CGPointMake(YLeftMargin, CGRectGetHeight(myFrame)-XBottomMargin+xFirstMark)];
        [yPath addLineToPoint:CGPointMake(YLeftMargin, _topMargin)];
        
        // X轴
        [xPath moveToPoint:CGPointMake(0, CGRectGetHeight(contentScrollViewFrame)-XBottomMargin)];
        [xPath addLineToPoint:CGPointMake(self.contentScrollView.contentSize.width, CGRectGetHeight(contentScrollViewFrame)-XBottomMargin)];
        
        
        if(showArrow){
            
            // Y轴箭头
            [yPath moveToPoint:CGPointMake(YLeftMargin, _topMargin)];
            [yPath addLineToPoint:CGPointMake(YLeftMargin-5, _topMargin+5)];
            [yPath moveToPoint:CGPointMake(YLeftMargin, _topMargin)];
            [yPath addLineToPoint:CGPointMake(YLeftMargin+5, _topMargin+5)];
            
            // X轴箭头(不管是否能够滚动, 箭头固定位置为可视范围内的最右侧)
            [xPath moveToPoint:CGPointMake(self.contentScrollView.contentSize.width, CGRectGetHeight(contentScrollViewFrame)-XBottomMargin)];
            [xPath addLineToPoint:CGPointMake(self.contentScrollView.contentSize.width-5, CGRectGetHeight(contentScrollViewFrame)-XBottomMargin-5)];
            [xPath moveToPoint:CGPointMake(self.contentScrollView.contentSize.width, CGRectGetHeight(contentScrollViewFrame)-XBottomMargin)];
            [xPath addLineToPoint:CGPointMake(self.contentScrollView.contentSize.width-5, CGRectGetHeight(contentScrollViewFrame)-XBottomMargin+5)];
        }
    }
    
    // 绘制X,Y轴刻度
    if(_isShowAxiMark){
    
        // Y轴
        for(int i = 0; i < 7; i++){
            // 最后一个刻度如果有箭头, 则不显示刻度
            if(showArrow && i == 6){
                [_yGrideArray addObject:[NSString stringWithFormat:@"%f", CGRectGetHeight(myFrame)-XBottomMargin-(YMarkValue)*6]];
                continue;
            }
            
            // 添加刻度
            CGFloat Y = CGRectGetHeight(myFrame)-XBottomMargin-(YMarkValue)*i;
            CGPoint point = CGPointMake(YLeftMargin,Y);
            [yPath moveToPoint:point];
            [yPath addLineToPoint:CGPointMake(point.x-3, point.y)];
            
            [_yGrideArray addObject:[NSString stringWithFormat:@"%f",Y]];
        }
        
        // X轴
        for(int j = 0; j < xNames.count+2; j++){
            
            CGFloat X = (self.contentScrollView.contentSize.width)-XMarkValue*j;
            CGFloat gapMargin = 1.0;
            
            // x轴最后一个刻度, 如果有箭头则不显示
            if(showArrow && j == 0){
                [_xGrideArray addObject:[NSString stringWithFormat:@"%f",(self.contentScrollView.contentSize.width)-XMarkValue*0-gapMargin]];
                continue;
            }
            
            if(j == 0){
                X = X - gapMargin;
            }
            
            CGPoint point = CGPointMake(X,CGRectGetHeight(contentScrollViewFrame)-XBottomMargin);
            if(j != xNames.count+1){
                [xPath moveToPoint:point];
                [xPath addLineToPoint:CGPointMake(point.x, j == (xNames.count) ? point.y : point.y+3)];
            }
            
            [_xGrideArray addObject:[NSString stringWithFormat:@"%f",X]];
        }
    }
    
    // 绘制X,Y轴文本
    
    // Y轴
    // 计算每一个刻度的数值
    CGFloat tempEach = maxYTarget/(6*1.0);
    for(int i = 0; i < 7; i++){
        
        // 最后一个刻度如果有箭头, 则不显示文本
        if(showArrow && i == 6){
            continue;
        }
        
        CGFloat Y = CGRectGetHeight(myFrame)-XBottomMargin-(YMarkValue)*i;
        // 绘制刻度文本
        UILabel *yTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Y-5, YLeftMargin-3, 10)];
        if(tempEach != 0){
            yTextLabel.text = [NSString stringWithFormat:@"%.0f",tempEach*i];
        }
        yTextLabel.font = [UIFont boldSystemFontOfSize:10];
        yTextLabel.textAlignment = NSTextAlignmentCenter;
        yTextLabel.textColor = BarChartLineAndFontColor;
        yTextLabel.tag = 1000;
        [self addSubview:yTextLabel];

    }
    
    // X轴
    for(int j = 0; j < xNames.count; j++){
        
        CGFloat TextXAxiMargin = _isTransfromXText ? 20 : 10;
        
        CGFloat XText = XMarkValue*(j+1) - (XMarkValue/4)*2;
        
        // X轴文本
        UILabel *xTextLabel = [[UILabel alloc] init];
        xTextLabel.size = CGSizeMake(40, 12);
        xTextLabel.center = CGPointMake(XText, (CGRectGetHeight(contentScrollViewFrame)-XBottomMargin+ TextXAxiMargin));
        xTextLabel.backgroundColor = [UIColor clearColor];
        xTextLabel.text = [xNames objectAtIndex:j];
        xTextLabel.font = [UIFont systemFontOfSize:10];
        xTextLabel.textAlignment = NSTextAlignmentCenter;
        xTextLabel.textColor = BarChartLineAndFontColor;
        xTextLabel.tag = 1000;
        [self.contentScrollView addSubview:xTextLabel];
        
        // 根据中心点旋转45°
        if(_isTransfromXText){
            xTextLabel.layer.anchorPoint = CGPointMake(0.5, 0.5);
            xTextLabel.transform = CGAffineTransformMakeRotation(-M_PI_4);
        }
    }
    
    if(_isShowGride){
        
        // Y网格 第一行是X轴不进行绘制线
        if(_yGrideArray.count){
            [_yGrideArray removeObjectAtIndex:0];
        }
        
        // 绘制X轴网格
        for(int i = 0 ; i < _yGrideArray.count ; i++){
            CALayer *lineLaye = [CALayer layer];
            [lineLaye setFrame:CGRectMake(0, [_yGrideArray[i] floatValue], self.contentScrollView.contentSize.width, 0.5)];
            [lineLaye setBackgroundColor:[UIColor lightGrayColor].CGColor];
            [self.contentScrollView.layer addSublayer:lineLaye];
        }

        // X网格 最后一行是Y轴不进行绘制
        if(_xGrideArray.count){
            [_xGrideArray removeLastObject];
        }
        
        // 绘制Y网格
        for(int i = 0 ; i < _xGrideArray.count ; i ++){
            CALayer *lineLaye = [CALayer layer];
            [lineLaye setFrame:CGRectMake([_xGrideArray[i] floatValue], _topMargin, 0.5, CGRectGetHeight(myFrame)- XBottomMargin - _topMargin)];
            [lineLaye setBackgroundColor:[UIColor lightGrayColor].CGColor];
            [self.contentScrollView.layer addSublayer:lineLaye];
        }
        
    }
    
    // 渲染Y轴路径
    CAShapeLayer *yShapeLayer = [CAShapeLayer layer];
    yShapeLayer.path = yPath.CGPath;
    yShapeLayer.strokeColor = BarChartLineAndFontColor.CGColor;
    yShapeLayer.fillColor = BarChartLineAndFontColor.CGColor;
    yShapeLayer.borderWidth = 1.0;
    [self.layer addSublayer:yShapeLayer];
    
    // 渲染X轴路径
    CAShapeLayer *xShapeLayer = [CAShapeLayer layer];
    xShapeLayer.path = xPath.CGPath;
    xShapeLayer.strokeColor = BarChartLineAndFontColor.CGColor;
    xShapeLayer.fillColor = BarChartLineAndFontColor.CGColor;
    xShapeLayer.borderWidth = 1.0;
    [self.contentScrollView.layer addSublayer:xShapeLayer];
    
}

#pragma mark - 绘制Bar
- (void)drawBarChartWithTargets:(NSMutableArray *)targetsValues andMaxTargetValue:(CGFloat)maxTargetValue andXNames:(NSMutableArray *)xNames
{
    CGRect contentScrollViewFrame = self.contentScrollView.frame;
    
    if(!_shapeLayerArray){
        _shapeLayerArray = [NSMutableArray array];
    }
    
    // 移除点击按钮 BarText文本 infoView 和 selectHighlightView
    for (UIView *view in self.contentScrollView.subviews) {
        if([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
        
        if(view.tag == 1 || view.tag == 2 || view.tag == 3){
            [view removeFromSuperview];
        }
    }
    
    if(_shapeLayerArray){
        // 清空之前的选中颜色
        for (CAShapeLayer *shapeLayer in _shapeLayerArray) {
            shapeLayer.fillColor = BarUnSelectColor.CGColor;
        }
    }

    _maxTargetsValue = maxTargetValue;
    _xNamesCount = [xNames count];
    _targetsArray = targetsValues;
    
    for (int i = 0; i < targetsValues.count ; i++) {
        
        // 得到目标值
        CGFloat doubleValue = [targetsValues[i] floatValue];
        
        // 转换成对应画布高度下的数值
        CGFloat tempValue = 0 ;
        if(maxTargetValue != 0){
            tempValue = (CGRectGetHeight(contentScrollViewFrame) - XBottomMargin - _topMargin)/maxTargetValue;
        }
        CGFloat tempHeight = doubleValue*tempValue;
        
        CGFloat Y = CGRectGetHeight(contentScrollViewFrame) - XBottomMargin - tempHeight;
        CGFloat X = 0 + XMarkValue*(i+1) - ((XMarkValue/4)*3);
        
        // 绘制Bar
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(X, Y, ((XMarkValue/4)*2), tempHeight)];
        
        CAShapeLayer *shapeLayer;
        if (_shapeLayerArray.count > i && _shapeLayerArray[i]) {
            shapeLayer = (CAShapeLayer *)_shapeLayerArray[i];
        } else {
            shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [UIColor clearColor].CGColor;
            shapeLayer.fillColor = BarUnSelectColor.CGColor;
            shapeLayer.borderWidth = 2.0;
            [self.contentScrollView.layer addSublayer:shapeLayer];
            
            [_shapeLayerArray addObject:shapeLayer];
        }
        
        // shapeLayer 添加动画
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.duration = 0.5;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = (__bridge id)shapeLayer.path;
        pathAnimation.toValue = path;
        shapeLayer.path = path.CGPath;
        [shapeLayer addAnimation:pathAnimation forKey:nil];
        
        // bar上文本数值
        if(_aboveBarShowTargetValue){
            UILabel *barTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, Y-20, (XMarkValue/4)*2, 20)];
            barTextLabel.backgroundColor = [UIColor clearColor];
            barTextLabel.text = [NSString stringWithFormat:@"%.0f",doubleValue];
            barTextLabel.textColor = BarChartLineAndFontColor;
            barTextLabel.textAlignment = NSTextAlignmentCenter;
            barTextLabel.font = [UIFont systemFontOfSize:10];
            barTextLabel.tag = 1;
            [self.contentScrollView addSubview:barTextLabel];
        }
        
        // bar是否可以点击
        if(_enableClickBar && tempHeight != 0){
            UIButton *barClickButton = [[UIButton alloc] initWithFrame:CGRectMake(X, Y,((XMarkValue/4)*2), tempHeight)];
            barClickButton.backgroundColor = [UIColor clearColor];
            [barClickButton addTarget:self action:@selector(clickBarShowInfoView:) forControlEvents:UIControlEventTouchUpInside];
            barClickButton.tag = i;
            [self.contentScrollView addSubview:barClickButton];
        }
    }
}

#pragma mark - Bar点击事件

- (void)clickBarShowInfoView:(UIButton *)btn
{
    // 清空选中的View
    [self clearSelectView];
    
    NSUInteger index = btn.tag;
    
    // 得到目标值
    CGFloat doubleValue = [_targetsArray[index] floatValue];
    // 转换成对应画布高度下的数值
    CGFloat tempValue = 0 ;
    if(_maxTargetsValue != 0){
        tempValue = (CGRectGetHeight(myFrame) - XBottomMargin - _topMargin)/_maxTargetsValue;
    }
    
    CGFloat tempHeight = doubleValue*tempValue;
    CGFloat width = (self.contentScrollView.contentSize.width)/(_xNamesCount);
    CGFloat Y = CGRectGetHeight(myFrame) - XBottomMargin - tempHeight;
    CGFloat X =  width*(index+1) - ((width/4)*2);
    
    
    if(_highLightType == Default || _highLightType == BarHighLight){
        
        // 清空之前的选中颜色
        for (CAShapeLayer *shapeLayer in _shapeLayerArray) {
            shapeLayer.fillColor = BarUnSelectColor.CGColor;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            // 改变选中的颜色
            CAShapeLayer *shapeLayer = (CAShapeLayer *)[_shapeLayerArray objectAtIndex:btn.tag];
            shapeLayer.fillColor = BarSelectColor.CGColor;
        }];
        
    }else if(_highLightType == BarBackgroudHighLight){
        // 背景View高亮
        _selectHighlightView = [[UIView alloc] initWithFrame:CGRectMake(X - (width/4) - 5, _topMargin, (width/4)*2 + 10, CGRectGetHeight(myFrame) - _topMargin - XBottomMargin)];
        _selectHighlightView.backgroundColor = [UIColor darkGrayColor];
        _selectHighlightView.alpha = 0.5;
        _selectHighlightView.tag = 3;
        [self.contentScrollView addSubview:_selectHighlightView];
    }
    
    if(_isShowInfoView){
        // 判断右侧的距离是否能够显示一个infoView
        // 能够显示的宽度
        CGFloat targetShowWidth = (self.contentScrollView.contentSize.width) - X;
        X = targetShowWidth > 100 ? X : X - 100;
        
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(X, Y - 25, 0, 0)];
        _infoView.tag = 2;
        UILabel *showTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [UIView animateWithDuration:0.5 animations:^{
            _infoView.frame = CGRectMake(X, Y - 25, 100, 20);
            _infoView.backgroundColor = ShowViewBackgroundColor;
            
            showTextLabel.frame = CGRectMake(0, 0, _infoView.width, _infoView.height);
            showTextLabel.text = [NSString stringWithFormat:@"当前值: %.0f",doubleValue];
            showTextLabel.textAlignment = NSTextAlignmentCenter;
            showTextLabel.textColor = [UIColor whiteColor];
            showTextLabel.font = [UIFont systemFontOfSize:10];
            [_infoView addSubview:showTextLabel];
        } completion:nil];
        
        [self.contentScrollView addSubview:_infoView];
    }
}

#pragma mark - TapGesture

- (void)tapViewGesture:(UIGestureRecognizer *)gesture
{
    [self clearSelectView];
}


#pragma mark - 点击非Bar区域 删除infoView 和 selectHighlightView

- (void)clearSelectView
{
    if(_infoView){
        [UIView animateWithDuration:0.5 animations:^{
            _infoView.alpha = 0;
            [_infoView removeFromSuperview];
            _infoView = nil;
        }];
    }
    
    if(_selectHighlightView){
        [UIView animateWithDuration:0.5 animations:^{
            _selectHighlightView.alpha = 0;
            [_selectHighlightView removeFromSuperview];
            _selectHighlightView = nil;
        }];
    }
}

#pragma mark - get

- (UIScrollView *)contentScrollView
{
    if(_contentScrollView){
        return  _contentScrollView;
    }
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(YLeftMargin, 0, CGRectGetWidth(myFrame)-YLeftMargin-1, CGRectGetHeight(myFrame))];
    _contentScrollView.backgroundColor = [UIColor clearColor];
    _contentScrollView.bounces = NO;
    
    // self addTapGesture(点击删除提示信息)
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewGesture:)]];
    self.userInteractionEnabled = YES;
    
    return _contentScrollView;
}

#pragma mark -  set

- (void)setIsShowAxiMark:(BOOL)isShowAxiMark
{
    _isShowAxiMark = isShowAxiMark;
}

- (void)setIsShowYAxiUnit:(BOOL)isShowYAxiUnit
{
    _isShowYAxiUnit = isShowYAxiUnit;
}

- (void)setAboveBarShowTargetValue:(BOOL)aboveBarShowTargetValue
{
    _aboveBarShowTargetValue = aboveBarShowTargetValue;
}

- (void)setIsTransfromXText:(BOOL)isTransfromXText
{
    _isTransfromXText = isTransfromXText;
}

- (void)setIsShowGride:(BOOL)isShowGride
{
    _isShowGride = isShowGride;
}

- (void)setEnableClickBar:(BOOL)enableClickBar
{
    _enableClickBar = enableClickBar;
}

- (void)setHighLightType:(BarHighLightType)highLightType
{
    _highLightType = highLightType;
}

- (void)setIsShowInfoView:(BOOL)isShowInfoView
{
    _isShowInfoView = isShowInfoView;
}

@end
