//
//  NotificationViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/4.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "NotificationViewController.h"
#import "MyNotificationTableViewCell.h"
#import "DefaultViewController.h"
#import "AppDelegate.h"
@interface NotificationViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"我的消息";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:0.933f green:0.933f blue:0.933f alpha:1.00f];

}
//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    DefaultViewController *vc = (DefaultViewController *)[AppDelegate App].window.rootViewController;
//    [vc.tabBarController setHideRedPoint:YES index:1];
//    [vc.tabBarController setHideEsunTabBarBtn:YES];
//}

#pragma mark - <>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"Cell";
    MyNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyNotificationTableViewCell" owner:nil options:nil]firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

//    MyNotificationTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MyNotificationTableViewCell" owner:nil options:nil] firstObject];
//    NSLog(@"%lf",cell.frame.size.height);
//    return cell.frame.size.height;
    return 52;
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
