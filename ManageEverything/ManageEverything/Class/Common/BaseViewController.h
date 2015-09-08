//
//  BaseViewController.h
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

- (void)showLoading;
- (void)hideLoading;

@end
