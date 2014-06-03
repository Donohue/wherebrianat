//
//  AppDelegate.m
//  WhereBrianAt
//
//  Created by Brian Donohue on 5/10/14.
//  Copyright (c) 2014 Brian Donohue. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MapViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
