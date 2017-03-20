//
//  BFPieRotatedView.h
//  LineView
//
//  Created by CaoMeng on 16/9/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFView.h"
#import "BFPieRenderView.h"

@class BFPieRotatedView;

@protocol RotatedViewDelegate <NSObject>

@optional

// 点击旋转到指定位置
- (void)selectedFinish:(BFPieRotatedView *)rotatedView index:(NSInteger)index percent:(float)per;

@end

@interface BFPieRotatedView : BFView<RenderViewDataSource,RenderViewtDelegate>
{
    // 零度角度
    float               mZeroAngle;
    // 数值Array
    NSMutableArray     *mValueArray;
    // 数值颜色Array
    NSMutableArray     *mColorArray;
    // 目标值Array
    NSMutableArray     *mThetaArray;
    
    // 是否开启动画
    BOOL                isAnimating;
    // 是否 tap停止
    BOOL                isTapStopped;
    // 是否自动选中
    BOOL                isAutoRotation;
    
    // 绝对目标
    float               mAbsoluteTheta;
    // 相对目标
    float               mRelativeTheta;
    // infoTextView
    UITextView         *mInfoTextView;
    
    // 拖拽速度
    float               mDragSpeed;
    // 拖拽之前的日期
    NSDate             *mDragBeforeDate;
    // 拖拽之前的目标
    float               mDragBeforeTheta;
    // 延迟时间
    NSTimer            *mDecelerateTimer;
}

@property(nonatomic, assign) id<RotatedViewDelegate> delegate;

// 每一个小部分代表值
@property (nonatomic)float fracValue;

// 零度角度
@property (nonatomic)         float           mZeroAngle;

// 自动旋转
@property (nonatomic)         BOOL            isAutoRotation;

// 数值数组
@property (nonatomic, retain) NSMutableArray *mValueArray;
// 颜色数组
@property (nonatomic, retain) NSMutableArray *mColorArray;

// infoTextView
@property (nonatomic, retain) UITextView     *mInfoTextView;

// 开始动画
- (void)startedAnimate;

// 重新加载数据
- (void)reloadPie;

@end
