//
//  AppDelegate.m
//  FoodsDemo
//
//  Created by Bruce Ricketts on 5/14/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "AppDelegate.h"
#import "FoodsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    FoodsViewController *foodsViewController = [[FoodsViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:foodsViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
