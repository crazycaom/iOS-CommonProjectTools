//
//  UIImageView+BFImageView.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/17.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "UIImageView+BFImageView.h"

@implementation UIImageView (BFImageView)

+ (UIImageView *)circleImageViewWithFrame:(CGRect)frame andImageName:(NSString *)name andBorderColor:(UIColor *)borderColor andBorderWidth:(CGFloat)borderWidth
{
    UIImageView *circleImageView = [[UIImageView alloc] initWithFrame:frame];
    circleImageView.image = [UIImage imageNamed:name];
    circleImageView.layer.masksToBounds = YES;
    circleImageView.layer.cornerRadius = circleImageView.bounds.size.width * 0.5;
    circleImageView.layer.borderWidth = borderWidth;
    circleImageView.layer.borderColor = borderColor.CGColor;
    
    return  circleImageView;
}

@end
