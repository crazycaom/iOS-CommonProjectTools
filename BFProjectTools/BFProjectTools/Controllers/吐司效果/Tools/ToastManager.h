//
//  ToastManager.h
//  BFProjectTools
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToastManager : NSObject

+ (instancetype)shareManager;

- (void)toastAView:(UIView *)view;

@end
