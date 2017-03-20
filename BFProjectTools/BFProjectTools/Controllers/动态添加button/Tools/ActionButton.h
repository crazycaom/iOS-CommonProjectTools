//
//  ActionButton.h
//  BizfocusExpense
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 cathy. All rights reserved.
//

#import "BFButton.h"
@class ActionViewButton;

typedef void (^ActionViewButtonClickBlock)();
static NSString *const kActionViewButtonChangeWidthNotification = @"kActionViewButtonChangeWidthNotification%@";

@interface ActionViewButton : BFButton

+ (instancetype)buttonWith:(CGRect)frame
                      font:(UIFont *)font
                     title:(NSString *)titleText
                 textColor:(UIColor *)textColor
                       tag:(NSInteger)tag
                  identify:(NSString *)identify;

@property (nonatomic, copy) ActionViewButtonClickBlock clickBlock;


@end
