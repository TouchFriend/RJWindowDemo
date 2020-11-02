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
        self.hidden = YES;
    }
    return self;
}


@end
