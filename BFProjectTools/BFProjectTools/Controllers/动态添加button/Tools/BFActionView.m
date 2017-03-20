//
//  BFActionView.m
//  BizfocusExpense
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 cathy. All rights reserved.
//

#import "BFActionView.h"
#import "ActionButton.h"

static CGFloat const kActionViewHeight = 60;

static NSInteger const kDefaultActionButtonTag = 710;



@interface BFActionView ()
{
    NSMutableArray *_buttonArray;
    
    NSString *_identify;
}

@end

@implementation BFActionView

- (instancetype)initWithIdentify:(NSString *)identify {
    if (self = [super initWithFrame:CGRectMake(-1, SCREEN_HEIGHT - 64 - kActionViewHeight, SCREEN_WIDTH + 2, kActionViewHeight)]) {
        _identify = identify;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.5;
        _buttonArray = [NSMutableArray array];
    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectBlock:(void (^)(void))selectBlock {
    CGFloat eachButtonWidth = self.width / (_buttonArray.count + 1);
    ActionViewButton *button = [ActionViewButton buttonWith:CGRectMake(eachButtonWidth * _buttonArray.count, 0, eachButtonWidth, self.height) font:[UIKitTools projectFontWith:16] title:title textColor:titleColor tag:kDefaultActionButtonTag + _buttonArray.count identify:_identify];
    button.clickBlock = selectBlock;
    //改变之前添加的button的width
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:kActionViewButtonChangeWidthNotification,_identify] object:@(eachButtonWidth)];
    
    [self addSubview:button];
    [_buttonArray addObject:button];
}

- (void)removeButtonAtIndex:(NSInteger)index {
    ActionViewButton *button = _buttonArray[index];
    [button removeFromSuperview];
    [_buttonArray removeObject:button];
    button = nil;
    for (int i = index; i<_buttonArray.count; i++) {
        ActionViewButton *nextBtn = _buttonArray[i];
        nextBtn.tag = nextBtn.tag - 1;
    }
    CGFloat eachWidth = self.width / (_buttonArray.count);
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:kActionViewButtonChangeWidthNotification,_identify] object:@(eachWidth)];
}

- (ActionViewButton *)selectButtonAtIndex:(NSInteger)index {
    return _buttonArray[index];
}


@end
