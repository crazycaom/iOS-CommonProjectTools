//
//  BFButton.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFButton : UIButton

/**
 按钮后面追加圆点进行标记

 @param unread 是否进行标记
 */
- (void)setUnread:(BOOL)unread;


/**
 设置按钮徽标

 @param bedgeValue 徽标个数
 */
- (void)setBadgeValue:(NSString *)bedgeValue;


/// 后期根据具体的项目进行定义统一样式

@end
