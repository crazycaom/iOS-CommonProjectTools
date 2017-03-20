//
//  BFActionView.h
//  BizfocusExpense
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 cathy. All rights reserved.
//

#import "BFView.h"
@class ActionViewButton;

@interface BFActionView : BFView

- (instancetype)initWithIdentify:(NSString *)identify;

- (void)addButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectBlock:(void (^) (void))selectBlock;

- (void)removeButtonAtIndex:(NSInteger)index;

- (ActionViewButton *)selectButtonAtIndex:(NSInteger)index;

@end
