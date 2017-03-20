//
//  BFPieChartView.m
//  LineView
//
//  Created by CaoMeng on 16/9/14.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "BFPieChartView.h"

@interface BFPieChartView ()

@property (nonatomic,strong)BFPieRotatedView *rotatedView;

@property (nonatomic,strong) UIButton *centerView;

@property (nonatomic,strong) UILabel *amountLabel;

@property (nonatomic, strong) UILabel *title;

@end

@implementation BFPieChartView

- (void)dealloc
{
    self.rotatedView.delegate = nil;
    self.rotatedView = nil;
    self.centerView = nil;
    self.amountLabel = nil;
}

- (id)initWithFrame:(CGRect)frame withValue:(NSMutableArray *)valueArr withColor:(NSMutableArray *)colorArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 数据处理
        [self sortValueArr:valueArr colorArr:colorArr];
        
        self.rotatedView = [[BFPieRotatedView alloc]initWithFrame:self.bounds];
        self.rotatedView.mValueArray = valueArr;
        self.rotatedView.mColorArray = colorArr;
        self.rotatedView.delegate = self;
        [self addSubview:self.rotatedView];
        
        // center切换按钮
        self.centerView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.centerView removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [self.centerView addTarget:self action:@selector(changeInOut:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *centerImage = [UIImage imageNamed:@"center.png"];
        [self.centerView setBackgroundImage:centerImage forState:UIControlStateNormal];
        [self.centerView setBackgroundImage:centerImage forState:UIControlStateHighlighted];
        self.centerView.frame = CGRectMake((frame.size.width - centerImage.size.width/2)/2, (frame.size.height - centerImage.size.height/2)/2, centerImage.size.width/2, centerImage.size.height/2);
        int titleWidth = 65;
        
        // centerButton 切换标题
        self.title = [[UILabel alloc]initWithFrame:CGRectMake((centerImage.size.width/2 - titleWidth)/2,35 , titleWidth, 17)];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:16];
        self.title.textColor = [self colorFromHexRGB:@"cecece"];
        self.title.text = @"";
        // add Title
        [self.centerView addSubview:self.title];
        
        // center AmountLabel
        int amountWidth = 75;
        self.amountLabel = [[UILabel alloc]initWithFrame:CGRectMake((centerImage.size.width/2 - amountWidth)/2, 53, amountWidth, 22)];
        self.amountLabel.backgroundColor = [UIColor clearColor];
        self.amountLabel.textAlignment = NSTextAlignmentCenter;
        self.amountLabel.font = [UIFont boldSystemFontOfSize:21];
        self.amountLabel.textColor = [self colorFromHexRGB:@"ffffff"];
        [self.amountLabel setAdjustsFontSizeToFitWidth:YES];
        // add AmmountLabel
        [self.centerView addSubview:self.amountLabel];
        
        // centerView
        //[self addSubview:self.centerView];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 数组排序

- (void)sortValueArr:(NSMutableArray *)valueArr colorArr:(NSMutableArray *)colorArr
{
    float sum = 0.0;
    int maxIndex = 0;
    int maxValue = 0;
    for (int i = 0; i < [valueArr count]; i++) {
        float curValue = [[valueArr objectAtIndex:i] floatValue];
        if (curValue > maxValue) {
            maxValue = curValue;
            maxIndex = i;
        }
        sum += curValue;
    }
    
    // 360°分为多少份
    float frac = 2.0 * M_PI / sum;
    
    int changeIndex = 0;
    sum = 0.0;
    for (int i = 0; i < [valueArr count]; i++) {
        float curValue = [[valueArr objectAtIndex:i] floatValue];
        sum += curValue;
        if(sum*frac > M_PI/2){
            changeIndex = i;
            break;
        }
    }
    
    if (maxIndex != changeIndex) {
        [valueArr exchangeObjectAtIndex:maxIndex withObjectAtIndex:changeIndex];
        [colorArr exchangeObjectAtIndex:maxIndex withObjectAtIndex:changeIndex];
    }
    
}

#pragma mark - RGB颜色转换(#9e9e9e --> UIColor)

- (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

#pragma mark - reloadDate

- (void)reloadChart
{
    [self.rotatedView reloadPie];
}

#pragma mark - RotatedViewDelegate

- (void)selectedFinish:(BFPieRotatedView *)rotatedView index:(NSInteger)index percent:(float)per
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedFinish:index:percent:)]) {
        [self.delegate selectedFinish:self index:index percent:per];
    }
}

- (void)changeInOut:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(onCenterClick:)]) {
        [self.delegate onCenterClick:self];
    }
}

#pragma mark - set

- (void)setTitleText:(NSString *)text
{
    [self.title setText:text];
}

- (void)setAmountText:(NSString *)text
{
    [self.amountLabel setText:text];
}


@end
