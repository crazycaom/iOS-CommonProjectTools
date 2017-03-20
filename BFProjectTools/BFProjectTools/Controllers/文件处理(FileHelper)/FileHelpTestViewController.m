//
//  FileHelpTestViewController.m
//  BFProjectTools
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "FileHelpTestViewController.h"
#import "FileHelper.h"

typedef void (^clickAction)(NSString *);
@interface UnitView : UIView
{
    UILabel *_titleLabel;
    UITextField *_tf;
    UIButton *_confirmButton;
}

@property (nonatomic, copy) NSString *labelText;

@property (nonatomic, copy) clickAction clickAction;

@end

@implementation UnitView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    CGFloat margin = 10;
    CGFloat totalWidth = self.width - 5 * margin;
    //
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, totalWidth / 4.0, self.height)];
    _titleLabel.textColor = [UIColor orangeColor];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    //
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(_titleLabel.maxX + margin, 0, totalWidth / 2.0, self.height)];
    _tf.layer.borderColor = [UIColor orangeColor].CGColor;
    _tf.layer.borderWidth = 1;
    _tf.placeholder = @"请输入文字...";
    [self addSubview:_tf];
    
    //
    _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(_tf.maxX + margin, 0, totalWidth / 4.0, self.height)];
    _confirmButton.layer.borderWidth = 1;
    _confirmButton.layer.borderColor = [UIColor orangeColor].CGColor;
    [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self addSubview:_confirmButton];
}

- (void)confirmAction {
    if (_clickAction) {
        _clickAction(_tf.text);
    }
}

- (void)setLabelText:(NSString *)labelText {
    _labelText = labelText;
    _titleLabel.text = labelText;
}

@end

@interface FileHelpTestViewController ()
{
    NSString *_chooseFolderName;
}

@end

@implementation FileHelpTestViewController

- (void)configUI {
    CGFloat y = 64;
    CGFloat margin = 20;
    CGFloat height = 35;
    
    UnitView *createFolderUnit = [[UnitView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, height)];
    createFolderUnit.labelText = @"创建文件夹";
    createFolderUnit.clickAction = ^(NSString *folderName) {
        [FileHelper createFolderIfNotExist:folderName];
    };
    [self.view addSubview:createFolderUnit];
    
    //保存文件操作
    //
    UILabel *insertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, createFolderUnit.maxY + margin, SCREEN_WIDTH + 2, 60)];
    insertLabel.text = @"创建文件";
    insertLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
    insertLabel.layer.borderWidth = 1;
    insertLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:insertLabel];
    
    UnitView *chooseFolderUnit = [[UnitView alloc] initWithFrame:CGRectMake(0, insertLabel.maxY + margin, SCREEN_WIDTH, height)];
    chooseFolderUnit.labelText = @"选择文件夹名称";
    __block typeof(NSString *) weakChooseFolderName = _chooseFolderName;
    chooseFolderUnit.clickAction = ^(NSString *folderName) {
        weakChooseFolderName = folderName;
    };
    [self.view addSubview:chooseFolderUnit];
    
    UnitView *chooseFileUnit = [[UnitView alloc] initWithFrame:CGRectMake(0, chooseFolderUnit.maxY + margin, SCREEN_WIDTH, height)];
    chooseFileUnit.labelText = @"输入要保存的文件名";
    chooseFileUnit.clickAction = ^(NSString *fileName) {
        if([FileHelper saveImageInFolder:weakChooseFolderName image:[UIImage imageNamed:@"1.jpg"] imageName:&fileName]) {
            NSLog(@"图片保存成功!");
        } else {
            NSLog(@"图片保存失败!");
        }
    };
    [self.view addSubview:chooseFileUnit];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
    NSLog(@"根目录下的文件夹有: ----- %@",[FileHelper pathArrayInFolder:@""]);


}


@end
