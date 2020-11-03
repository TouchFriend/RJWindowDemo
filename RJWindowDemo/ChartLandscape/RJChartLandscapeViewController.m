//
//  RJChartLandscapeViewController.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/10/29.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJChartLandscapeViewController.h"
#import <Masonry/Masonry.h>
#import "RJChartLandscapeManager.h"

@interface RJChartLandscapeViewController ()

@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;
/// <#Desription#>
@property (nonatomic, weak) UIView *chartContainerView;
/// <#Desription#>
@property (nonatomic, weak) UIButton *closeBtn;

@end

@implementation RJChartLandscapeViewController

#pragma mark - Init Methods

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentOrientation = UIInterfaceOrientationPortrait;
    }
    return self;
}

#pragma mark - Life Cycle

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
    
    UIView *chartContainerView = [[UIView alloc] init];
    [self.view addSubview:chartContainerView];
//    [chartContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (@available(iOS 11.0, *)) {
//            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(50.0);
//            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-50.0);
//            make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
//            make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
//        } else {
//            // Fallback on earlier versions
//            make.top.mas_equalTo(self.mas_topLayoutGuideTop).mas_offset(50.0);
//            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideBottom).mas_offset(-50.0);
//            make.left.right.mas_equalTo(self);
//        }
//    }];
    self.chartContainerView = chartContainerView;
    chartContainerView.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.chartContainerView.center = self.view.center;
    
    if (@available(iOS 11.0, *)) {
        self.chartContainerView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right, CGRectGetHeight(self.view.frame) - 100.0 - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom);
    } else {
        // Fallback on earlier versions
        self.chartContainerView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 100.0);
    }
}

#pragma mark - Target Methods

- (void)closeBtnClick {
    RJChartLandscapeManager *manager = [RJChartLandscapeManager shareInstance];
    [manager enterFullScreen:NO animated:YES completed:nil];
}

#pragma mark - Override Methods

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (!UIDeviceOrientationIsValidInterfaceOrientation([UIDevice currentDevice].orientation)) {
        return;
    }
    
    UIInterfaceOrientation newOrientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    UIInterfaceOrientation oldOrientation = _currentOrientation;
    if (UIInterfaceOrientationIsLandscape(newOrientation)) {
        if (self.contentView.superview != self.chartContainerView) {
            [self.chartContainerView addSubview:self.contentView];
        }
    }
    
    if (oldOrientation == UIInterfaceOrientationPortrait) {
        self.contentView.frame = [self.delegate ls_targetRect];
        [self.contentView layoutIfNeeded];
    }
    self.currentOrientation = newOrientation;
    
    [self.delegate ls_willRotateToOrientation:self.currentOrientation];
    BOOL isFullscreen = size.width > size.height;
    self.closeBtn.hidden = !isFullscreen;
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        if (isFullscreen) {
            self.contentView.frame = self.chartContainerView.bounds;
        } else {
            self.contentView.frame = [self getTargetRect];
        }
        [self.contentView layoutIfNeeded];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        [CATransaction commit];
        [self.delegate ls_didRotateToOrientation:self.currentOrientation];
        if (!isFullscreen) {
            self.contentView.frame = self.containerView.bounds;
            [self.contentView layoutIfNeeded];
        }
    }];
}

- (CGRect)getTargetRect {
    CGRect rect = [self.containerView convertRect:self.originRect toView:self.chartContainerView];
    return rect;
}

#pragma mark - Private Methods

- (BOOL)isFullscreen {
    return UIInterfaceOrientationIsLandscape(_currentOrientation);
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
