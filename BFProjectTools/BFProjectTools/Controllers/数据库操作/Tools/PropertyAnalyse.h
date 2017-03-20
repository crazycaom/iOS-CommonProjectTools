//
//  PropertyAnalyse.h
//  ObjectDatabase
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

//获取属性字典的属性类型列表
static NSString *const kPropertyDictionary_PropertyClassKey = @"kPropertyDictionary_PropertyClassKey";
//获取属性字典的属性名列表
static NSString *const kPropertyDictionary_PropertyNameKey = @"kPropertyDictionary_PropertyNameKey";
//获取属性字典的属性值列表
static NSString *const kPropertyDictionary_PropertyValueKey = @"kPropertyDictionary_PropertyValueKey";

@interface PropertyAnalyse : NSObject

//获取一个类中所有属性类型和属性名 @{NSString : myName}
+ (NSDictionary *)getAllPropertiesFromClass:(Class)targetClass;

//获取一个对象的所有属性名和属性值
+ (NSDictionary *)getPropertiesInObj:(id)obj;

+ (NSString *)removeNull:(id)obj;

@end
