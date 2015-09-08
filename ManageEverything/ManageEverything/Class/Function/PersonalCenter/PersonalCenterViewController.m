//
//  PersonalCenterViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "DefaultViewController.h"
#import "HomePgeViewController.h"
#import "ZTabBarController.h"
#import "AppDelegate.h"
@interface PersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSArray *_dataSource;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;



@property (weak, nonatomic) IBOutlet UIButton *loginOut;

@property (strong, nonatomic) IBOutlet UITableViewCell *cell1;

@property (strong, nonatomic) IBOutlet UITableViewCell *cell2;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell3;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell4;

@property (strong, nonatomic) IBOutlet UITableViewCell *cell5;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell6;


- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation PersonalCenterViewController


-(void)initializeDataSource {
    
    [self showLoading];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _nameLabel.text =  [userDefaults objectForKey:@"admin_name"];
    _phoneNumber.text = [userDefaults objectForKey:@"phoneNumber"];
    [self hideLoading];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self initializeDataSource];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeDataSource];
    [self initializeInterface];
}

- (void)initializeInterface {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"个人中心";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    //    _tableVIew.tableFooterView = [[UIView alloc]init];
    self.navigationController.navigationBar.translucent = NO;
    _tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dataSource = @[_cell2,_cell3,_cell1,_cell4,_cell5,_cell6];
    _tableVIew.backgroundColor = [UIColor colorWithRed:0.933f green:0.933f blue:0.933f alpha:1.00f];

}
- (IBAction)btnClick:(UIButton *)sender {
    
    [Common loginOut];
    [DisplayView disPlayShowWithTitle:@"退出成功"];
//    _nameLabel.text = nil;
//    _phoneNumber.text = nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"admin_name"];
    [userDefaults removeObjectForKey:@"phoneNumber"];
    [userDefaults removeObjectForKey:@"nameText"];
    [userDefaults removeObjectForKey:@"passwordText"];
    [userDefaults synchronize];
//    _nameLabel.text =  [userDefaults objectForKey:@"nameText"];
//    _phoneNumber.text = [userDefaults objectForKey:@"passwordText"];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:NO];
    
}

- (void)timerAction {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    DefaultViewController *dv = (DefaultViewController *)appDelegate.window.rootViewController;
    UINavigationController *nav = (UINavigationController *)dv.tabBarController.viewControllers[0];
    [nav popToRootViewControllerAnimated:YES];
    [dv.tabBarController tabbarSelectIndex:0];

}
#pragma mark - <>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 52;
    }
    if (indexPath.row == 2) {
        return 60;
    }
    if (indexPath.row == 5) {
        return 52;
    }
    UITableViewCell *cell = _dataSource[indexPath.row];
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"height:%lf",cell.frame.size.height);
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = _dataSource[indexPath.row];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
