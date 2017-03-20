//
//  NetManager.h
//  AFNetWorkingDemo
//
//  Created by CaoMeng on 16/8/19.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define kRequestPic         @"kRequestPic"

@interface NetManager : NSObject

// 服务器共用root链接目录
@property(nonatomic,strong) NSString        *severRoot;

// 单例
+ (id)sharedManager;

/**
 *  通过GET请求服务
 *
 *  @param url   路径
 *  @param paraDic 参数
 *  @param hudDic  HUD的显示
 *  @param success 成功
 *  @param failure 失败
 */
- (void)GETRequestWebWithURL:(NSString *)url
                   paramters:(NSDictionary *)paraDic
                  hudString : (NSDictionary*) hudDic
                    success : (void (^)(id responseDic)) success
                    failure : (void(^)(id errorString)) failure;

/**
 *  通过POST请求服务
 *
 *  @param url   路径
 *  @param paraDic 参数
 *  @param hudDic  HUD的显示
 *  @param success 成功
 *  @param failure 失败
 */
- (void)POSTRequestWebWithURL:(NSString *)url
                    paramters:(NSDictionary *)paraDic
                   hudString : (NSDictionary*) hudDic
                     success : (void (^)(id responseDic)) success
                     failure : (void(^)(id errorString)) failure;

@end
