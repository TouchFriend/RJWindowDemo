//
//  RJMainTabBarViewController2.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/11/3.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJMainTabBarViewController2.h"
#import "RJMainViewController2.h"
#import "RJMyViewController.h"

@interface RJMainTabBarViewController2 ()

@end

@implementation RJMainTabBarViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RJMainViewController2 *mainVC = [[RJMainViewController2 alloc] init];
    UINavigationController *navigation1 = [[UINavigationController alloc] initWithRootViewController:mainVC];
    navigation1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"测试" image:nil tag:0];
    
    RJMyViewController *myVC = [[RJMyViewController alloc] init];
    UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:myVC];
    navigation2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:nil tag:1];
    
    self.viewControllers = @[navigation1, navigation2];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


@end
