//
//  RJChartLandscapeWindow.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/10/29.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJChartLandscapeWindow.h"

@implementation RJChartLandscapeWindow

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _landscapeViewController = [[RJChartLandscapeViewController alloc] init];
        self.rootViewController = _landscapeViewController;
        if (@available(iOS 13.0, *)) {
            if (self.windowScene == nil) {
                self.windowScene = UIApplication.sharedApplication.keyWindow.windowScene;
            }
        }
        self.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    static CGRect bounds;
    if (!CGRectEqualToRect(bounds, self.bounds)) {
        UIView *superview = self;
        if (@available(iOS 13.0, *)) {
            superview = self.subviews.firstObject;
        }
        [UIView performWithoutAnimation:^{
            for (UIView *view in superview.subviews) {
                if (view != self.rootViewController.view && [view isMemberOfClass:UIView.class]) {
                    view.backgroundColor = UIColor.clearColor;
                    for (UIView *subview in view.subviews) {
                        subview.backgroundColor = UIColor.clearColor;
                    }
                }
            }
        }];
    }
    bounds = self.bounds;
    self.rootViewController.view.frame = bounds;
}

@end
