//
//  RJChartLandscapeManager.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/10/29.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJChartLandscapeManager.h"

@interface RJChartLandscapeManager () <RJChartLandscapeViewControllerDelegate>

/// 横屏窗口
@property (nonatomic, strong) RJChartLandscapeWindow *window;
/// 前一个根窗口
@property (nonatomic, strong) UIWindow *previousKeyWindow;

@end

@implementation RJChartLandscapeManager

#pragma mark - init Methods

+ (instancetype)shareInstance {
    static RJChartLandscapeManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[RJChartLandscapeManager alloc] init];
        [_manager setupInit];
    });
    return _manager;
}

#pragma mark - Setup Init

- (void)setupInit {
}

- (void)dealloc {

}

#pragma mark - Delegate

#pragma mark - RJChartLandscapeViewControllerDelegate Methods

- (BOOL)ls_shouldAutorotate {
    UIInterfaceOrientation currentOrientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    [self _rotationToLandscapeOrientation:currentOrientation];
    return YES;
}

- (void)ls_willRotateToOrientation:(UIInterfaceOrientation)orientation {
    self.fullScreen = UIInterfaceOrientationIsLandscape(orientation);
    if (self.orientationWillChange) {
        self.orientationWillChange(self.fullScreen);
    }
}

- (void)ls_didRotateToOrientation:(UIInterfaceOrientation)orientation {
    if (!self.fullScreen) {
        [self _rotationToPortraitOrientation:UIInterfaceOrientationPortrait];
    }
}

- (CGRect)ls_targetRect {
    CGRect targetRect = [self.containerView convertRect:self.containerView.bounds toView:self.containerView.window];
    return targetRect;
}

#pragma mark - Public Methods

- (void)enterFullScreen:(BOOL)fullScreen animated:(BOOL)animated completed:(void (^)(void))completed {
    UIInterfaceOrientation orientation = fullScreen ? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait;
    [self rotateToOrientation:orientation animated:animated completed:completed];
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated completed:(void (^)(void))completed {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        if (!self.fullScreen) {
            CGRect targetRect = [self.containerView convertRect:self.contentView.frame toView:self.containerView.window];
            if (!self.window) {
                self.window = [[RJChartLandscapeWindow alloc] init];
                [self.window.rootViewController loadViewIfNeeded];
            }
            self.window.landscapeViewController.delegate = self;
            self.window.landscapeViewController.targetRect = targetRect;
            self.window.landscapeViewController.originRect = self.contentView.frame;
            self.window.landscapeViewController.containerView = self.containerView;
            self.window.landscapeViewController.contentView = self.contentView;
            self.fullScreen = YES;
        }
        if (self.orientationWillChange) {
            self.orientationWillChange(self.fullScreen);
        }
    } else {
        self.fullScreen = NO;
    }
    
    // 强制更改设备方向
    [self interfaceOrientation:UIInterfaceOrientationUnknown];
    [self interfaceOrientation:orientation];
}

#pragma mark - Private Methods

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated {
    [self rotateToOrientation:orientation animated:animated completed:nil];
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        UIInterfaceOrientation val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)_rotationToLandscapeOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (keyWindow != self.window && self.previousKeyWindow != keyWindow) {
            self.previousKeyWindow = keyWindow;
        }
        if (!self.window.isKeyWindow) {
            [self.window makeKeyAndVisible];
        }
    }
}

- (void)_rotationToPortraitOrientation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationPortrait && !self.window.hidden) {
        UIView *snapshot = [self.contentView snapshotViewAfterScreenUpdates:NO];
        snapshot.frame = self.containerView.bounds;
        [self.containerView addSubview:snapshot];
        [self performSelector:@selector(_contentViewAdd:) onThread:NSThread.mainThread withObject:self.containerView waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
        [self performSelector:@selector(_makeKeyAndVisible:) onThread:[NSThread mainThread] withObject:snapshot waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
    }
}

- (void)_contentViewAdd:(UIView *)containerView {
    [containerView addSubview:self.contentView];
    self.contentView.frame = self.containerView.bounds;
    [self.contentView layoutIfNeeded];
}

- (void)_makeKeyAndVisible:(UIView *)snapshot {
    [snapshot removeFromSuperview];
    UIWindow *previousKeyWindow = self.previousKeyWindow ?: [UIApplication sharedApplication].windows.firstObject;
    [previousKeyWindow makeKeyAndVisible];
    self.previousKeyWindow = nil;
    self.window.hidden = YES;
}

#pragma mark - Property Methods

- (void)setFullScreen:(BOOL)fullScreen {
    _fullScreen = fullScreen;
    [self.window.landscapeViewController setNeedsStatusBarAppearanceUpdate];
    [UIViewController attemptRotationToDeviceOrientation];
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    self.containerView = contentView.superview;
}


@end
