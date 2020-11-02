//
//  RJChartLandscapeManager.h
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/10/29.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJChartLandscapeWindow.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJChartLandscapeManager : NSObject

+ (instancetype)shareInstance;

/// 是否是全屏
@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen;
/// 容器view
@property (nonatomic, weak) UIView *containerView;
/// 内容view
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, readonly) UIInterfaceOrientation currentOrientation;

- (void)enterFullScreen:(BOOL)fullScreen animated:(BOOL)animated completed:(void (^ _Nullable)(void))completed;

/// <#Desription#>
@property (nonatomic, copy, nullable) void (^orientationWillChange)(BOOL isFullScreen);


@end

NS_ASSUME_NONNULL_END
