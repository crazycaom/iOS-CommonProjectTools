//
//  UIResponder+Network.h
//  AFNetWorkingDemo
//
//  Created by CaoMeng on 16/8/19.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Network)

/**
 *  请求服务POST方式
 *
 *  @param URL        地址
 *  @param paraObject 参数
 *  @param hudDic     HUD参数
 */
- (void)executeRequestWithURL:(NSString *)URL
                         para:(NSObject *)paraObject;



/**
 *  请求成功后的操作
 *
 *  @param responseData 返回值
 */
- (void)serviceDidSucceed:(NSDictionary *)responseData
                   method:(NSString *)aMethod;

/**
 *  请求失败的操作
 *
 *  @param failedMessage 失败信息
 */
- (void)serviceDidFailed:(NSString *)failedMessage
                  method:(NSString *)aMethod;

@end
