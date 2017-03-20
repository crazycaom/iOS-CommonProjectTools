//

//  BFSlideViewController.h

//  BFProjectTools

//

//  Created by Janmy on 16/10/20.

//  Copyright © 2016年 CM. All rights reserved.

//



#import "BFRootViewController.h"





@interface BFSlideViewController : BFRootViewController

{
    
    
    
    UIViewController *_leftVC;
    
    
    
    UIViewController *_mainVC;
    
    
    
    UIViewController *_rightVC;
    
    
    
    UIViewController *_currentVC;
    
    
    
    CGFloat _screenWidth;
    
    CGFloat _screenHeight;
    
    
    
    UISwipeGestureRecognizer *_swipe;
    
    UIPanGestureRecognizer *_pan;
    
    UITapGestureRecognizer *_tap;
    
}



/**
 
 侧滑栏视图控制器初始方法(防QQ)
 
 
 
 @param leftVC  左视图控制器
 
 @param mainVC  主视图控制器
 
 @param rightVC 右视图控制器
 
 
 
 @return 侧滑栏视图控制器
 
 */

- (instancetype)initWithLeftVC:(UIViewController*)leftVC

                        MainVC:(UIViewController*)mainVC

                       rightVC:(UIViewController*)rightVC;



/**
 
 左右侧滑栏的缩进比例
 
 */

@property (nonatomic,assign) CGFloat slideViewScale;



@end

