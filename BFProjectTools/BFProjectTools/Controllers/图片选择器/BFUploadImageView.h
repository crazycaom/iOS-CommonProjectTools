//
//  BFUploadImageView.h
//  BFProjectTools
//
//  Created by Janmy on 16/10/31.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IDMPhoto.h>
#import <IDMPhotoBrowser.h>

@class BFImagePickerViewController;

@interface BFUploadImageView : UIView
{
    UIButton *addImageBTN;
    CGFloat _screenWidth;
    CGFloat _screenHeight;
    //图片查看器
    IDMPhotoBrowser *browser;
    NSMutableArray *photosArr;
}

/**
 初始化绘制图片栏

 @param imageViews 已存在图片数组
 */
- (void)uploadImageBrowserWith:(NSArray*)imageViews;

/// 父视图控制器
@property (nonatomic,strong) BFImagePickerViewController *superVC;

/// 保存照片imageView数组
@property (nonatomic,strong) NSMutableArray *imageViewArray;

/// 在父视图中的起始Y轴位置
@property (nonatomic,assign) CGFloat originY;




@end
