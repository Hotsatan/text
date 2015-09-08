//
//  HomePageView.h
//  ManageEverything
//
//  Created by zz on 15/6/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonPressed)(int i);

@interface HomePageView : UIView


@property (weak, nonatomic) IBOutlet UIButton *houseBtn;

@property (weak, nonatomic) IBOutlet UIButton *familyBtn;
@property (weak, nonatomic) IBOutlet UIButton *issueBtn;

@property (weak, nonatomic) IBOutlet UIButton *notificationBtn;

@property (nonatomic,copy) buttonPressed btnPressed;
@end
