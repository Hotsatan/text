//
//  DefaultViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "ZTabBarController.h"
#import "DefaultViewController.h"
#import "HistoryRecordViewController.h"
#import "HomePgeViewController.h"
#import "PersonalCenterViewController.h"
#import "ScanViewController.h"
#import "NotificationViewController.h"
#import "ScanViewControler.h"
#import "CarsMessageViewController.h"

@interface DefaultViewController (){
    
    HomePgeViewController *_homePgeVC;
    NotificationViewController *_notificationVC;
    
    ScanViewController *_scanVC;
    ScanViewControler *_scan;
    
    HistoryRecordViewController *_historyRecordVC;
    PersonalCenterViewController *_personalCenterVC;
    
}

@end

@implementation DefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _homePgeVC = [[HomePgeViewController alloc]init];
    UINavigationController *nav0 = [[UINavigationController alloc]initWithRootViewController:_homePgeVC];

//    nav0.navigationBar.tintColor = [UIColor colorWithRed:0.004f green:0.439f blue:0.827f alpha:1.00f];
    
    _notificationVC = [[NotificationViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:_notificationVC];
    
    _scan = [[ScanViewControler alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:_scan];
//    CarsMessageViewController *carsMVc = [[CarsMessageViewController alloc]init];
//    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:carsMVc];
    
    
    _historyRecordVC = [[HistoryRecordViewController alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:_historyRecordVC];
    
    _personalCenterVC = [[PersonalCenterViewController alloc]init];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:_personalCenterVC];
    
    ZTabBarController *tabBarController = [[ZTabBarController alloc]init];
    tabBarController.viewControllers = @[nav0,nav1,nav2,nav3,nav4];
    [tabBarController tabbarSelectIndex:0];
    [self.view addSubview:tabBarController.view];
    [self addChildViewController:tabBarController];
    self.tabBarController = tabBarController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
