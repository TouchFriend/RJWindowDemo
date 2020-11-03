//
//  RJChartLandscapeManager2.h
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/11/3.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJChartLandscapeManager2 : NSObject

/// 单例
+ (instancetype)shareInstance;

/// 是否是全屏
@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen;
/// 方向即将改变
@property (nonatomic, copy, nullable) void (^orientationWillChange)(BOOL isFullScreen);

/// 是否进入全屏
/// @param fullScreen 进入全屏为YES，退出全屏为NO
- (void)enterFullScreen:(BOOL)fullScreen;

@end

NS_ASSUME_NONNULL_END
