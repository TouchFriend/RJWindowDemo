//
//  RJChartLandscapeWindow2.h
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/11/3.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJChartLandscapeViewController2.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJChartLandscapeWindow2 : UIWindow

/// 横屏控制器
@property (nonatomic, strong, readonly) RJChartLandscapeViewController2 *landscapeViewController;

@end

NS_ASSUME_NONNULL_END
