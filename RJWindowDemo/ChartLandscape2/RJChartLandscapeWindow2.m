//
//  RJChartLandscapeWindow2.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/11/3.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJChartLandscapeWindow2.h"

@implementation RJChartLandscapeWindow2

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _landscapeViewController = [[RJChartLandscapeViewController2 alloc] init];
        self.rootViewController = _landscapeViewController;
        self.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 13.0, *)) {
            if (self.windowScene == nil) {
                self.windowScene = UIApplication.sharedApplication.keyWindow.windowScene;
            }
        }
        self.hidden = YES;
    }
    return self;
}

@end
