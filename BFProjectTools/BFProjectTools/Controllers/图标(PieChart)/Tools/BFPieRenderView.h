//
//  BFPieRenderView.h
//  LineView
//
//  Created by CaoMeng on 16/9/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFView.h"

@class BFPieRenderView;
@class SliceLayer;

@protocol RenderViewDataSource <NSObject>

@required
- (NSUInteger)numberOfSlicesInPieChart:(BFPieRenderView *)pieChart;

- (CGFloat)pieChart:(BFPieRenderView *)pieChart valueForSliceAtIndex:(NSUInteger)index;

@optional
- (UIColor *)pieChart:(BFPieRenderView *)pieChart colorForSliceAtIndex:(NSUInteger)index;

@end

@protocol RenderViewtDelegate <NSObject>

@optional
- (void)pieChart:(BFPieRenderView *)pieChart willSelectSliceAtIndex:(NSUInteger)index;

- (void)pieChart:(BFPieRenderView *)pieChart didSelectSliceAtIndex:(NSUInteger)index;

- (void)pieChart:(BFPieRenderView *)pieChart willDeselectSliceAtIndex:(NSUInteger)index;

- (void)pieChart:(BFPieRenderView *)pieChart didDeselectSliceAtIndex:(NSUInteger)index;

- (void)animateFinish:(BFPieRenderView *)pieChart;

@end

@interface BFPieRenderView : BFView

@property(nonatomic, weak) id<RenderViewDataSource> dataSource;

@property(nonatomic, weak) id<RenderViewtDelegate> delegate;

@property(nonatomic, assign) CGFloat startPieAngle;

@property(nonatomic, assign) CGFloat animationSpeed;

@property(nonatomic, assign) CGPoint pieCenter;

@property(nonatomic, assign) CGFloat pieRadius;

@property(nonatomic, assign) BOOL    showLabel;

@property(nonatomic, strong) UIFont  *labelFont;

@property(nonatomic, assign) CGFloat labelRadius;

@property(nonatomic, assign) CGFloat selectedSliceStroke;

@property(nonatomic, assign) CGFloat selectedSliceOffsetRadius;

@property(nonatomic, assign) BOOL    showPercentage;

@property (nonatomic , assign) BOOL isShowTextLayer;

@property (nonatomic , assign) BOOL isUserInteractionEnabled;


- (id)initWithFrame:(CGRect)frame Center:(CGPoint)center Radius:(CGFloat)radius;

- (void)reloadData;

- (void)setPieBackgroundColor:(UIColor *)color;

- (void)pieSelected:(NSInteger)selIndex;

// 创建Layer上的文本
- (SliceLayer *)createSliceLayer;

@end
