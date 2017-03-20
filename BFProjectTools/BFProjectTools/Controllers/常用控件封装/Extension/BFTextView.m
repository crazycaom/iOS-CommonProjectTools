//
//  BFTextView.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFTextView.h"

@interface BFTextView ()
{
    // 显示placeHolder
    BFLabel *_placeHoderLabel;
}

@end

@implementation BFTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _placeHoderLabel = [self placeHoderLabel];
    }
    
    return self;
}

#pragma mark - placeHoderLabelAction
- (BFLabel *)placeHoderLabel
{
    if (_placeHoderLabel == nil) {
        _placeHoderLabel = [UIKitTools labelWith:CGRectMake(3, 8, self.frame.size.width, 20) font:self.font textColor:[UIColor lightGrayColor]];
        [self addSubview:_placeHoderLabel];
    }
    
    return _placeHoderLabel;
}

#pragma mark - set
- (void)setPlaceholderFrame:(CGRect)placeholderFrame
{
    _placeholderFrame = placeholderFrame;
    _placeHoderLabel.frame = placeholderFrame;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    if ([NSString isNil:placeholder]) {
        _placeHoderLabel.hidden = YES;
    } else {
        _placeHoderLabel.text = placeholder;
        _placeHoderLabel.hidden = NO;
    }
}

#pragma mark - 重写
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [_placeHoderLabel setFont:font];
}

- (BOOL)becomeFirstResponder
{
    [self setPlaceholder:nil];
    
    return [super becomeFirstResponder];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    if (text && text.length) {
        [self setPlaceholder:nil];
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
