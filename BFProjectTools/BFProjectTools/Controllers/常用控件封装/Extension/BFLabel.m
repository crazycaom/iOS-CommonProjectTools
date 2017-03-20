//
//  BFLabel.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//  

#import "BFLabel.h"

@implementation BFLabel

- (void)setIsDIYStyle:(BOOL)isDIYStyle
{
    if (isDIYStyle) {
        [self setBackgroundColor:[UIColor redColor]];
        [self setTextColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:self.height / 2];
        [self.layer setMasksToBounds:YES];
    } else {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor lightTextColor]];
        [self.layer setCornerRadius:0];
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
