//
//  NSObject+Network.m
//  CreateNewProject
//
//  Created by CaoMeng on 16/4/28.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "NSObject+Network.h"
#import "NSString+Validation.h"
#import "objc/runtime.h"

static NSString * getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            return [[NSString alloc]initWithBytes:(attribute + 1) length:(strlen(attribute) - 1) encoding:NSUTF8StringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return @"id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            
            return [[NSString alloc]initWithBytes:(attribute + 3) length:(strlen(attribute) - 4) encoding:NSUTF8StringEncoding];
        }
    }
    return @"";
}


static NSArray *_allKey;

@implementation NSObject (Network)

- (NSMutableArray *)allValue
{
    _allKey = [[NSObject propertyName:[self class]] allKeys];
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in _allKey) {
        NSObject *object = [self valueForKey:key];
        
        if (object) {
            [array addObject:object];
        }
    }
    return array;
}

- (void)parseFromDictionary:(NSDictionary *)paraDatas
{
    NSDictionary *prop = [NSObject propertyName:[self class]] ;
    _allKey = [prop allKeys];
    for (NSString *eachKey in _allKey) {
        id value = [paraDatas valueForKey:eachKey];
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        NSString *propertyType = [prop objectForKey:eachKey];
        
        if ([propertyType isStringType]) {
            // 字符串
            [self setValue:[NSString removeNull:value] forKey:eachKey];
            
        } else if ([propertyType isDictionaryType]){
            // 字典格式
            [self setValue:value forKey:eachKey];
            
        } else if ([propertyType isArrayType]) {
            // 数组格式
            NSArray *array = [self parseFromArray:value key:eachKey];
            [self setValue:array forKey:eachKey];
        } else if ([propertyType isEqualToString:@"i"]){
            // 如果是nsinteger类型
            [self setValue:value forKey:eachKey];
            
        } else {
            // 自定义对象
            NSString *string = eachKey;
            
#warning Tips自定义类型的转换
            // eg : gymbomate中的自定义分页Model
            //if ([eachKey isEqualToString:@"pager"]) {
            //    string = @"pagerDto";
            //}
            
            Class child = NSClassFromString(string);
            NSObject *childObj = [[child alloc]init];
            [childObj parseFromDictionary:value];
            
            [self setValue:childObj forKey:eachKey];
        }
    }
}

- (NSArray *)parseFromArray:(NSArray *)array key:(NSString *)key
{
    NSMutableArray *targetArray = [NSMutableArray array];
    
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    for (NSObject *value in array) {
        
        NSObject *changeValue = value;
        if ([NSObject isKindOfString:changeValue]) {
            // 数组里都是字符串
            [targetArray addObject:changeValue];
            
        } else if ([NSObject isKindOfDic:changeValue]) {
            // 数组里是字典
            NSDictionary *dictionary = (NSDictionary *)changeValue;
            NSString *className = key;
            
#warning    Tips特殊判断
            // 请求数据一个Model中 存在两个List集合 返回集合中存放相同类型的Model 需要特殊判断
            // eg. one
            //if ([key isEqualToString:@"childDept"] ||
            //    [key isEqualToString:@"deptList"]) {
            //    className = @"DepartmentModel";
            //}
            // eg.two
            //NSArray *customer360Array = @[@"performanceDetailDtoList",@"previewMonthDetailDtoList"];
            //if ([customer360Array containsObject:key]) {
            //    className = @"performanceDetailDto";
            //}
            
            Class child = NSClassFromString(className);
            if (child == nil) {
                return @[];
            }
            
            NSObject *childObj = [[child alloc]init];
            
            [childObj parseFromDictionary:dictionary];
            [targetArray addObject:childObj];
        } else if ([NSObject isKindOfArray:changeValue]) {
            // 数组里嵌套数组
            NSArray *childArray = (NSArray *)changeValue;
            [targetArray addObject:[self parseFromArray:childArray key:key]];
        }
    }
    
    return targetArray;
}

+ (BOOL)isKindOfString:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isKindOfDic:(id)value
{
    if ([value isKindOfClass:[NSDictionary class]] ||
        [value isKindOfClass:[NSMutableDictionary class]]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isKindOfArray:(id)value
{
    if ([value isKindOfClass:[NSArray class]] ||
        [value isKindOfClass:[NSMutableArray class]]) {
        return YES;
    }
    
    return NO;
}

// 获取类的属性名
+ (NSDictionary *)propertyName:(Class)object
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    NSString *className = NSStringFromClass(object);
    const char *name = [className cStringUsingEncoding:NSASCIIStringEncoding ];
    id peopleClass = objc_getClass(name);
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(peopleClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        
        NSString *type = getPropertyType(property);
        
        [dictionary setObject:type forKey:propName];
    }
    
    free(properties);
    
    return dictionary;
}


#pragma mark ----- 将对象转化为字典
+ (NSDictionary *)dictionaryFromObject:(NSObject *)object
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *keys = [[NSObject propertyName:[object class]]allKeys];
    for (NSString *eachKey in keys) {
        id value = [object valueForKey:eachKey];
        
        // 如果当前值是数组，那么继续解析
        if ([NSObject isKindOfArray:value]) {
            NSArray *paraArray = [self paramsArrayFrom:value key:eachKey];
            [dictionary setObject:paraArray forKey:eachKey];
        } else {
            value = [NSString removeNull:value];
            [dictionary setObject:value forKey:eachKey];
        }
    }
    return dictionary;
}


- (NSDictionary *)paramsDictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    NSDictionary *prop = [NSObject propertyName:[self class]];
    NSArray *keys = [prop allKeys];
    
    for (NSString *eachKey in keys) {
        id value = [self valueForKey:eachKey];
        
        
        NSString *pType = [prop objectForKey:eachKey];
        
        //// 判读属性的类型
        if ([pType isStringType]) {
            value = [NSString removeNull:value];
            [dictionary setObject:value forKey:eachKey];
        } else if ([pType isArrayType]) {
            NSArray *paraArray = [self paramsArrayFrom:value key:eachKey];
            [dictionary setObject:paraArray forKey:eachKey];
            
        } else if ([pType isDictionaryType]) {
            [dictionary setObject:value forKey:eachKey];
        } else {
            NSDictionary *targetDic = [value paramsDictionary];
            if (targetDic == nil) {
                targetDic = @{};
            }
            [dictionary setObject:targetDic forKey:eachKey];
        }
    }
    
    return dictionary;
}

- (NSArray *)paramsArrayFrom:(NSArray *)array key:(NSString *)key
{
    id firstObject = [array firstObject];
    if ([NSObject isKindOfString:firstObject] ||
        [NSObject isKindOfDic:firstObject]) {
        //// 数组里是字符串,或者是字典的话
        return array;
    }
    
    NSMutableArray *targetArray = [NSMutableArray array];
    for (NSObject *object in array) {
        NSDictionary *dictionary = [NSObject dictionaryFromObject:object];
        [targetArray addObject:dictionary];
    }
    
    return targetArray;
}


@end
