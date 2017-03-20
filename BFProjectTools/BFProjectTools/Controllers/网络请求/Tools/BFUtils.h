//
//  BFUtils.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFUtils : NSObject

////// 单例
+(instancetype)shareUtils;

// HUD
+ (void) hudShow;
+ (void) hudShowWithMessage:(NSString *) msg;
+ (void) hudSuccessHidden;
+ (void) hudSuccessHidden:(NSString *) msg;
+ (void) hudFailHidden;
+ (void) hudFailHidden:(NSString *) msg;


@end
