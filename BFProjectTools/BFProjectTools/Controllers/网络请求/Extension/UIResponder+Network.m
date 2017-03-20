//
//  UIResponder+Network.m
//  AFNetWorkingDemo
//
//  Created by CaoMeng on 16/8/19.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "UIResponder+Network.h"
#import "NetManager.h"

@implementation UIResponder (Network)

// 根据URL and paraObject 进行Post请求
- (void)executeRequestWithURL:(NSString *)URL
                         para:(NSObject *)paraObject
{
    NSString *aMethod = nil;
    NSMutableDictionary *dictionary = nil;
    
    // 如果当前是对象，那么转化为字典
    if ([NSObject isKindOfDic:paraObject]) {
        dictionary = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)paraObject];
    } else {
        dictionary = [NSMutableDictionary dictionaryWithDictionary:[NSObject dictionaryFromObject:paraObject]];
    }
    
#warning aMethod
    // dictionary[@"method"]有值,则用uri作为aMethod,否则用url作为aMethod
    aMethod = dictionary[@"method"]?dictionary[@"method"]:URL;
    
    [[NetManager sharedManager] POSTRequestWebWithURL:URL paramters:dictionary hudString:nil success:^(id responseDic) {
        [self responseData:responseDic method:aMethod];
    } failure:^(id errorString) {
        [self serviceDidFailed:errorString method:aMethod];
    }];
}

// 获取返回的数据
- (void)responseData:(id)data method:(NSString *)aMethod
{
    [self serviceDidSucceed:data method:aMethod];
}

// 获取返回数据成功
- (void)serviceDidSucceed:(NSDictionary *)responseData method:(NSString *)aMethod
{
    
}

// 获取返回数据失败
- (void)serviceDidFailed:(NSString *)failedMessage method:(NSString *)aMethod
{
    
}


@end
