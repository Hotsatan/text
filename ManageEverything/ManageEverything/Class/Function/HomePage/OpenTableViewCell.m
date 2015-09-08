//
//  OpenTableViewCell.m
//  LuZhouTong
//
//  Created by dqdeng on 15/1/30.
//  Copyright (c) 2015年 choice. All rights reserved.
//

#import "OpenTableViewCell.h"
@implementation OpenTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setType:(typeImage)type {
    _type = type;
    if (type == typeImageA) {
        _leftImage.hidden = NO;
        _vLeftImage.hidden = YES;
    } else {
        _leftImage.hidden = YES;
        _vLeftImage.hidden = NO;
    }
}
- (void)CEL_referesh {

    for (UIButton *button in self.buttonList) {
        NSString *text = @"";
        button.hidden = [text isEqualToString:@""] ? YES : NO;
        [button setTitle:text forState:UIControlStateNormal];
    }
}
- (void)setTitles:(NSArray *)titles dataName:(NSString *)dataName {

    self.buttonList = nil;
    self.buttonList = [@[_button1,_button2,_button3] mutableCopy];


    for (int i = 0; i < titles.count; i ++) {
        NSString *text = titles[i];
        UIButton *button = self.buttonList[i];
        if ([dataName isEqualToString:titles[i]]) {
            // button.titleLabel.font = [UIFont systemFontOfSize:19];
            [self isHightLight:button YESorNo:YES];
        }
        button.hidden = [text isEqualToString:@""] ? YES : NO;
        [button setTitle:text forState:UIControlStateNormal];
    }
}

- (void)isHightLight:(UIButton *)button YESorNo:(BOOL)boool {

    
    button.titleLabel.font = boool ? [UIFont systemFontOfSize:20] : [UIFont systemFontOfSize:15];
//    button.tintColor = boool ? UIColorFromRGB(0x2d2d2d) : UIColorFromRGB(0x8e8e8e);
//    if (boool) {
//        [button setTitleColor:UIColorFromRGB(0x2d2d2d) forState:UIControlStateNormal];
//        [button setTitleColor:UIColorFromRGB(0x2d2d2d) forState:UIControlStateHighlighted];
//    } else {
//        [button setTitleColor:UIColorFromRGB(0x8e8e8e) forState:UIControlStateNormal];
//        [button setTitleColor:UIColorFromRGB(0x8e8e8e) forState:UIControlStateHighlighted];
//    }
  
}



- (IBAction)buttonPresd:(UIButton *)sender {
    
    for (UIButton *button in self.buttonList) {
        if (button.tag == sender.tag) {
            [self isHightLight:button YESorNo:YES];
           // button.titleLabel.font = [UIFont systemFontOfSize:19];
        } else {
            [self isHightLight:button YESorNo:NO];
         //   button.titleLabel.font = [UIFont systemFontOfSize:15];
        }
    }

    self.block(sender.titleLabel.text);
}

- (void)settypeImageAtitle:(NSString *)title {

}

//- (void)setIshighlight:(BOOL)ishighlight {
//       
//    self.leftImage.highlighted = ishighlight;
//    if (!ishighlight) {
//        [self.cellBtn  setTintColor:UIColorFromRGB(0x8e8e8e)];
//        [self.cellBtn setTitleColor:UIColorFromRGB(0x8e8e8e) forState:UIControlStateNormal];
//    } else {
//        [self.cellBtn setTintColor:UIColorFromRGB(0x2d2d2d)];
//        [self.cellBtn setTitleColor:UIColorFromRGB(0x2d2d2d) forState:UIControlStateNormal];
//
//    }
//    
//}

//- (void)setAddmodel:(Tb_driver_remind_category *)addmodel {
//
//    BOOL ishighlight =  [addmodel isShow];
//    self.leftImage.highlighted = ishighlight;
//    self.mNameLabel.text = addmodel.name;
//    if (!ishighlight) {
//        [self.cellBtn  setTintColor:UIColorFromRGB(0x8e8e8e)];
//        [self.cellBtn setTitleColor:UIColorFromRGB(0x8e8e8e) forState:UIControlStateNormal];
//    } else {
//        [self.cellBtn setTintColor:UIColorFromRGB(0x2d2d2d)];
//        [self.cellBtn setTitleColor:UIColorFromRGB(0x2d2d2d) forState:UIControlStateNormal];
//        
//    }
//    
//
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
