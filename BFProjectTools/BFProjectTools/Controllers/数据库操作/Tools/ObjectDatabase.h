//
//  ObjectDatabase.h
//  ObjectDatabase
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

//标记表对应属性模型的key
static NSString *const kPropertyModel_Identify = @"kPropertyModel_Identify";

@interface ObjectDatabase : NSObject

////// 单例
+ (instancetype)shareDataBase;

////// 创建数据库
- (void)createDataBase:(NSString *)name;

//根据模型类型创建表
- (void)createTable:(NSString *)tableName usingModelClass:(Class)modelClass;

//将模型数组插入到数据库中 , 插入的模型类型应是建表时的类型
- (void)insert:(NSArray *)modelArray toTable:(NSString *)table;

- (BOOL)update:(id)obj inTable:(NSString *)tableName arguments:(NSString *)arguments;

//查询数据库
- (NSArray *)selectFromTable:(NSString *)tableName targets:(NSString *)targets arguments:(NSString *)arguments;

//删除表中所有数据
- (void)deleteDataInTable:(NSString *)table;

//删除表
- (void)dropTable:(NSString *)table;

@end
