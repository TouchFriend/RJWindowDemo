//
//  RJChartLandscapeViewController2.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/11/3.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJChartLandscapeViewController2.h"
#import <Masonry/Masonry.h>
#import "RJLineChartView.h"
#import "RJChartLandscapeManager2.h"

@interface RJChartLandscapeViewController2 ()

/// <#Desription#>
@property (nonatomic, weak) UIButton *closeBtn;

@end

@implementation RJChartLandscapeViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(5.0);
            make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        } else {
            // Fallback on earlier versions
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.left.mas_equalTo(self.view.mas_left);
        }
        make.size.mas_equalTo(CGSizeMake(80.0, 40.0));
    }];
    self.closeBtn = closeBtn;
    closeBtn.backgroundColor = [UIColor orangeColor];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupLineChartView];
}

- (void)setupLineChartView {
    RJLineChartView *chartView = [[RJLineChartView alloc] init];
    [self.view addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.closeBtn.mas_bottom).mas_offset(10.0);
        if (@available(iOS 11.0, *)) {
            make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-20.0);
        } else {
            // Fallback on earlier versions
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).mas_offset(-20.0);
        }
    }];
}

#pragma mark - Target Methods

- (void)closeBtnClick {
    RJChartLandscapeManager2 *manager = [RJChartLandscapeManager2 shareInstance];
    [manager enterFullScreen:NO];
}

#pragma mark - Override Methods

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (!UIDeviceOrientationIsValidInterfaceOrientation([UIDevice currentDevice].orientation)) {
        return;
    }
    
    UIInterfaceOrientation newOrientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    
    [self.delegate ls_willRotateToOrientation:newOrientation];
    BOOL isFullscreen = size.width > size.height;
    if (!isFullscreen) {
        [self.delegate ls_didRotateToOrientation:newOrientation];
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {

    } completion:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        [CATransaction commit];
    }];
}

#pragma mark - Autorotation

- (BOOL)shouldAutorotate {
    return [self.delegate ls_shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UIInterfaceOrientation currentOrientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    if (UIInterfaceOrientationIsLandscape(currentOrientation)) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


@end
