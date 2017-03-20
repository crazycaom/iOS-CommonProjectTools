//
//  FileHelper.h
//  iMessageExpression
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

+ (void)createFolderIfNotExist:(NSString *)folderName;

+ (NSString *)folderPath:(NSString *)folderName;

+ (NSString *)filePath:(NSString *)fileName inFloder:(NSString *)folder;

//保存图片到文件夹 , 如果重名 , 传入的imageName会自动生成新的名字
+ (BOOL)saveImageInFolder:(NSString *)folder image:(UIImage *)image imageName:(NSString **)imageName;

+ (NSArray<NSString *> *)pathArrayInFolder:(NSString *)folder;

+ (UIImage *)imageAtPath:(NSString *)path;

@end
