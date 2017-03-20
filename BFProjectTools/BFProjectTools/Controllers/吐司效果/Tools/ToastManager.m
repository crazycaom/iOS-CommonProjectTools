//
//  ToastManager.m
//  BFProjectTools
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "ToastManager.h"

@interface ToastManager ()
{
    
}

@property (nonatomic , strong) NSMutableArray *visibleViews;

@end

@implementation ToastManager

#pragma mark ------ 创建单例对象
+(instancetype)shareManager {
    static ToastManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initPrivate];
    });
    return manager;
}

- (instancetype)init {
    return nil;
}

- (instancetype)initPrivate {
    if (self = [super init]) {
        self.visibleViews = [NSMutableArray array];
    }
    return self;
}

#pragma mark ---------- 显示toast
- (void)toastAView:(UIView *)view {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    view.center = window.center;
    [window addSubview:view];
    [_visibleViews addObject:view];
    
    __block typeof(UIView *) weakView = view;
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i<_visibleViews.count - 1; i++) {
            UIView *aView = _visibleViews[i];
                aView.y -= weakView.height + 5;
        }
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 animations:^{
            weakView.alpha = 0;
            weakView.center = CGPointMake(weakView.center.x, weakView.center.y - weakView.height);
        } completion:^(BOOL finished) {
            [_visibleViews removeObject:weakView];
            [weakView removeFromSuperview];
            weakView = nil;
        }];
    });
    
}

@end
