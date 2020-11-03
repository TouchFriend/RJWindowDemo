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

+ (instancetype)shareInstance;


/// 是否是全屏
@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen;
/// <#Desription#>
@property (nonatomic, copy, nullable) void (^orientationWillChange)(BOOL isFullScreen);

- (void)enterFullScreen:(BOOL)fullScreen;

@end

NS_ASSUME_NONNULL_END
