//
//  UIView+Rect.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Rect)

/// x
@property (nonatomic,assign) CGFloat x;

/// y
@property (nonatomic,assign) CGFloat y;

/// centerX
@property (nonatomic,assign) CGFloat centerX;

/// centerY
@property (nonatomic,assign) CGFloat centerY;

/// width
@property (nonatomic,assign) CGFloat width;

/// height
@property (nonatomic,assign) CGFloat height;

/// size
@property (nonatomic,assign) CGSize size;

/// maxX
@property (nonatomic,assign) CGFloat maxX;

/// maxY
@property (nonatomic,assign) CGFloat maxY;

/**
 增加画面边框

 @param color  边框颜色
 @param width  边框宽短
 @param radius 边框的圆角幅度
 */
-(void)addBorderLineWithLineColor:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)radius;


@end
