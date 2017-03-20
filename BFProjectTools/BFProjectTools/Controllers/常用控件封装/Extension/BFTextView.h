//
//  BFTextView.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//  自定义UITextView

#import <UIKit/UIKit.h>

@interface BFTextView : UITextView

/// placeholder
@property(nonatomic,strong) NSString *placeholder;

///  placeholderFrame
@property(nonatomic,assign) CGRect  placeholderFrame;

@end
