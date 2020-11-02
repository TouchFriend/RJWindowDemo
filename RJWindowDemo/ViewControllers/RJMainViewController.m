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

@interface RJMainViewController ()

/// <#Desription#>
@property (nonatomic, weak) UIView *contentView;
/// <#Desription#>
@property (nonatomic, weak) UITextField *textF;

@end

@implementation RJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(200.0);
    }];
    containerView.backgroundColor = [UIColor purpleColor];
    
    // 1.contentView不能使用自动布局；
    // 2.contentView不能在viewWillLayoutSubviews方法里设置frame。 因为更换窗口后会再次调用此方法，造成contentView的frame一直固定
    // 3.contentView的大小跟containerView一致。
    UIView *contentView = [[UIView alloc] init];
    [containerView addSubview:contentView];
    contentView.frame = containerView.bounds;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentView = contentView;
    contentView.backgroundColor = [UIColor orangeColor];
    
    UITextField *textF = [[UITextField alloc] init];
    [contentView addSubview:textF];
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(100.0, 30.0));
    }];
    self.textF = textF;
    textF.backgroundColor = [UIColor whiteColor];
    textF.text = @"测试一下";
    
    RJChartLandscapeManager *manager = [RJChartLandscapeManager shareInstance];
    manager.contentView = contentView;
    manager.orientationWillChange = ^(BOOL isFullScreen) {
        RJAllowOrentitaionRotation = isFullScreen;
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    RJChartLandscapeManager *manager = [RJChartLandscapeManager shareInstance];
    [manager enterFullScreen:YES animated:YES completed:nil];
}


@end
