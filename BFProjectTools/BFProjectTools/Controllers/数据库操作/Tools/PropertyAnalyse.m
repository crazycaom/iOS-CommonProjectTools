//
//  PropertyAnalyse.m
//  ObjectDatabase
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

#import "PropertyAnalyse.h"
#import <objc/runtime.h>

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


@implementation PropertyAnalyse

//获取属性类型 和 属性名
+ (NSDictionary *)getAllPropertiesFromClass:(Class)targetClass {
    u_int count;
    objc_property_t *properties = class_copyPropertyList(targetClass, &count);
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionaryWithCapacity:2];
    NSMutableArray *classArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        //获取属性名
        const char *propertyName = property_getName(properties[i]);
        //获取属性类型
        NSString *propertyClass = getPropertyType(properties[i]);
        
        [classArray addObject:propertyClass];
        [propertyArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    [paraDict setObject:classArray forKey:kPropertyDictionary_PropertyClassKey];
    [paraDict setObject:propertyArray forKey:kPropertyDictionary_PropertyNameKey];
    free(properties);
    return paraDict;
}

//获取有值的属性名 和 对应的属性类型 和 属性值 (如果某个属性没有赋值 , 则返回的字典中不会有这个属性的信息)
+ (NSDictionary *)getPropertiesInObj:(id)obj {
    NSDictionary *dictionary = [self getAllPropertiesFromClass:[obj class]];
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    NSMutableArray *classArr = [NSMutableArray arrayWithArray:dictionary[kPropertyDictionary_PropertyClassKey]];
    NSMutableArray *nameArr = [NSMutableArray arrayWithArray:dictionary[kPropertyDictionary_PropertyNameKey]];
    NSMutableArray *valueArr = [NSMutableArray array];
    for (int i = 0; i<nameArr.count; i++) {
        id value = [obj valueForKey:nameArr[i]];
        if (!value) {
            [nameArr removeObjectAtIndex:i];
            [classArr removeObjectAtIndex:i];
            i --;
            continue;
        }
        [valueArr addObject:value];
    }
    [paramDict setObject:valueArr forKey:kPropertyDictionary_PropertyValueKey];
    [paramDict setObject:classArr forKey:kPropertyDictionary_PropertyClassKey];
    [paramDict setObject:nameArr forKey:kPropertyDictionary_PropertyNameKey];
    return paramDict;
}

+ (NSString *)removeNull:(id)obj
{
    if ([obj isKindOfClass:[NSNull class]]||[obj isEqual:@"(null)"] || [obj isEqual:@"\"null\""]){
        
        return @"";
    }
    
    if (obj == nil) {
        return @"";
    }
    
    if ([obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",obj];
    }
    
    return obj;
}

@end
