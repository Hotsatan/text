//
//  BaseViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    self.indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView.bounds = CGRectMake(0, 0, 30, 30);
    self.indicatorView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
    [self.navigationController.view addSubview:_indicatorView];
    
    
    
}

- (void)showLoading {
    
//    [self.view bringSubviewToFront:_indicatorView];
    [self.indicatorView startAnimating];
}

- (void)hideLoading {

    [self.indicatorView stopAnimating];
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
