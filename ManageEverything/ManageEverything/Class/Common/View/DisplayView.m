//
//  DisplayView.m
//  LuZhouTong
//
//  Created by dqdeng on 14/12/12.
//  Copyright (c) 2014年 choice. All rights reserved.
//

#import "DisplayView.h"

@interface DisplayView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation DisplayView

- (void)disPlayShowType:(AlertTypeString)type {

}


+ (void)disPlayShowWithTitle:(NSString *)title {

    UIViewController *nav = [Common appRootViewController];
    DisplayView *display = [[[NSBundle mainBundle] loadNibNamed:@"DisplayView" owner:nil options:nil] firstObject];
    display.titleLabel.text = title;
    display.frame = nav.view.frame;
    [display.bgView.layer setCornerRadius:5];
    display.bgView.backgroundColor = UIColorFromRGB(0x1d1d1d);
    [nav.view addSubview:display];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [display removeFromSuperview];
    });
}

+ (void)disPlayTitle:(NSString *)title {

    UIViewController *nav = [Common appRootViewController];
    DisplayView *display = [[[NSBundle mainBundle] loadNibNamed:@"DisplayView" owner:nil options:nil] firstObject];
    display.tag = 1299;
    display.titleLabel.text = title;
    display.frame = nav.view.frame;
    [display.bgView.layer setCornerRadius:5];
    [nav.view addSubview:display];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [display removeFromSuperview];
    });

}
+ (void)hideTitle {
    UIViewController *nav = [Common appRootViewController];
    [[nav.view viewWithTag:1299] removeFromSuperview];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  //  [self removeFromSuperview];
}
- (void)dealloc {
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
