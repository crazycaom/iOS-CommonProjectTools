//
//  NSString+Base64Encrypt.h
//  BFProjectTools
//
//  Created by mac on 16/10/21.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>
#import "GTMBase64.h"


@interface NSString (Base64Encrypt)

-(NSString*)encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

@end
