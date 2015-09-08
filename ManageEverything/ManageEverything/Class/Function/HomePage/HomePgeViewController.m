//
//  HomePageViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "HomePgeViewController.h"
#import "AdvertisementTableViewCell.h"
#import "HomePageView.h"
#import "HomeNewsViewController.h"
#import "IssueFeedBackViewController.h"
#import "GuideOfServiceViewController.h"
#import "NotificationAndAnnouncementViewController.h"
@interface HomePgeViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    AdvertisementTableViewCell *_advertisementTableViewCell;
    NSInteger _currenIndex;
    BOOL _isEmptytop;
    HomePageView *homePageView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (void)loadAdvertisementView;
- (void)loadHomePageView;
@end



@implementation HomePgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"管的宽";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.frame = CGRectMake(0, 0, ScreenWidth, 290);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.backgroundColor = [UIColor colorWithRed:0.929f green:0.945f blue:0.957f alpha:1.00f];
     _tableView.backgroundColor = [UIColor colorWithRed:0.933f green:0.933f blue:0.933f alpha:1.00f];
    [self loadAdvertisementView];
//    [self loadHomePageView];
    
    
   
    
}

- (void)loadAdvertisementView {
    
    _isEmptytop = YES;
    _advertisementTableViewCell = [AdvertisementTableViewCell advertisementTableViewCellBlock:^{
        
        
        _currenIndex = _advertisementTableViewCell ->_currentIndex;
        
    }];
//    _advertisementTableViewCell.bounds = CGRectMake(0, 0, ScreenWidth, 144);
    self.tableView.tableHeaderView = _advertisementTableViewCell;
    UIImage *image1 = [UIImage imageNamed:@"adImage1.png"];
    UIImage *image2 = [UIImage imageNamed:@"adImage2.png"];
    UIImage *image3 = [UIImage imageNamed:@"adImage3.png"];
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:image1,image2, image3,nil];
    
    [_advertisementTableViewCell setData:array];
//    [self.view addSubview:_advertisementTableViewCell];
}

//- (void)loadHomePageView {
//    
//    homePageView = [[[NSBundle mainBundle]loadNibNamed:@"HomePageView" owner:nil options:nil] firstObject];
//    homePageView.frame = CGRectMake(0, CGRectGetHeight(_advertisementTableViewCell.bounds), ScreenWidth, 200);
//    self.tableView.tableFooterView = homePageView;
//    
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (!homePageView) {
        homePageView = [[[NSBundle mainBundle]loadNibNamed:@"HomePageView" owner:nil options:nil] firstObject];
        homePageView.frame = CGRectMake(0, CGRectGetHeight(_advertisementTableViewCell.bounds), ScreenWidth, 200);
//        homePageView.backgroundColor = [UIColor colorWithRed:0.929f green:0.945f blue:0.957f alpha:1.00f];
        homePageView.backgroundColor = [UIColor colorWithRed:0.933f green:0.933f blue:0.933f alpha:1.00f];
        __unsafe_unretained typeof(self)myself = self;
        homePageView.btnPressed = ^(int tag) {
            if (![Common isUserLogin]) {
                LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                loginVC.index = tag;
                [myself.navigationController pushViewController:loginVC animated:YES];
                
            }
            
            else {
                NSLog(@"%ld",tag);
                if (tag == 1) {
                    HomeNewsViewController *vc = [[HomeNewsViewController alloc]initWithNibName:@"HomeNewsViewController" bundle:nil];
                    [myself.navigationController pushViewController:vc animated:YES];
                }
                else if (tag == 2) {
                    GuideOfServiceViewController *vc = [[GuideOfServiceViewController alloc]init];
                    [myself.navigationController pushViewController:vc animated:YES];
                }
                else if (tag == 3) {
                    
                    NotificationAndAnnouncementViewController *vc = [[NotificationAndAnnouncementViewController alloc]init];
                    [myself.navigationController pushViewController:vc animated:YES];
                    NSLog(@"通知公告");
                }
                else if (tag == 4) {
                    IssueFeedBackViewController *vc = [[IssueFeedBackViewController alloc]initWithNibName:@"IssueFeedBackViewController" bundle:nil];
                    [myself.navigationController pushViewController:vc animated:YES];
                }

            }
            
        
        };

    }
    return homePageView;

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //隐藏tabBar
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate App].window.rootViewController;
    [dvc.tabBarController setHideEsunTabBarBtn:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 250;
}

#pragma mark - <>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    return cell;
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
