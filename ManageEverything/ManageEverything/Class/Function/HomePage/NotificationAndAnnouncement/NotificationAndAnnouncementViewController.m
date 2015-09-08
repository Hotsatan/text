//
//  NotificationAndAnnouncementViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "NotificationAndAnnouncementViewController.h"
#import "NotificationAndAnnouncementTableViewCell.h"
#import "NotificationAndAnnouncementDetailViewController.h"

@interface NotificationAndAnnouncementViewController () <UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}

@end

@implementation NotificationAndAnnouncementViewController

- (void)initializeDataSource {
    
    [self showLoading];
    _dataSource = [[NSMutableArray alloc] init];
    [NetWorkHandler notificationAndAnnouncementWithParams:@{@"people_id":[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]]} completionHandle:^(id content) {
        
        if (content) {
            //id title update_time
            
            //            for (NSMutableArray *array in content) {
            //                NSLog(@"array:%@",array);
            //                [_dataSource addObject:array];
            //            }
            //            GuideOfServiceTableViewCellModel *model = [[GuideOfServiceTableViewCellModel alloc]initWithDicitonary:content];
            //            for (int i = 0; i < content[@"data"].count; i ++) {
            //                [_dataSource addObject:content[i]];
            //            }
            //            NSLog(@"%@",model);
            //            [_dataSource addObjectsFromArray:content];
            //            for (NSMutableArray *array in content[@"data"]) {
            //                [_dataSource addObject:array];
            //            }
            //             _dataSource = [content[@"data"] mutableCopy];
//            for (NSDictionary *dic in content[@"data"]) {
//                GuideOfServiceTableViewCellModel *model = [[GuideOfServiceTableViewCellModel alloc] initWithDictionaryParams:dic];
//                [_dataSource addObject:model];
//            }
            
            for (NSDictionary *dic in content[@"data"]) {
                NotificationAndAnnouncementModel *model = [[NotificationAndAnnouncementModel alloc]initWithDictionaryParams:dic];
                [_dataSource addObject:model];
            }
            [_tableView reloadData];
            [self hideLoading];
            
        }
        NSLog(@"%@",content[@"data"]);
        //        NSLog(@"")
        NSLog(@"%@",_dataSource);
        NSLog(@"......%@",content);
        NSLog(@"%d",[content count]);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataSource = [[NSMutableArray alloc]init];
    [self initializeDataSource];
    
    [self initializeInterface];
}


- (void)initializeInterface {
    
    //
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"通知公告";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    UIImage *image = [UIImage imageNamed:@"return"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //   [leftBtn setAction:@selector(pushBack)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *view = [[UIView alloc]init];
    _tableView.tableFooterView = view;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 隐藏TabBar
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate App].window.rootViewController;
    [dvc.tabBarController setHideEsunTabBarBtn:YES];
}

- (void)pushBack {
    
    [self hideLoading];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - <>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    NSLog(@"dataSource:%d",_dataSource[@"data"].count);
    //    return 2;
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    static NSString *cellID = @"cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    //    if (!cell) {
    //
    //    }
    //
    //    return cell;
    
    NotificationAndAnnouncementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[NotificationAndAnnouncementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //    GuideOfServiceTableViewCellModel *model = [[GuideOfServiceTableViewCellModel alloc] initWithDictionaryParams:_dataSource[indexPath.row]];
    //    NSLog(@"model:%@",model);
//     [cell setCellWithModel:_dataSource[indexPath.row]];
    NotificationAndAnnouncementModel *model = _dataSource[indexPath.row];
    [cell setCellWithModel:model];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotificationAndAnnouncementDetailViewController *vc = [[NotificationAndAnnouncementDetailViewController alloc]init];
    NotificationAndAnnouncementModel *model = _dataSource[indexPath.row];
    vc.serviceID = model.id;
    [self.navigationController pushViewController:vc
                                         animated:YES];
    
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
