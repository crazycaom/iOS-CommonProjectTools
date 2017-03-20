//
//  NSObject+Network.h
//  CreateNewProject
//
//  Created by CaoMeng on 16/4/28.
//  Copyright © 2016年 CM. All rights reserved.
//  NSObject 扩展NetworkAction 参考GymBomate数据请求的封装

#import <Foundation/Foundation.h>

@interface NSObject (Network)

//// 判断对象的类型
// String
+ (BOOL)isKindOfString:(id)value;
// Dictionary
+ (BOOL)isKindOfDic:(id)value;
// Array
+ (BOOL)isKindOfArray:(id)value;


// 根据字典数据封装数据
- (void)parseFromDictionary:(NSDictionary *)paraDatas;

/**
 *  将某个对象转化成字典类型
 *
 *  @param object 对象
 *
 *  @return 对应的字典
 */
+ (NSDictionary *)dictionaryFromObject:(NSObject *)object;

/**
 *  将当前对象转化为字典
 *
 *  @return 对应的字典
 */
- (NSDictionary *)paramsDictionary;

@end
