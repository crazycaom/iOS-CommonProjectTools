//

//  BFSlideViewController.m

//  BFProjectTools

//

//  Created by Janmy on 16/10/20.

//  Copyright © 2016年 CM. All rights reserved.

//



#import "BFSlideViewController.h"



@interface BFSlideViewController ()



@end



@implementation BFSlideViewController



#pragma mark - init 初始化



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        
        
    }
    
    return self;
    
}



- (instancetype)initWithLeftVC:(UIViewController*)leftVC

                        MainVC:(UIViewController*)mainVC

                       rightVC:(UIViewController*)rightVC{
    
    if (self) {
        
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        
        
        _leftVC = leftVC;
        
        _mainVC = mainVC;
        
        _rightVC = rightVC;
        
        
        
        //左右视图缩进比例
        
        self.slideViewScale = 0.75;
        
        
        
        [_leftVC.view setCenterX:-_screenWidth/2];
        
        [_rightVC.view setCenterX:_screenWidth*1.5];
        
        
        
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        
        
        
        
        
        [self.view addGestureRecognizer:_pan];
        
        [self.view addGestureRecognizer:_tap];
        
        
        
        [self.view addSubview:leftVC.view];
        
        [self.view addSubview:mainVC.view];
        
        [self.view addSubview:rightVC.view];
        
        
        
    }
    
    
    
    return self;
    
}



#pragma mark - GestureRecognizer Action 手势响应



- (void)panAction:(UIPanGestureRecognizer*)sender{
    
    
    
    //location
    
    CGPoint point = [sender translationInView:self.view];
    
    NSLog(@"===pointX:%f",point.x);
    
    if (point.x >= 0) {
        
        
        
        //右划
        
        [UIView beginAnimations:nil context:nil];
        
        _mainVC.view.centerX += point.x*0.5;
        
        _leftVC.view.centerX += point.x*0.5;
        
        _rightVC.view.centerX += point.x*0.5;
        
        
        
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];
        
        [UIView commitAnimations];
        
        
        
    }else{
        
        //左划
        
        [UIView beginAnimations:nil context:nil];
        
        _mainVC.view.centerX += point.x*0.5;
        
        _leftVC.view.centerX += point.x*0.5;
        
        _rightVC.view.centerX += point.x*0.5;
        
        
        
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];
        
        [UIView commitAnimations];
        
    }
    
    
    
    
    
    
    
    //显示左右主视图的各种情况。
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        
        
        if (_currentVC == _leftVC) {
            
            
            
            if (_mainVC.view.centerX >= _screenWidth*1.1) {
                
                [self showLeftView];
                
                
                
            }else{
                
                [self showMainView];
                
            }
            
            
            
        }else if(_currentVC == _rightVC){
            
            
            
            if (_mainVC.view.centerX <= -_screenWidth*0.1) {
                
                [self showRightView];
                
                
                
            }else{
                
                
                
                [self showMainView];
                
            }
            
            
            
        }else{
            
            
            
            if (_mainVC.view.centerX >= _screenWidth*0.6) {
                
                [self showLeftView];
                
                
                
            }else if(_mainVC.view.centerX <= _screenWidth * 0.4){
                
                [self showRightView];
                
                
                
            }else{
                
                [self showMainView];
                
            }
            
            
            
            
            
        }
        
        
        
    }
    
    
    
}

- (void)tapAction:(UITapGestureRecognizer*)sender{
    CGPoint location = [sender locationInView:self.view];
    if ((_currentVC == _leftVC && location.x>_screenWidth*0.75) || (_currentVC == _rightVC && location.x<_screenWidth*0.25)) {
        [self showMainView];
    }
    
    
}



#pragma mark - slideResult  侧滑



- (void)showLeftView{
    
    _currentVC = _leftVC;
    
    [UIView beginAnimations:nil context:nil];
    
    [_mainVC.view setCenterX:_screenWidth*1.25];
    
    [_leftVC.view setCenterX:_screenWidth*0.25];
    
    [_rightVC.view setCenterX:_screenWidth*2.25];
    
    [UIView commitAnimations];
    
}



- (void)showMainView{
    
    _currentVC = _mainVC;
    
    [UIView beginAnimations:nil context:nil];
    
    [_mainVC.view setCenterX:_screenWidth*0.5];
    
    [_leftVC.view setCenterX:-_screenWidth*0.5];
    
    [_rightVC.view setCenterX:_screenWidth*1.5];
    
    [UIView commitAnimations];
    
}



- (void)showRightView{
    
    _currentVC = _rightVC;
    
    [UIView beginAnimations:nil context:nil];
    
    [_mainVC.view setCenterX:-_screenWidth*0.25];
    
    [_leftVC.view setCenterX:-_screenWidth*1.25];
    
    [_rightVC.view setCenterX:_screenWidth*0.75];
    
    [UIView commitAnimations];
    
}

































@end

