//
//  HomeNewsViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/5.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "HomeNewsViewController.h"
#import "HomeMessageDetailViewController.h"
#import "CarsMessageViewController.h"
#import "AboutStoreInformatinoViewController.h"
@interface HomeNewsViewController ()

@end

@implementation HomeNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"房屋信息";
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,
//                                                                     [UIColor whiteColor], UITextAttributeTextShadowColor,
//                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
//                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    
    //
    UIImage *image = [UIImage imageNamed:@"return"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    [leftBtn setAction:@selector(pushBack)];
    self.navigationItem.leftBarButtonItem = leftBtn;
   
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //隐藏tabBar
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate App].window.rootViewController;
    [dvc.tabBarController setHideEsunTabBarBtn:YES];
     NSLog(@"xxxx%@",NSStringFromCGRect(self.view.frame));
}


- (void)pushBack {
    
//    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    UINavigationController *nav = (UINavigationController *)tab.viewControllers[1];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)btnClick:(UIButton *)sender {
    
    NSUInteger i = sender.tag - 15;
    if (i == 0) {
        HomeMessageDetailViewController *vc = [[HomeMessageDetailViewController alloc]initWithNibName:@"HomeMessageDetailViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
       
    }
    if (i == 1) {
        
        AboutStoreInformatinoViewController *vc = [[AboutStoreInformatinoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (i == 2) {
        CarsMessageViewController *vc = [[CarsMessageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (i == 3) {
        
    }
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
