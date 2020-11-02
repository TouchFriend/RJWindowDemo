//
//  AppDelegate.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/10/28.
//

#import "AppDelegate.h"
#import "RJMainViewController.h"
#import "RJChartRotationHelper.h"
#import "RJMainTabBarViewController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RJMainTabBarViewController *vc = [[RJMainTabBarViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (RJAllowOrentitaionRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}


@end
