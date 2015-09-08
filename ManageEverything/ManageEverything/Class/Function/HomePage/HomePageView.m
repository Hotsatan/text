//
//  HomePageView.m
//  ManageEverything
//
//  Created by zz on 15/6/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "HomePageView.h"

@implementation HomePageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)btnClick:(UIButton *)sender {
    
    int tag = (int)sender.tag - 10;
    sender.highlighted = YES;
    _btnPressed(tag);
}

//- (void)setTabarPress:(buttonPressed)btnPressed {
//    _btnPressed = btnPressed;
//}

- (void)setHouseBtn:(UIButton *)houseBtn {
    
    
}

@end
