//
//  RJMainViewController.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/10/28.
//

#import "RJMainViewController.h"
#import "RJChartLandscapeManager.h"
#import "RJChartRotationHelper.h"
#import <Masonry/Masonry.h>
#import "RJLineChartView.h"

@interface RJMainViewController ()

/// <#Desription#>
@property (nonatomic, weak) UIView *containerView;
/// <#Desription#>
@property (nonatomic, weak) UIView *contentView;
/// <#Desription#>
@property (nonatomic, weak) UITextField *textF;
///
@property (nonatomic, weak) RJLineChartView *chartView;

@end

@implementation RJMainViewController

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
    
    // 1.contentView不能使用自动布局；
    // 2.contentView不能在viewWillLayoutSubviews方法里设置frame。 因为更换窗口后会再次调用此方法，造成contentView的frame一直固定
    // 3.contentView的大小跟containerView一致。
    // 4.全屏后的view的size要比竖屏的大，动画才会一致
//    UIView *contentView = [[UIView alloc] init];
//    [containerView addSubview:contentView];
//    contentView.frame = containerView.bounds;
//    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.contentView = contentView;
//    contentView.backgroundColor = [UIColor orangeColor];
//
//    UITextField *textF = [[UITextField alloc] init];
//    [contentView addSubview:textF];
//    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(contentView);
//        make.size.mas_equalTo(CGSizeMake(100.0, 30.0));
//    }];
//    self.textF = textF;
//    textF.backgroundColor = [UIColor whiteColor];
//    textF.text = @"测试一下";
    
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
