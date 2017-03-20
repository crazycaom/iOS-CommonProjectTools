//
//  BFView.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFView.h"

@implementation BFView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect resetFarme = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    self = [super initWithFrame:resetFarme];
    if (self) {
        // 创建画面
        [self createView];
    }
    
    return self;
}

// 创建画面
- (void)createView
{
    
}

// 刷新画面
- (void)refreshView
{
    
}

// closeKeyboard
- (void)closeKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self endEditing:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
