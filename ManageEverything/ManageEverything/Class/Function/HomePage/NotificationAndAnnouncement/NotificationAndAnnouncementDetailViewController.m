//
//  NotificationAndAnnouncementDetailViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "NotificationAndAnnouncementDetailViewController.h"

@interface NotificationAndAnnouncementDetailViewController () <UITextViewDelegate>

@property (nonatomic,strong) UILabel *dTitleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UITextView *contentTextView;

@property (nonatomic,strong) UITextView *textView;


- (void)initializeInterface;
- (void)initializeDataSource;
@end

@implementation NotificationAndAnnouncementDetailViewController

- (void)initializeDataSource {
    
    [self showLoading];
    [NetWorkHandler notificationAndAnnouncementOfDetailsWithParams:@{@"people_id":[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]], @"id":_serviceID == nil ? @"" : _serviceID}  completionHandle:^(id content) {
        NSLog(@"%@",content);
        
        _contentTextView.text = content[@"data"][@"content"];
        _dTitleLabel.text = content[@"data"][@"title"];
        
        //
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[content[@"data"][@"update_time"] doubleValue]];
        _timeLabel.text = [NSString stringWithFormat:@"时间:%@",[formatter stringFromDate:date]];
        [self hideLoading];
    }];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?ID=%@", stringUrl, _newsID]]];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *html = operation.responseString;
//        [webView loadHTMLString:html baseURL:nil];
//        [self stopLoading];
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"发生错误！%@",error);
//    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeInterface];
}

- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"通知公告详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    UIImage *image = [UIImage imageNamed:@"return"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //   [leftBtn setAction:@selector(pushBack)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    _textView.delegate = self;
    [_textView setEditable:NO];
    [self.view addSubview:_textView];
    
    
    _dTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 2 - 90, 10, 180, 30)];
    //    _dTitleLabel.backgroundColor = [UIColor greenColor];
    _dTitleLabel.textAlignment = NSTextAlignmentCenter;
    _dTitleLabel.font = [UIFont systemFontOfSize:14];
    [_textView addSubview:_dTitleLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 2 + 20, CGRectGetHeight(_dTitleLabel.bounds) + 8, 120, 20)];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont systemFontOfSize:11];
    //    _timeLabel.backgroundColor = [UIColor greenColor];
    [_textView addSubview:_timeLabel];
    
    _contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(_timeLabel.frame) + 10, ScreenWidth - 16, ScreenHeight  - 55)];
    _contentTextView.editable = NO;
    //    _contentTextView.backgroundColor = [UIColor grayColor];
    [_textView addSubview:_contentTextView];
}

- (void)pushBack {
    
    [self hideLoading];
    [self.navigationController popViewControllerAnimated:YES];
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
