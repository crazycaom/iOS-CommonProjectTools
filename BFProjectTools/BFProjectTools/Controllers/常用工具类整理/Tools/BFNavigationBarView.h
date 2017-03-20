//
//  BFNavigationBarView.h
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFView.h"

@interface BFNavigationBarView : BFView

- (void)createMyNavigationBarWithBgImageName:(NSString *)bgImageName andTitle:(NSString *)title andLeftItemTitles:(NSArray *)leftItemTitles andLeftItemBgImageNames:(NSArray *)leftItemBgImageNames andRightItemTitles:(NSArray *)rightItemTitles andRightItemBgImageNames:(NSArray *)rightItemBgImageNames andClass:(id)classObject andSEL:(SEL)sel andIsFullStateBar:(BOOL)isFillStateBar;

@end
