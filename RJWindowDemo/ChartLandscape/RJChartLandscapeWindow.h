//
//  RJChartLandscapeWindow.h
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/10/29.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJChartLandscapeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJChartLandscapeWindow : UIWindow

/// 横屏控制器
@property (nonatomic, strong, readonly) RJChartLandscapeViewController *landscapeViewController;


@end

NS_ASSUME_NONNULL_END
