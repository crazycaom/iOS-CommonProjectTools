//
//  Base64TestViewController.m
//  BFProjectTools
//
//  Created by mac on 16/10/21.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "Base64TestViewController.h"
#import "NSString+Base64Encrypt.h"



@interface UIView (Custom)

- (void)customBorder;

@end

@implementation UIView(Custom)

-(void)customBorder {
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.cornerRadius = 5;
}

@end

@interface Base64TestViewController ()
{
    UITextField *_originTf;
    UILabel *_encryptLabel;
    UILabel *_decryptLabel;
}
@end

@implementation Base64TestViewController
CGFloat labelWidth;
CGFloat height;
CGFloat centerMargin;

- (void)viewDidLoad {
    [super viewDidLoad];
    labelWidth = SCREEN_WIDTH * 2 / 3.0;
    height = 40;
    centerMargin = height + 10;

    _originTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, labelWidth , height)];
    _originTf.center = CGPointMake(self.view.center.x, 90);
    _originTf.placeholder = @"请输入要加密的字符串";
    [_originTf customBorder];
    [self.view addSubview:_originTf];
    
    [self addEncrypt];

    [self addDecrypt];
}

- (void)addEncrypt {
    UIButton *encryptBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, height)];
    encryptBtn.center = CGPointMake(_originTf.center.x, _originTf.center.y + centerMargin);
    [encryptBtn setTitle:@"加密" forState:UIControlStateNormal];
    [encryptBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [encryptBtn addTarget:self action:@selector(encrypt) forControlEvents:UIControlEventTouchUpInside];
    [encryptBtn customBorder];
    [self.view addSubview:encryptBtn];
    
    _encryptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, height)];
    _encryptLabel.center = CGPointMake(encryptBtn.center.x, encryptBtn.center.y + centerMargin);
    [_encryptLabel customBorder];
    [self.view addSubview:_encryptLabel];
}

- (void)addDecrypt {
    UIButton *decryptBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, height)];
    decryptBtn.center = CGPointMake(_encryptLabel.center.x, _encryptLabel.center.y + centerMargin);
    [decryptBtn setTitle:@"解密" forState:UIControlStateNormal];
    [decryptBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [decryptBtn addTarget:self action:@selector(decrypt) forControlEvents:UIControlEventTouchUpInside];
    [decryptBtn customBorder];
    [self.view addSubview:decryptBtn];
    
    _decryptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, height)];
    _decryptLabel.center = CGPointMake(decryptBtn.center.x, decryptBtn.center.y + centerMargin);
    [_decryptLabel customBorder];
    [self.view addSubview:_decryptLabel];
}

- (void)encrypt {
    _encryptLabel.text = [_originTf.text encryptOrDecrypt:kCCEncrypt];
}

- (void)decrypt {
    _decryptLabel.text = [_encryptLabel.text encryptOrDecrypt:kCCDecrypt];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
