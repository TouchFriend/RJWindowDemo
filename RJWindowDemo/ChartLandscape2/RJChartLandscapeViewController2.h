//
//  RJChartLandscapeViewController2.h
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/11/3.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RJChartLandscapeViewControllerDelegate2 <NSObject>

- (BOOL)ls_shouldAutorotate;
- (void)ls_willRotateToOrientation:(UIInterfaceOrientation)orientation;
- (void)ls_didRotateToOrientation:(UIInterfaceOrientation)orientation;
- (CGRect)ls_targetRect;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RJChartLandscapeViewController2 : UIViewController

/// 代理
@property (nonatomic, weak) id <RJChartLandscapeViewControllerDelegate2> delegate;
/// Desription
@property (nonatomic, assign) BOOL present;

@end

NS_ASSUME_NONNULL_END
