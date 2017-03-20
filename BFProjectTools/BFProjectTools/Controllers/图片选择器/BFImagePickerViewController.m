//
//  BFImagePickerViewController.m
//  BFProjectTools
//
//  Created by Janmy on 16/10/27.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFImagePickerViewController.h"

@interface BFImagePickerViewController ()
{
    UIScrollView *mainScrollView;
    NSMutableArray *imageViewArray;
    BFUploadImageView *uploadImageView;
}

@end

@implementation BFImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //10是imageView与label的留白
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationController.navigationBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height)];
    [mainScrollView setBackgroundColor:[UIColor redColor]];
    
    
    imageViewArray = [NSMutableArray array];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [label setBackgroundColor:[UIColor whiteColor]];
    [label setText:@"图片选择工具"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [mainScrollView addSubview:label];
    
    
    uploadImageView = [[BFUploadImageView alloc]init];
    uploadImageView.superVC = self;
    uploadImageView.originY = CGRectGetMaxY(label.frame);
    [uploadImageView uploadImageBrowserWith:imageViewArray];
    
    [mainScrollView addSubview:uploadImageView];
    [mainScrollView setContentSize:CGSizeMake(SCREEN_WIDTH,50+CGRectGetHeight(uploadImageView.frame))];
    
    [self.view addSubview:mainScrollView];
    
}

- (void)resetScrollViewFrame{
    [mainScrollView setContentSize:CGSizeMake(SCREEN_WIDTH,50+10+CGRectGetHeight(uploadImageView.frame))];
}

@end
