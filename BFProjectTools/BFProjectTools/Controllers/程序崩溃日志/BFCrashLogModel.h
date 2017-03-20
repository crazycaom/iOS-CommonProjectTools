//
//  BFCrashLogModel.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFCrashLogModel : NSObject

/// 设备的ID
@property(nonatomic,strong)NSString *deviceUUID;

/// 当前系统的版本
@property(nonatomic,strong)NSString *currentSystemVerAndName;

/// 当前APP的版本
@property(nonatomic,strong)NSString *currentAppVer;

/// 用户信息
@property(nonatomic,strong)NSString *userInfo;

/// 时间
@property(nonatomic,strong)NSString *logTime;

/// 异常名称
@property(nonatomic,strong)NSString *crashName;

/// 原因
@property(nonatomic,strong)NSString *reason;

/// 异常堆栈信息
@property(nonatomic,strong)NSString *stackArrayInfo;

@end
