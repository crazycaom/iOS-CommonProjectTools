//
//  BFUploadImageView.m
//  BFProjectTools
//
//  Created by Janmy on 16/10/31.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFUploadImageView.h"
#import "QBImagePickerController.h"
#import "IDMPhotoBrowser.h"
#import "BFImagePickerViewController.h"



@interface BFUploadImageView ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,QBImagePickerControllerDelegate,IDMPhotoBrowserDelegate>

@end

@implementation BFUploadImageView

#pragma mark - 上传照片相关
- (void)uploadImageBrowserWith:(NSArray *)imageViews{
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    _imageViewArray = [imageViews mutableCopy];
    [self setBackgroundColor:[UIColor whiteColor]];
    photosArr = [NSMutableArray array];

    //每点击一次加号上传一次照片即调用一次这个方法重新调整设置照片view
    //    uploadImageView = [[UIView alloc]init];
    
    addImageBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImageBTN setBackgroundImage:[UIImage imageNamed:@"addImage@3x.png"] forState:UIControlStateNormal];
    [addImageBTN addTarget:self action:@selector(clickAddImageButton:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableArray *buttonArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    
    //保证添加照片按钮最前。
    [buttonArray addObject:addImageBTN];
    
    for(int i = 0;i<_imageViewArray.count;i++){
        UIButton *button = [[UIButton alloc]init];
        UIImageView *imageView = [[UIImageView alloc]init];
        [button setTag:i];
        [imageView setTag:i];
        if([_imageViewArray[i] isKindOfClass:[UIImageView class]]){
            [button addTarget:self action:@selector(clickImageButton:) forControlEvents:UIControlEventTouchUpInside];
            imageView = _imageViewArray[i];
        }
        
        //        [realImageArray addObject:imageView];
        [buttonArray addObject:button];
    }
    
    
    CGFloat buttonWidth = (SCREEN_WIDTH-30-15)/4;
    
    //根据上传图片数量动态调整mainScrollView的contentSize高度
    //把所有上传图片都缩略显示出来
    if (buttonArray.count>=1) {
        if (buttonArray.count<=4) {
            for (int i = 0; i<buttonArray.count; i++) {
                UIButton *button = buttonArray[i];
                
                [button setFrame:CGRectMake(20+(buttonWidth+5)*i, 0, buttonWidth, buttonWidth)];
                //可编辑状态下会比图片数组多一个添加button。因此取照片时每个button对应的是i-1的照片
                if (i!=0) {
                    UIImageView *imageView = _imageViewArray[i-1];
                    [imageView setFrame:button.frame];
                    [self addSubview:imageView];
                }
                [self addSubview:button];
            }
            
            [self setFrame:CGRectMake(0, _originY+10, _screenWidth, buttonWidth+10)];
            //            [mainScrollView addSubview:uploadImageView];
            //            mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 15+(30+10)*3+30+10+20+(20+20)*4+20+90+10+20+20+10+uploadImageView.height);
        }else{
            for (int i = 0 ; i<=buttonArray.count/4; i++) {
                //i代表行数
                //若i已是最后一行，则最后一行的显示列数为count对4求余
                int lineCount = i==buttonArray.count/4?buttonArray.count%4:4;
                for (int j = 0; j < lineCount; j++) {
                    //每行之间留白5px
                    UIButton *button = buttonArray[j+i*4];
                    
                    
                    [button setFrame:CGRectMake(20+(buttonWidth+5)*j, (5+buttonWidth)*i, buttonWidth, buttonWidth)];
                    
                    //可编辑状态下会比图片数组多一个添加button。
                    if (j+i*4!=0) {
                        UIImageView *imageView = _imageViewArray[j+i*4-1];
                        [imageView setFrame:button.frame];
                        [self addSubview:imageView];
                    }
                    
                    
                    [self addSubview:button];
                    
                }
                
            }
        }
    }
    
    
    //需要显示的行数。
    NSInteger rowCount = buttonArray.count%4==0?buttonArray.count/4:buttonArray.count/4+1;
    [self setFrame:CGRectMake(0, _originY+10, _screenWidth, (5+buttonWidth)*rowCount)];
    //    [mainScrollView addSubview:uploadImageView];
    //    mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 15+(30+10)*3+30+10+20+(20+20)*4+20+90+10+20+20+10+uploadImageView.height);
    [_superVC resetScrollViewFrame];
    
}



#pragma mark - 附件点击事件
- (void)clickAddImageButton:(UIButton*)sender{
        UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择附件来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
        [action showInView:self];
}
- (void)clickImageButton:(UIButton*)sender{
    //图片查看器查看图片
    
    for (int i = 0; i<_imageViewArray.count; i++) {
        //将所有照片附件放进去查看
        if ([_imageViewArray[i] isKindOfClass:[UIImageView class]]) {
            UIImageView *tempImageView = _imageViewArray[i];
            IDMPhoto *photo = [IDMPhoto photoWithImage:tempImageView.image];
            [photosArr addObject:photo];
        }
    }
    browser = [[IDMPhotoBrowser alloc]initWithPhotos:photosArr animatedFromView:sender];
    browser.delegate = self;
    //查看投诉时无法删除照片。不显示垃圾桶。
//    if ((statusFlag == 2 || !_superVC.userInfo.complainEditFlag.boolValue) && statusFlag != 1) {
//        browser.displayActionButton = NO;
//    }else{
//        browser.displayActionButton = YES;
//    }
    
    
    browser.leftArrowImage = [UIImage imageNamed:@"IDMPhotoBrowser_arrowLeft@2x.png"];
    browser.rightArrowImage = [UIImage imageNamed:@"IDMPhotoBrowser_arrowRight@2x.png"];
    browser.displayArrowButton = YES;
    
    
    browser.displayCounterLabel = YES;
    browser.usePopAnimation = YES;
    
    //若存在非图片文件。totalArray是先加入非图片文件的，因此查看图片时将点击下标减去文件数量即对应的照片数组中的下标。
    NSInteger index = sender.tag;
//    if (self.fileArray.count!=0) {
//        index -= self.fileArray.count;
//    }
    [browser setInitialPageIndex:index];
    
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [_superVC presentViewController:browser animated:YES completion:nil];
}

#pragma mark - actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //权限判断
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请到'设置-隐私-相机'中打开本应用访问相机的权限再进行操作!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.allowsEditing = YES;
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [_superVC presentViewController:picker animated:YES completion:nil];
        }
        
        
    }else if(buttonIndex == 1){
        //判断权限
        if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusDenied) {
            
            QBImagePickerController *imagePickerController = [QBImagePickerController new];
            imagePickerController.delegate = self;
            imagePickerController.allowsMultipleSelection = YES;
            imagePickerController.maximumNumberOfSelection = 10;
            imagePickerController.showsNumberOfSelectedAssets = YES;
            
            [_superVC presentViewController:imagePickerController animated:YES completion:NULL];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请到'设置-隐私-照片'中打开本应用访问相册的权限再进行操作!" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

#pragma mark - imagePickerDelegate（相册）
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    if (assets.count > 80 -_imageViewArray.count) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"最多只能上传20张照片" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSInteger originalCount = _imageViewArray.count;

        for (int i = 0; i < assets.count; i++) {
            
            PHAsset *asset = assets[i];
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
                //设置图片
                NSData *data = UIImageJPEGRepresentation(result, 0.1);
                
                UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:data]];
                [_imageViewArray addObject:imageView];
                //本批所有图片已上传完毕则进行更新操作。
                if (_imageViewArray.count-originalCount == assets.count) {
                    [self uploadImageBrowserWith:_imageViewArray];
                }
            }];
            
        }
    }
    
    
    [_superVC dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [_superVC dismissViewControllerAnimated:YES completion:NULL];
}




#pragma mark - imagePickerDelegate(拍照)



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (_imageViewArray.count<20) {
        UIImage *newImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        if (newImage) {
            NSData *data = UIImageJPEGRepresentation(newImage, 0.1);
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:data]];
            [_imageViewArray addObject:imageView];
        }
        
        [picker dismissViewControllerAnimated:YES completion:^{
            [self uploadImageBrowserWith:_imageViewArray];
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"最多只能上传20张照片" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - photoBrowserDelegate
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissAtPageIndex:(NSUInteger)index{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    //关闭图片查看器之后同步更新视图。
    [photosArr removeAllObjects];
//    [self uploadImageView];
}
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDeletePhotoAtIndex:(NSUInteger)index{
    //查看器删除照片
    [_imageViewArray removeObjectAtIndex:index];
    //若删除的是编辑状态下的旧照片，则同步删除该照片对应的id
    if (index<_imageViewArray.count) {
        [_imageViewArray removeObjectAtIndex:index];
    }
}


@end
