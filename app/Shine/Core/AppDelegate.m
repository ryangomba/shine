//
//  AppDelegate.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "AppDelegate.h"
#import "UAController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self createAndCheckDatabase:@"Shine.db"];
    
    NSNumber *selectedLocationID = [ShineDefaults shared].selectedLocation;
    if (selectedLocationID) {
        NSLog(@"Selected location: %@", selectedLocationID);
    } else {
        [ShineDefaults shared].selectedLocation = [NSNumber numberWithInt:1];
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bg"] forBarMetrics:UIBarMetricsDefault];
    
    UIImage *button = [[UIImage imageNamed:@"button"] stretchableImageWithLeftCapWidth:4.0 topCapHeight:0.0];
    UIImage *buttonDown = [[UIImage imageNamed:@"button-down"] stretchableImageWithLeftCapWidth:4.0 topCapHeight:0.0];
    [[UIBarButtonItem appearance] setBackgroundImage:button forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:buttonDown forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:buttonDown forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    UIImage *backButton = [[UIImage imageNamed:@"button-back"] stretchableImageWithLeftCapWidth:18.0 topCapHeight:0.0];
    UIImage *backButtonDown = [[UIImage imageNamed:@"button-back-down"] stretchableImageWithLeftCapWidth:18.0 topCapHeight:0.0];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonDown forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonDown forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[[[deviceToken description]
                     stringByReplacingOccurrencesOfString: @"<" withString: @""]
                    stringByReplacingOccurrencesOfString: @">" withString: @""]
                   stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"TOKEN %@", token);
    [ShineDefaults shared].deviceToken = token;
    [[[UAController alloc] init] registerDevice:token];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"NO TOKEN: %@", error);
    [ShineDefaults shared].deviceToken = nil;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"recieved PUSH!");
    int badgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue];
    NSString *alertString = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Temp"
                                                        message:[NSString stringWithFormat:@"%d", badgeNumber]
                                                       delegate:self
                                               cancelButtonTitle:@"Dismiss"
                                               otherButtonTitles:nil];
    [alertView show];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[CLController shared] stopUpdatingLocation];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[CLController shared] startUpdatingLocation];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - DB Setup

- (void)createAndCheckDatabase:(NSString *)databaseName
{
    NSString *databasePath = [Data databasePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:databasePath]) return;

    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}

@end
