//
//  BFMyNoticeModel.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFMyNoticeModel : NSObject

/// 标题
@property(nonatomic,strong) NSString        *item;

/// 内容
@property(nonatomic,strong) NSString        *content;

/// 创建时间
@property(nonatomic,strong) NSString        *createTimeStr;

/// 创建用户
@property(nonatomic,strong) NSString        *createUser;

/// 状态
@property (nonatomic,strong) NSString       *status;

/// 最新公告
@property(nonatomic,strong) NSString        *recordStatus;

/// 公告类型
@property(nonatomic,strong) NSString        *type;

@end
