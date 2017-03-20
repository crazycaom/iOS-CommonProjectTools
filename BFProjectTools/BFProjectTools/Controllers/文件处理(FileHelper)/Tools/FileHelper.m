//
//  FileHelper.m
//  iMessageExpression
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

#import "FileHelper.h"

#if DEBUG
#define FHLog(...) NSLog(__VA_ARGS__)
#else
#define FHLog(...)
#endif

@implementation FileHelper

+ (NSString *)docuPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)folderPath:(NSString *)folderName {
    return [[self docuPath] stringByAppendingPathComponent:folderName];
}

+ (void)createFolderIfNotExist:(NSString *)folderName {
    NSString *lastStr = [[self docuPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",folderName]];
    BOOL isDir = YES;
    if ([[NSFileManager defaultManager] fileExistsAtPath:lastStr isDirectory:&isDir]) {
        FHLog(@"文件夹已存在");
        return;
    }
    if (![[NSFileManager defaultManager] createDirectoryAtPath:lastStr withIntermediateDirectories:YES attributes:nil error:nil]) {
        FHLog(@"创建文件夹失败!");
    }
}

+ (NSString *)filePath:(NSString *)fileName inFloder:(NSString *)folder {
    return [[self folderPath:folder] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",fileName]];
}

+ (BOOL)saveImageInFolder:(NSString *)folder image:(UIImage *)image imageName:(NSString **)imageName{
    NSString *actualName = *imageName;
    if (!image) {
        FHLog(@"image为空!");
        return NO;
    }
    NSString *prefix;
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
        prefix = @".jpg";
    } else {
        data = UIImagePNGRepresentation(image);
        prefix = @".png";
    }
    
    NSInteger count = 1;
    while ([[NSFileManager defaultManager] fileExistsAtPath:[self filePath:actualName inFloder:folder]]) {
        actualName = [NSString stringWithFormat:@"%@(%ld)",actualName,count];
    }
    NSString *filePath = [[self folderPath:folder] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@%@",actualName,prefix]];
    BOOL succeed = [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    if (!succeed) {
        FHLog(@"写入图片失败!");
    }
    return succeed;
}

+ (NSArray<NSString *> *)pathArrayInFolder:(NSString *)folder {
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self folderPath:folder] error:nil];
}

+ (UIImage *)imageAtPath:(NSString *)path {
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
