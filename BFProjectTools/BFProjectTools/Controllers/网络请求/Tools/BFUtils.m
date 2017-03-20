//
//  BFUtils.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFUtils.h"

@implementation BFUtils

+ (instancetype)shareUtils
{
    static dispatch_once_t once;
    static id shareUtils;
    dispatch_once(&once,^{
        shareUtils = [[self alloc]init];
    });
    
    return shareUtils;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        // initArray
    }
    
    return self;
}

+ (void) hudShow
{
    [ProgressHUD show:@"Loading..."];
}

+ (void) hudShowWithMessage:(NSString *) msg
{
    [ProgressHUD show:msg];
}

+ (void) hudSuccessHidden
{
    [ProgressHUD dismiss];
}

+ (void) hudSuccessHidden : (NSString*) msg
{
    [ProgressHUD showSuccess:msg];
}

+ (void) hudFailHidden
{
    [ProgressHUD dismiss];
}

+ (void) hudFailHidden : (NSString*) msg
{
    [ProgressHUD showError:msg];
}

@end
