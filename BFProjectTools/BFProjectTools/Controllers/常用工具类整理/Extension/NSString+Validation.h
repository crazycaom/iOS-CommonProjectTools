//
//  NSString+Validation.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//  NSString 扩展Action

#import <Foundation/Foundation.h>

@interface NSString (Validation)

/**
 判断字符串是否为空

 @param string 要判断的字符串

 @return YES: 空字符串. NO: 非空字符串.
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 判读是否是邮箱格式

 @param string 参数

 @return YES：是邮箱格式，NO：不是邮箱格式
 */
+ (BOOL)isEmailType:(NSString *)string;

/**
 判断字符串是否为空或者是nil

 @param string 参数

 @return YES：参数为空，NO：参数不为空
 */
+ (BOOL)isNil:(NSString *)string;

/**
 判断参数是否是数字类型

 @param string 参数

 @return YES：参数是数字，NO：参数不是数字
 */
+ (BOOL)isNumberType:(NSString *)string;

/**
 字符串去空处理

 @param aString 要去空的字符串

 @return 去空后的字符串
 */
+(NSString *)removeNull:(NSString *)aString;

/**
 判断是否是字符串

 @return YES: 字符串类型. NO: 非字符串类型.
 */
- (BOOL)isStringType;

/**
 判断是否是数组类型

 @return YES: 数组类型. NO: 非数组类型.
 */
- (BOOL)isArrayType;

/**
 判断是否是字典类型

 @return YES: 字典类型. NO: 非字典类型.
 */
- (BOOL)isDictionaryType;

/**
 动态获取字符串的CGSize

 @param font          font
 @param size          限制的CGSize
 @param lineBreakMode 换行模式

 @return 计算后的CGSize
 */
- (CGSize)newCustomSizeWithFont:(UIFont *)font
              constrainedToSize:(CGSize)size
                  lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 数字字符串去小数点

 @return 处理后的字符串
 */
- (NSString *)formatNumberRemovePoint;


@end
