//
//  RJChartLandscapeViewController.h
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/10/29.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RJChartLandscapeViewControllerDelegate <NSObject>

- (BOOL)ls_shouldAutorotate;
- (void)ls_willRotateToOrientation:(UIInterfaceOrientation)orientation;
- (void)ls_didRotateToOrientation:(UIInterfaceOrientation)orientation;
- (CGRect)ls_targetRect;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RJChartLandscapeViewController : UIViewController

/// 代理
@property (nonatomic, weak) id <RJChartLandscapeViewControllerDelegate> delegate;
/// <#Desription#>
@property (nonatomic, assign) CGRect targetRect;
/// <#Desription#>
@property (nonatomic, assign) CGRect originRect;
/// <#Desription#>
@property (nonatomic, weak) UIView *containerView;
/// 内容view
@property (nonatomic, weak) UIView *contentView;


@end

NS_ASSUME_NONNULL_END
