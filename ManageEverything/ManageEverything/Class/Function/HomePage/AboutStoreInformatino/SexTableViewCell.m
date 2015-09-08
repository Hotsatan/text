//
//  SexTableViewCell.m
//  ManageEverything
//
//  Created by zz on 15/6/24.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "SexTableViewCell.h"

@interface SexTableViewCell () {
    
    UIButton *btn1;
    UIButton *btn2;
}

@end

@implementation SexTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        UILabel *fLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 14, ScreenWidth * 0.2 +10, 20)];
        fLabel.textColor = [UIColor blackColor];
        fLabel.font = [UIFont systemFontOfSize:14];
        fLabel.text = @"性    别";
        //        fLabel = self.fLabel;
        [self addSubview:fLabel];
        
        
        btn1 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth * 0.2 + 10 + 8 + 10, 14 , 22, 22)];
        [btn1 setImage:[UIImage imageNamed:@"choose_no"] forState:UIControlStateNormal];
        [btn1 setImage:[UIImage imageNamed:@"choose_yes"] forState:UIControlStateSelected];
        [btn1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag = 50000;
        [self addSubview:btn1];
        
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 15, 14 , 22, 22)];
        label1.text = @"否";
        label1.font = [UIFont systemFontOfSize:14];
        label1.textColor = [UIColor grayColor];
        [self addSubview:label1];
        
        
        btn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 25, 14 , 22, 22)];
        [btn2 setImage:[UIImage imageNamed:@"choose_no"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"choose_yes"] forState:UIControlStateSelected];
        [btn2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = 50001;
        [self addSubview:btn2];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame) + 15, 14 , 22, 22)];
        label2.text = @"是";
        label2.font = [UIFont systemFontOfSize:14];
        label2.textColor = [UIColor grayColor];
        [self addSubview:label2];
    }
    return self;
}


- (void)buttonPressed:(UIButton *)sender {
    
    NSInteger i = sender.tag - 50000;
    if (i == 0) {
        btn1.selected = YES;
        btn2.selected = NO;
    }
    else {
        btn1.selected = NO;
        btn2.selected = YES;
    }
}
@end
