//
//  LoginViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/5.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "LoginViewController.h"
#import "IssueFeedBackViewController.h"
#import "HomePageView.h"
#import "HomePgeViewController.h"
#import "HomeNewsViewController.h"
#import "GuideOfServiceViewController.h"
#import "NotificationAndAnnouncementViewController.h"
#import "APService.h"


@interface LoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation LoginViewController
- (IBAction)loginClick:(UIButton *)sender {
    
    //回收键盘
    [self.view endEditing:YES];
    
    
    typeof(self) myself = self;
    if (self.nameText.text.length == 0 || self.passwordText.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"用户名或密码为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];

        [alertView show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
        });
     
//        [NetWorkHandler loginParams:@{@"tel":self.nameText.text,@"password":self.passwordText.text} completionHandler:^(id content) {
//            if (content) {
//                
//                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                [userDefaults setObject:self.nameText.text forKey:@"nameText"];
//                [userDefaults setObject:self.passwordText.text forKey:@"passwordText"];
//                [userDefaults synchronize];
//                [Common islogin];
//                [Common saveUserInfo:content[@"data"]];
//                
//                NSLog(@"%@",content);
//                NSLog(@"%@",content[@"msg"]);
//                NSLog(@"%@",[Common getUserInfo][@"alias"]);
//                //            UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//                //            UINavigationController *nav = (UINavigationController *)tab.viewControllers[0];
//                //            HomePgeViewController *hvc = (HomePgeViewController *)nav.viewControllers[0];
//                //hvc
//                [APService setTags:[NSSet setWithObject:[Common getUserInfo][@"alias"]] alias:nil callbackSelector:nil object:nil];
//               
//                HomeNewsViewController *vc = [[HomeNewsViewController alloc]initWithNibName:@"HomeNewsViewController" bundle:nil];
//                [self.navigationController pushViewController:vc animated:NO];
//            }
//        }];

    }
    
//        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(remove) userInfo:nil repeats:NO];
    
//     __weak typeof(self)myself = self;
//    [NetWorkHandler loginParams:@{@"tel":self.nameText.text,@"password":[Common md5HexDigest:self.passwordText.text]} completionHandler:^(id content) {
//        if (content) {
//            NSLog(@"%@",content);
//            
////            UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
////            UINavigationController *nav = (UINavigationController *)tab.viewControllers[0];
////            HomePgeViewController *hvc = (HomePgeViewController *)nav.viewControllers[0];
////            hvc
//            
//        }
//    }];
   
    else {

        [NetWorkHandler loginParams:@{@"tel":self.nameText.text,@"password":self.passwordText.text} completionHandler:^(id content) {
            if (![content[@"error"] integerValue] == 1) {
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.nameText.text forKey:@"phoneNumber"];
                [userDefaults setObject:self.passwordText.text forKey:@"passwordText"];
                [userDefaults synchronize];
                [Common islogin];
                [Common saveUserInfo:content[@"data"]];
                
                NSLog(@"%@",content);
                NSLog(@"%@",content[@"msg"]);
                NSLog(@"%@",[Common getUserInfo]);
                NSLog(@"%@",[Common getUserInfo][@"alias"]);

                //            UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                //            UINavigationController *nav = (UINavigationController *)tab.viewControllers[0];
                //            HomePgeViewController *hvc = (HomePgeViewController *)nav.viewControllers[0];
                //hvc
                if ([Common getUserInfo]) {
                    
//                    [APService setTags:[NSSet setWithObjects:@"88888888",[Common getUserInfo][@"alias"],nil] alias:nil callbackSelector:nil object:nil];
                    [APService setTags:[NSSet setWithObject:@"people"] alias:[NSString stringWithFormat:@"%@",[Common getUserInfo][@"alias"]] callbackSelector:nil object:nil];
                }
                
                

                
                NSInteger tag = self.index;
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
//                HomeNewsViewController *vc = [[HomeNewsViewController alloc]initWithNibName:@"HomeNewsViewController" bundle:nil];
//                [self.navigationController pushViewController:vc animated:NO];
            }
            else {
                [DisplayView disPlayShowWithTitle:content[@"msg"]];
            }
        }];

    }
    
}

- (void)remove{
    
    [self removeFromParentViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"用户登录";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    UIImage *image = [UIImage imageNamed:@"return"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //    [leftBtn setAction:@selector(pushBack)];
    self.navigationItem.leftBarButtonItem = leftBtn;

    
    _nameText.delegate = self;
    _passwordText.delegate = self;
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.nameText.text = [userDefaults objectForKey:@"nameText"];
    self.passwordText.text = [userDefaults objectForKey:@"passwordText"];
    
    
}

- (void)pushBack {
    
    //    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //    UINavigationController *nav = (UINavigationController *)tab.viewControllers[1];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - <>

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    return YES;
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
