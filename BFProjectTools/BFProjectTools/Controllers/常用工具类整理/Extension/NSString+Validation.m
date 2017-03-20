//
//  NSString+Validation.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

////// 判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) {
        return YES;
    }
    return NO;
}

/**
 *  判读是否是邮箱格式
 *
 *  @param string 参数
 *
 *  @return YES：是邮箱格式，NO：不是邮箱格式
 */
+ (BOOL)isEmailType:(NSString *)string{
    
    if (![NSString isNil:string]) {
        return YES;
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
    if(numberOfMatches !=1){
        return NO;
    }
    
    return YES;
    
}

/**
 *  判断字符串是否为空或者是nil
 *
 *  @param string 参数
 *
 *  @return YES：参数为空，NO：参数不为空
 */
+ (BOOL)isNil:(NSString *)string{
    
    if ([string isKindOfClass:[NSNumber class]]) {
        string = [NSString stringWithFormat:@"%@",string];
    }
    
    if (string == nil || string.length == 0) {
        return YES;
    }
    
    return NO;
    
}


/**
 *  判断参数是否是数字类型
 *
 *  @param string 参数
 *
 *  @return YES：参数是数字，NO：参数不是数字
 */
+ (BOOL)isNumberType:(NSString *)string{
    
    if (string == nil || string.length == 0) {
        return YES;
    }
    
    NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
    BOOL succeed = YES;
    for (int i = 0; i < string.length; i ++) {
        unichar character = [string characterAtIndex:i];
        if (![numberSet characterIsMember:character]) {
            succeed = NO;
            break;
        }
    }
    
    return succeed;
}

////// removeNull
+(NSString *)removeNull:(NSString *)aString
{
    if ([NSString isNil:aString]) {
        aString = @"";
    }else{
        aString = [aString stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return aString;
}


////// isStringType
- (BOOL)isStringType
{
    if ([self isEqualToString:@"NSString"]) {
        return YES;
    }
    
    return NO;
}

////// isArrayType
- (BOOL)isArrayType
{
    if ([self isEqualToString:@"NSArray"] ||
        [self isEqualToString:@"NSMutableArray"]) {
        return YES;
    }
    
    return NO;
}

////// isDictionaryType
- (BOOL)isDictionaryType
{
    if ([self isEqualToString:@"NSDictionary"] ||
        [self isEqualToString:@"NSMutableDictionary"]) {
        return YES;
    }
    
    return NO;
    
}

////// 动态获取字符串的CGSize
- (CGSize)newCustomSizeWithFont:(UIFont *)font
              constrainedToSize:(CGSize)size
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineBreakMode = lineBreakMode;
    
    NSDictionary *dic = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
    
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size;
}

- (NSString *)formatNumberRemovePoint {
    if ([self containsString:@"."]) {
        NSString *pointStr = [[self componentsSeparatedByString:@"."] lastObject];
        if (pointStr.floatValue < 1) {
            return [[self componentsSeparatedByString:@"."] firstObject];
        }
    }
    return self;
}

@end
