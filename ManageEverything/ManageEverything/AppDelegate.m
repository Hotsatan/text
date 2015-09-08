//
//  AppDelegate.m
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

//UIButton tag值 50000

//UITextField tag 值 60000

//UILabel tag 值 70000
#import "AppDelegate.h"
#import "DefaultViewController.h"
#import "APService.h"
#import "TestViewController.h"
#import "IQKeyboardManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *) App
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

//- (void)win {
//    
////    [UIApplication sharedApplication].keyWindow;
//    
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    self.viewController = [[DefaultViewController alloc]init];
    self.window.rootViewController = self.viewController;
    
//    [[UINavigationBar appearance]setBackgroundColor:[UIColor redColor]];
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.000f green:0.435f blue:0.824f alpha:1.00f]];
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[TestViewController alloc] init]];
    //设置推送类型
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        [APService
         registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound |
                                             UIUserNotificationTypeAlert)
         categories:nil];
    }
    else
    {
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
         categories:nil];
    }
    [APService setupWithOption:launchOptions];
    
    //若图标上的数字为1 ，打开APP后置0
    if ([[UIApplication sharedApplication] applicationIconBadgeNumber] != 0)
    {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    
     
//    if ([Common getUserInfo]) {
//        
//        [APService setTags:[NSSet setWithObject:[Common getUserInfo][@"data"][@"alias"]] alias:nil callbackSelector:nil object:nil];
//    }
//    if ([Common getUserInfo]) {
//        
//        [APService setTags:[NSSet setWithObjects:@"people",[Common getUserInfo][@"alias"],nil] alias:nil callbackSelector:nil object:nil];
//    }
    
    //管理键盘弹出情况
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    return YES;
}

//
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    //    [APService handleRemoteNotification:userInfo];
    //    NSLog(@"收到通知1:%@", [self logDic:userInfo]);
    //    // [rootViewController addNotificationCount];
    NSLog(@"userInfo:%@", userInfo);
    
    DefaultViewController *dVc = (DefaultViewController *)self.window.rootViewController;
    
    [dVc.tabBarController setHideRedPoint:NO index:1];
    
}

// 获得设备号
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 上传设备号
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //若图标上的数字为1 ，打开APP后置0
    if ([[UIApplication sharedApplication] applicationIconBadgeNumber] != 0)
    {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
