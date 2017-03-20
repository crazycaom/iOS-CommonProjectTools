//
//  UIView+Rect.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "UIView+Rect.h"

@implementation UIView (Rect)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = isnan(x) ? 0 : x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = isnan(y) ? 0 : y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = isnan(centerX) ? 0 : centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = isnan(centerY) ? 0 : centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = isnan(width) ? 0 : width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = isnan(height) ? 0 : height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setMaxX:(CGFloat)maxX{
    CGRect frame = self.frame;
    double offset = maxX - CGRectGetMaxX(frame);
    frame.origin.x += offset;
    self.frame = frame;
}

- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY{
    CGRect frame = self.frame;
    double offset = maxY - CGRectGetMaxY(frame);
    frame.origin.x += offset;
    self.frame = frame;
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

-(void)addBorderLineWithLineColor:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)radius
{
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}


@end
