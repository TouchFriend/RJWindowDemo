//
//  RJChartLandscapeManager2.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/11/3.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJChartLandscapeManager2.h"
#import "RJChartLandscapeWindow2.h"

@interface RJChartLandscapeManager2 () <RJChartLandscapeViewControllerDelegate2>

/// 横屏窗口
@property (nonatomic, strong) RJChartLandscapeWindow2 *window;
/// 前一个根窗口
@property (nonatomic, strong) UIWindow *previousKeyWindow;


@end

@implementation RJChartLandscapeManager2

+ (instancetype)shareInstance {
    static RJChartLandscapeManager2 *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[RJChartLandscapeManager2 alloc] init];
        [_manager setupInit];
    });
    return _manager;
}

#pragma mark - Setup Init

- (void)setupInit {
}

- (void)dealloc {

}

#pragma mark - Public Methods

- (void)enterFullScreen:(BOOL)fullScreen {
    UIInterfaceOrientation orientation = fullScreen ? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait;
    [self rotateToOrientation:orientation];
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.fullScreen = YES;
        if (self.orientationWillChange) {
            self.orientationWillChange(self.fullScreen);
        }
    } else {
        self.fullScreen = NO;
    }
    
    [self _rotationToLandscapeOrientation:orientation];
    // 强制更改设备方向
    [self interfaceOrientation:UIInterfaceOrientationUnknown];
    [self interfaceOrientation:orientation];
    
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



#pragma mark - Private Methods

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
        UIWindow *previousKeyWindow = self.previousKeyWindow ?: [UIApplication sharedApplication].windows.firstObject;
        [previousKeyWindow makeKeyAndVisible];
        self.previousKeyWindow = nil;
        self.window.hidden = YES;
    }
}

#pragma mark - Property Methods

- (RJChartLandscapeWindow2 *)window {
    if (!_window) {
        _window = [[RJChartLandscapeWindow2 alloc] init];
        _window.landscapeViewController.delegate = self;
        [_window.rootViewController loadViewIfNeeded];
    }
    return _window;
}

- (void)setFullScreen:(BOOL)fullScreen {
    _fullScreen = fullScreen;
    [self.window.landscapeViewController setNeedsStatusBarAppearanceUpdate];
    [UIViewController attemptRotationToDeviceOrientation];
}

@end
