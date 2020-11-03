//
//  RJMainViewController2.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/11/3.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJMainViewController2.h"
#import "RJChartLandscapeManager.h"
#import "RJChartRotationHelper.h"
#import <Masonry/Masonry.h>
#import "RJLineChartView.h"

@interface RJMainViewController2 ()

/// <#Desription#>
@property (nonatomic, weak) UIView *containerView;
/// <#Desription#>
@property (nonatomic, weak) UIView *contentView;
/// <#Desription#>
@property (nonatomic, weak) UITextField *textF;
///
@property (nonatomic, weak) RJLineChartView *chartView;

@end

@implementation RJMainViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view).mas_offset(CGPointMake(0, -150.0));
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(200.0);
    }];
    self.containerView = containerView;
    containerView.backgroundColor = [UIColor whiteColor];
    
    [self setupLineChartView];
    
    RJChartLandscapeManager *manager = [RJChartLandscapeManager shareInstance];
    manager.contentView = self.contentView;
    manager.orientationWillChange = ^(BOOL isFullScreen) {
        RJAllowOrentitaionRotation = isFullScreen;
    };
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:openBtn];
    [openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(containerView.mas_bottom).mas_offset(15.0);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(80.0, 40.0));
    }];
    openBtn.backgroundColor = [UIColor orangeColor];
    [openBtn setTitle:@"旋转" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(openBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupLineChartView {
    RJLineChartView *chartView = [[RJLineChartView alloc] init];
    [self.containerView addSubview:chartView];
    chartView.frame = self.containerView.bounds;
    chartView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.chartView = chartView;
    self.contentView = chartView;
}

- (void)openBtnClick {
    RJChartLandscapeManager *manager = [RJChartLandscapeManager shareInstance];
    [manager enterFullScreen:YES animated:YES completed:nil];
}

#pragma mark - StatusBar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

@end
