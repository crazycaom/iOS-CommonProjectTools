//
//  BFNavigationBarView.m
//  BFProjectTools
//
//  Created by CaoMeng on 16/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFNavigationBarView.h"

@implementation BFNavigationBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)createMyNavigationBarWithBgImageName:(NSString *)bgImageName andTitle:(NSString *)title andLeftItemTitles:(NSArray *)leftItemTitles andLeftItemBgImageNames:(NSArray *)leftItemBgImageNames andRightItemTitles:(NSArray *)rightItemTitles andRightItemBgImageNames:(NSArray *)rightItemBgImageNames andClass:(id)classObject andSEL:(SEL)sel andIsFullStateBar:(BOOL)isFillStateBar
{
    // 创建背景图
    [self createBgImageViewWithImageName:bgImageName andIsFullStateBar:isFillStateBar];
    
    // 创建标题
    [self createTitleLabelWithTitle:title andIsFullStateBar:isFillStateBar];
    // 创建按钮(调用多次)
    // 需要分别判断左侧和右侧是否有按钮
    
    // 左侧有按钮
    if (leftItemBgImageNames.count>0) {
        
        CGFloat x=10;
        for (int i=0; i<leftItemBgImageNames.count; i++) {
            
            x= [self createItemWithItemTitle:[leftItemTitles objectAtIndex:i] andItemBgImageName:[leftItemBgImageNames objectAtIndex:i] andX:x andIndex:i andIsLeft:YES andClass:classObject andSEL:sel andIsFullStateBar:(BOOL)isFillStateBar];
            
        }
    }
    
    // 右侧按钮
    if (rightItemBgImageNames.count>0) {
        CGFloat x=self.frame.size.width-10;
        for (int i=0; i<rightItemBgImageNames.count; i++) {
            
            x= [self createItemWithItemTitle:[rightItemTitles objectAtIndex:i] andItemBgImageName:[rightItemBgImageNames objectAtIndex:i] andX:x andIndex:i andIsLeft:NO andClass:classObject andSEL:sel andIsFullStateBar:(BOOL)isFillStateBar];
            
        }
        
    }
}
// 创建背景图片
- (void)createBgImageViewWithImageName:(NSString *)bgImageName andIsFullStateBar:(BOOL)isFillStateBar
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgImageName]];
    
    CGRect frame;
    if (isFillStateBar) {
        frame = CGRectMake(0, 10, self.frame.size.width, 64);
    }else{
        frame = CGRectMake(0, 0, self.frame.size.width, 44);
    }
    iv.frame = frame;
    [self addSubview:iv];
}

- (void)createTitleLabelWithTitle:(NSString *)title andIsFullStateBar:(BOOL)isFillStateBar
{
    UILabel *label = [[UILabel alloc] init];
    
    CGRect frame;
    if (isFillStateBar) {
        frame = CGRectMake(0, 10, self.frame.size.width, 64);
    }else{
        frame = CGRectMake(0, 0, self.frame.size.width, 44);
    }
    label.frame = frame;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.textColor = NavigationBarFontColor;
    label.font = [UIFont boldSystemFontOfSize:20];
    [self addSubview:label];
}

- (CGFloat)createItemWithItemTitle:(NSString *)itemTitle andItemBgImageName:(NSString *)itemBgImageName andX:(CGFloat)xFloat andIndex:(int)index andIsLeft:(BOOL)isLeft andClass:(id)classObject andSEL:(SEL)sel andIsFullStateBar:(BOOL)isFillStateBar
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image=[UIImage imageNamed:itemBgImageName];
    CGFloat x=isLeft?xFloat:xFloat-image.size.width;
    
    CGFloat offSetY = 0;
    if (isFillStateBar) {
        offSetY = 10;
    }
    
    btn.frame=CGRectMake(x, (self.frame.size.height-image.size.height)/2+offSetY, image.size.width, image.size.height);
    [btn setTitle:itemTitle forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    btn.tag = isLeft ? index+1 : 1000+index; // 1 2   1000 10001
    
    [btn addTarget:classObject action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    [self addSubview:btn];
    
    return isLeft?x+image.size.width+10:x-10;
}

@end
