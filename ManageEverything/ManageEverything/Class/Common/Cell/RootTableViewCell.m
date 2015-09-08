//
//  RootTableViewCell.m
//  ManageEverything
//
//  Created by zz on 15/6/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "RootTableViewCell.h"

@implementation RootTableViewCell


+ (UINib *)nib {
    
    NSString *nibName = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"%@",nibName);
    return [UINib nibWithNibName:nibName bundle:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
