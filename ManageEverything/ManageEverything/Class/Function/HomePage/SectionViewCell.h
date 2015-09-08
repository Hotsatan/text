//
//  SectionViewCell.h
//  LuZhouTong
//
//  Created by dqdeng on 15/1/30.
//  Copyright (c) 2015年 choice. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SectionData;
typedef void(^BtnBlock)(NSInteger section);
@interface SectionViewCell : UIView
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *botemImage;
@property (weak, nonatomic) IBOutlet UIImageView *scalImage;
@property (weak, nonatomic) IBOutlet UILabel *tyepSectionLable;
@property (nonatomic,retain) SectionData *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sclImage_width_Constraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sclImage_Height_Constraint;

@property (nonatomic,copy)BtnBlock btnBlock;

@property (nonatomic,assign)NSInteger section;

+ (instancetype)sectionViewSection:(NSInteger)section useBlock:(BtnBlock)block;


@end
