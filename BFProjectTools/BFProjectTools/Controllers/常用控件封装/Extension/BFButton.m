//
//  BFButton.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFButton.h"

@interface BFButton()
{
    UIView          *_iconView;
    
    BFLabel         *_badgeLable;
}

@end

@implementation BFButton

- (void)setUnread:(BOOL)unread
{
    if (_iconView == nil) {
        CGFloat width = 10;
        CGFloat radius = 5;
        _iconView = [[UIView alloc]initWithFrame:CGRectMake(self.width - width - 5, (self.height - radius*2)/2, width, width)];
        _iconView.layer.cornerRadius = radius;
        _iconView.layer.masksToBounds = YES;
        [_iconView setBackgroundColor:[UIColor redColor]];
    }
    
    if (unread) {
        [self addSubview:_iconView];
    } else {
        [_iconView removeFromSuperview];
    }
}

- (void)setBadgeValue:(NSString *)bedgeValue
{
    CGFloat width = 20;
    CGFloat radius = width * 0.5;
    
    if(_badgeLable == nil){
        _badgeLable = [UIKitTools labelWith:CGRectMake(self.width - width, -width/2, width, width) font:[UIKitTools projectFontWith:14] textColor:[UIColor whiteColor]];
        _badgeLable.layer.cornerRadius = radius;
        _badgeLable.layer.masksToBounds = YES;
        _badgeLable.textAlignment = NSTextAlignmentCenter;
        [_badgeLable setBackgroundColor:[UIColor redColor]];
    }
    
    // 设置徽标Value
    if([bedgeValue integerValue] <= 99){
        bedgeValue = bedgeValue;
    }else{
        _badgeLable.font = [UIKitTools projectFontWith:10];
        bedgeValue = @"99+";
    }
    _badgeLable.text = bedgeValue;
    
    // 判断是否显示徽标
    if([bedgeValue integerValue] != 0){
        [self addSubview:_badgeLable];
    }else{
        [_badgeLable removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
