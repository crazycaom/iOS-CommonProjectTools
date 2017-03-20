//
//  UIImageView+BFImageView.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/17.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (BFImageView)

/**
 绘制圆形头像
 
 @param frame       要绘制imageView的frame
 @param name        imageName
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 
 @return imageView
 */
+ (UIImageView *)circleImageViewWithFrame:(CGRect)frame andImageName:(NSString *)name andBorderColor:(UIColor *)borderColor andBorderWidth:(CGFloat)borderWidth;

@end
