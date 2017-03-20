//
//  ActionButton.m
//  BizfocusExpense
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 cathy. All rights reserved.
//

#import "ActionButton.h"

static NSInteger const kDefaultActionButtonTag = 710;

@interface ActionViewButton ()
{

}

@property (nonatomic, copy) NSString *identify;

@end

@implementation ActionViewButton

+ (instancetype)buttonWith:(CGRect)frame font:(UIFont *)font title:(NSString *)titleText textColor:(UIColor *)textColor tag:(NSInteger)tag identify:(NSString *)identify {
    ActionViewButton *customButton = [[ActionViewButton alloc] initWithFrame:frame];
    customButton.tag = tag;
    
    if (titleText) {
        if (font == nil) {
            font = [UIKitTools defaultFont];
        }
        
        if (textColor == nil) {
            textColor = [UIKitTools defaultColor];
        }
        [customButton setTitle:titleText forState:UIControlStateNormal];
        customButton.titleLabel.font = font;
        [customButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    customButton.identify = identify;
    return customButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *frontLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.height)];
        frontLine.backgroundColor = [UIColor grayColor];
        [self addSubview:frontLine];
        
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setIdentify:(NSString *)identify {
    _identify = identify;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeWidth:) name:[NSString stringWithFormat:kActionViewButtonChangeWidthNotification,_identify] object:nil];
}

- (void)clickAction {
    if (_clickBlock) {
        _clickBlock();
    }
}

- (void)changeWidth:(NSNotification *)noti {
    self.width = [noti.object floatValue];
    self.x = self.width * (self.tag - kDefaultActionButtonTag);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
