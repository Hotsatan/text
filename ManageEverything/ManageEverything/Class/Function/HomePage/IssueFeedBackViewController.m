//
//  IssueFeedBackViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/7.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "IssueFeedBackViewController.h"
#import "FeedBackCell.h"
#import "FeedBackSendViewController.h"
#import "AppDelegate.h"
#import "DefaultViewController.h"
#import "ZTabBarController.h"
#import "ZPhotoBrowserViewController.h"
@interface IssueFeedBackViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;


- (void)initializeData;
@end

@implementation IssueFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
    
    
    UIView *view = [[UIView alloc]init];
    self.tableView.tableFooterView = view;
    //
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"问题反馈";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    UIImage *image = [UIImage imageNamed:@"return"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    btn.clipsToBounds = YES;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //   [leftBtn setAction:@selector(pushBack)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    
    UIImage *timage = [UIImage imageNamed:@"add_que"];
    UIButton *rbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 28)];
    [rbtn setBackgroundImage:timage forState:UIControlStateNormal];
    [rbtn addTarget:self action:@selector(barButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    rbtn.clipsToBounds = YES;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rbtn];
    //   [leftBtn setAction:@selector(pushBack)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    //

    
    
    _dataSource = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 ) style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
//    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barButtonItemClick)];
//    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)pushBack {
    
    [self hideLoading];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)barButtonItemClick {
    
    FeedBackSendViewController *fvc = [[FeedBackSendViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:NO];
}

- (void)initializeData {
    [_dataSource removeAllObjects];
    [self showLoading];
    [NetWorkHandler feedbackgetFeedbackParams:@{@"people_id":[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]]} completionHandler:^(id content) {
        [self hideLoading];
        for (NSDictionary *dic in content[@"data"]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:dic];
//            int random = arc4random() % 6;
//            [dict setObject:@(random) forKey:@"picture_list"];
//            [dict objectForKey:dict[@""]];
            NSLog(@"dict:%@",dict);
            [_dataSource addObject:dict];
        }
        
//        [_dataSource addObjectsFromArray:content[@"data"]];
        
        [_tableView reloadData];
        NSLog(@"%@",content);
    }];
}




#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedBackCellModel *model = [[FeedBackCellModel alloc] initWithDictionaryParams:_dataSource[indexPath.row]];
//    if ([model.picture_list isKindOfClass:[NSArray class]]) {
//        NSUInteger height = [model.picture_list count];
//        return [FeedBackCell HeightWithModel:height];
//    }
//    else {
////        NSInteger height = [(NSNumber *)model.picture_list integerValue];;
////        return [FeedBackCell HeightWithModel:height];
////        return ;
//    }
    
    return [FeedBackCell HeightWithModel:model];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self initializeData];
    
    // 隐藏TabBar
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate App].window.rootViewController;
    [dvc.tabBarController setHideEsunTabBarBtn:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FeedBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[FeedBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    FeedBackCellModel *model = [[FeedBackCellModel alloc] initWithDictionaryParams:_dataSource[indexPath.row]];
    
    [cell setCellWithModel:model];
    
    [cell setSendImage:^(NSMutableArray *array){
        ZPhotoBrowserViewController *photoVc =  [ZPhotoBrowserViewController  photoBrowserDatas:array UseingBlock:^{
            
        }];
        [self.navigationController pushViewController:photoVc animated:YES];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    DefaultViewController *dv = (DefaultViewController *)appDelegate.window.rootViewController;
//    UINavigationController *nav = (UINavigationController *)dv.tabBarController.viewControllers[2];
////    [nav popToRootViewControllerAnimated:YES];
////    [dv.tabBarController tabbarSelectIndex:0];
////    FeedBackSendViewController *vc = [[FeedBackSendViewController alloc]initWithNibName:@"FeedBackSendViewController" bundle:nil];
////    [self presentViewController:vc animated:YES completion:nil];
//    nav.reshBlock2 = ^ (NSDictionary *dict){
//        
//        [_dataSource addObject:dict];
//        [self.tableView reloadData];
//    };
//    FeedBackSendViewController *vc = [[FeedBackSendViewController alloc]initWithNibName:@"FeedBackSendViewController" bundle:nil];
//    [self presentViewController:vc animated:YES completion:nil];
//    vc.reshBlock = ^ {
//        [NetWorkHandler feedbackgetFeedbackParams:@{@"people_id":[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]]} completionHandler:^(id content) {
//            
//            [_dataSource addObjectsFromArray:content[@"data"]];
//            [_tableView reloadData];
//            NSLog(@"%@",content);
//        }];
//
//    };
//    
   
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
