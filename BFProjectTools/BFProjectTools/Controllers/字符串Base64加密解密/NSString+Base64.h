//
//  NSString+Base64.h
//  GymboreeCOS
//
//  Created by mac on 14-5-21.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSData *)dataFromBase64String:(NSString *)aString;

+ (NSString *)base64EncodedStringFromData:(NSData *)data;

@end
