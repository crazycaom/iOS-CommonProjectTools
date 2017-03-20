//
//  BFTestPopViewController.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/18.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFRootViewController.h"

@class BFTestPopViewController;

@protocol DismissPopControllerDelegate <NSObject>

@optional
- (void)closeButtonOnClick:(BFTestPopViewController *)popVC;

@end

@interface BFTestPopViewController : BFRootViewController

@property(nonatomic,weak) id<DismissPopControllerDelegate>delegate;

@end

