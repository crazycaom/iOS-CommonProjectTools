//
//  ObjectDatabase.m
//  ObjectDatabase
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

#import "ObjectDatabase.h"
#import "PropertyAnalyse.h"
#import <FMDatabase.h>

#if DEBUG
#define OBJLog(...) NSLog(__VA_ARGS__)
#else
#define OBJLog(...)
#endif


FMDatabase *_database;
@implementation ObjectDatabase

+ (instancetype)shareDataBase
{
    static ObjectDatabase *dataBase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[ObjectDatabase alloc] init];
    });
    return dataBase;
}

// 创建数据库
- (void)createDataBase:(NSString *)name
{
    NSString *path=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),name];
    OBJLog(@"数据库地址:%@",path);
    _database=[[FMDatabase alloc]initWithPath:path];
    
    if ([_database open]) {
        OBJLog(@"数据库创建成功！！");
    }else{
        OBJLog(@"数据库创建失败！！");
    }
}

#pragma mark ------ tools
- (BOOL)openDatabase {
    if (![_database open]) {
        OBJLog(@"数据库开启失败");
        return NO;
    }
    return YES;
}

- (BOOL)closeDatabase {
    if (![_database close]) {
        OBJLog(@"数据库关闭失败");
        return NO;
    }
    return YES;
}

- (BOOL)insertSql:(NSString *)sql {
    if (![_database executeUpdate:sql]) {
        OBJLog(@"插入数据库失败! sql语句 : %@",sql);
        return NO;
    }
    return YES;
}

- (BOOL)updateSql:(NSString *)sql {
    if (![_database executeUpdate:sql]) {
        OBJLog(@"更新数据库失败! sql语句 : %@",sql);
        return NO;
    }
    return YES;
}

//返回某张表对应的model的class
- (Class)modelClassInTable:(NSString *)table {
    NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM %@ where rowId = 1",table];
    FMResultSet *set = [_database executeQuery:selectSql];
    NSString *trueClass = @"";
    while (set.next) {
        trueClass = [set stringForColumn:kPropertyModel_Identify];
    }
    return NSClassFromString(trueClass);
}

//判断传入模型是否是建表时传入的模型 (属性是否匹配)
- (BOOL)isModelClass:(Class)modelClass belongToTable:(NSString *)table {
    NSString *trueClass = NSStringFromClass([self modelClassInTable:table]);
    return [NSStringFromClass([modelClass class]) isEqualToString:trueClass];
}

//根据propertyClass返回数据在数据库中的类型
- (NSString *)classNameByPropertyClass:(NSString *)propertyClass {
    if ([propertyClass isEqualToString:@"NSString"]) {
        return @"text";
    }
    if ([propertyClass isEqualToString:@"q"] || [propertyClass isEqualToString:@"i"]) {
        return @"integer";
    }
    if ([propertyClass isEqualToString:@"d"]) {
        return @"double";
    }
    return @"";
}

#pragma mark ------ 数据库相关操作
//用modelClass的类 , 创建数据库
- (void)createTable:(NSString *)tableName usingModelClass:(Class)modelClass {
    [self openDatabase];
    
    NSString *createSql = @"CREATE TABLE IF NOT EXISTS %@ (%@ text%@)";
    NSString *param = @"";
    NSDictionary *properties = [PropertyAnalyse getAllPropertiesFromClass:modelClass];
    NSArray *classArr = [properties objectForKey:kPropertyDictionary_PropertyClassKey];
    NSArray *nameArr = [properties objectForKey:kPropertyDictionary_PropertyNameKey];
    for (int i = 0; i<classArr.count; i++) {
        param = [param stringByAppendingString:[NSString stringWithFormat:@",%@ %@",nameArr[i],[self classNameByPropertyClass:classArr[i]]]];
    }
    NSString *lastSql = [NSString stringWithFormat:createSql,tableName,kPropertyModel_Identify,param];
    if (![_database executeUpdate:lastSql]) {
        OBJLog(@"创建表:%@失败!",tableName);
    }
    
    //判断表是否为空
    NSString *judgeSql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    if (![_database executeQuery:judgeSql].next) {
        //数据库中没有元素 , 则插入模型identify
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@') VALUES ('%@')",tableName,kPropertyModel_Identify,NSStringFromClass(modelClass)];
        [self insertSql:insertSql];
    }
    
    [self closeDatabase];
}

//讲模型数组插入到数据库中
- (void)insert:(NSArray *)modelArray toTable:(NSString *)table {
    BOOL succeed = YES;
    [self openDatabase];
    
    if (![self isModelClass:modelArray[0] belongToTable:table]) {
        NSAssert(DEBUG, @"模型和表不匹配!");
    }
    
    [_database beginTransaction];
    for (id model in modelArray) {
        if (![self insertModel:model toTable:table]) {
            succeed = NO;
            break;
        }
    }
    if (succeed) {
        [_database commit];
    } else {
        [_database rollback];
    }
    [self closeDatabase];
    
}

//插入模型
- (BOOL)insertModel:(id)model toTable:(NSString *)table {
    NSString *insertSql = @"INSERT INTO %@ (%@) VALUES (%@)";
    NSMutableString *values = [NSMutableString string];
    NSMutableString *keys = [NSMutableString string];
    
    NSDictionary *property = [PropertyAnalyse getPropertiesInObj:model];
    
    NSArray *nameArr = [property objectForKey:kPropertyDictionary_PropertyNameKey];
    NSArray *valueArr = [property objectForKey:kPropertyDictionary_PropertyValueKey];
    for (int i = 0 ; i<nameArr.count; i++) {
        if (i >= valueArr.count) {
            break;
        }
        [keys appendFormat:@"'%@',",nameArr[i]];
        [values appendFormat:@"'%@',",valueArr[i]];
    }
    [keys deleteCharactersInRange:NSMakeRange(keys.length - 1, 1)];
    [values deleteCharactersInRange:NSMakeRange(values.length - 1, 1)];
    NSString *lastSql = [NSString stringWithFormat:insertSql,table,keys,values];
    return [self insertSql:lastSql];
}

//删除表中所有数据 , 除了第一行记录该表模型类型的数据
- (void)deleteDataInTable:(NSString *)table {
    [self openDatabase];
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ where rowId != 1",table];
    [self updateSql:deleteSql];
    [self closeDatabase];
}

//删除表
- (void)dropTable:(NSString *)table {
    [self openDatabase];
    NSString *dropSql = [NSString stringWithFormat:@"DROP TABLE %@",table];
    if (![_database executeUpdate:dropSql]) {
        OBJLog(@"废弃表: %@ 失败!",table);
    }
    [self closeDatabase];
}

//查询
- (NSArray *)selectFromTable:(NSString *)tableName targets:(NSString *)targets arguments:(NSString *)arguments {
    NSMutableArray *array = [NSMutableArray array];
    [_database open];
    Class targetClass = [self modelClassInTable:tableName];
    if (!targets || !targets.length) {
        targets = @"*";
    } else {
        targets = [NSString stringWithFormat:@"%@ , %@",kPropertyModel_Identify,targets];
    }
    NSString *selectSql = [NSString stringWithFormat:@"SELECT %@ FROM %@ %@",targets,tableName,[PropertyAnalyse removeNull:arguments]];
    FMResultSet *set = [_database executeQuery:selectSql];
    
    NSDictionary *propertyDict = [PropertyAnalyse getAllPropertiesFromClass:targetClass];
    NSArray *propertyNameArray = [propertyDict objectForKey:kPropertyDictionary_PropertyNameKey];
    NSArray *propertyClassArray = [propertyDict objectForKey:kPropertyDictionary_PropertyClassKey];

    while (set.next) {
        id obj = [[targetClass alloc] init];
        if ([set stringForColumn:kPropertyModel_Identify].length) {
            continue;
        }
        //第一行为model类型 , 不需要遍历
        for (int i = 1; i<set.columnCount; i++) {
            //行名
            NSString *columName = [set columnNameForIndex:i];
            //该行的属性类型
            NSString *columPropertyClass = propertyClassArray[[propertyNameArray indexOfObject:columName]];
            if (columPropertyClass == nil) {
                continue;
            }
            
            if ([columPropertyClass isEqualToString:@"NSString"]) {
                //查询到的结果
                NSString *string = [PropertyAnalyse removeNull:[set stringForColumnIndex:i]];
                [obj setValue:string forKey:columName];
            } else if ([columPropertyClass isEqualToString:@"c"]) {
                BOOL target = [set boolForColumnIndex:i];
                [obj setValue:[NSNumber numberWithBool:target] forKey:columName];
            } else if ([columPropertyClass isEqualToString:@"q"] || [columPropertyClass isEqualToString:@"i"]) {
                NSInteger target = [set intForColumnIndex:i];
                [obj setValue:[NSNumber numberWithInteger:target] forKey:columName];
            } else if ([columPropertyClass isEqualToString:@"d"]) {
                double target = [set doubleForColumnIndex:i];
                [obj setValue:[NSNumber numberWithDouble:target] forKey:columName];
            } else if ([columPropertyClass isEqualToString:@"NSData"]) {
                NSData *target = [set dataForColumnIndex:i];
                [obj setValue:target forKey:columName];
            }
        }
        [array addObject:obj];
    }
    [_database close];
    return array;
}

//更新
- (BOOL)update:(id)obj inTable:(NSString *)tableName arguments:(NSString *)arguments {
    BOOL succeed;
    [self openDatabase];
    NSString *updateSql = @"UPDATE %@ SET";
    NSDictionary *propertyDict = [PropertyAnalyse getPropertiesInObj:obj];
    NSArray *nameArr = [propertyDict objectForKey:kPropertyDictionary_PropertyNameKey];
    NSArray *valueArr = [propertyDict objectForKey:kPropertyDictionary_PropertyValueKey];
    for (int i = 0; i<nameArr.count; i++) {
        updateSql = [updateSql stringByAppendingString:[NSString stringWithFormat:@"%@ = '%@',",nameArr[i],[PropertyAnalyse removeNull:valueArr[i]]]];
    }
    updateSql = [updateSql substringToIndex:updateSql.length - 1];
    updateSql = [updateSql stringByAppendingString:arguments];
    succeed = [self updateSql:[NSString stringWithFormat:updateSql,tableName]];
    [self closeDatabase];
    return succeed;
}

@end
