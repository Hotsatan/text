//
//  SectionViewCell.m
//  LuZhouTong
//
//  Created by dqdeng on 15/1/30.
//  Copyright (c) 2015年 choice. All rights reserved.
//

#import "SectionViewCell.h"



@implementation SectionViewCell


- (UIImage *)comitImage {
    
    UIImage * image = [UIImage imageNamed:@"car_sc_item_type"];
    NSData * tempData;
    if (UIImagePNGRepresentation(image)) {
        tempData = UIImagePNGRepresentation(image);
        NSLog(@"%@",tempData);
    }
    else{
        tempData = UIImageJPEGRepresentation(image, 1);
    }
    CIImage * iImg = [CIImage imageWithData:tempData];
    UIImage * tImg = [UIImage imageWithCIImage:iImg scale:1 orientation:UIImageOrientationRight];
    return tImg;
}

+ (instancetype)sectionViewSection:(NSInteger)section useBlock:(BtnBlock)block
{

    SectionViewCell *view = [[[NSBundle mainBundle] loadNibNamed:@"SectionViewCell" owner:nil options:nil] firstObject];
    view.bounds = CGRectMake(0, 0, ScreenWidth, 50);
    
    view.btnBlock = block;
    view.section = section;
//    view.botemImage.backgroundColor = UIColorFromRGB(0xf1f1f1);
    return view ;
}

- (void)setModel:(SectionData *)model {
    
    _sectionLabel.text = model.name;
    _tyepSectionLable.text = model.typeName;
    _scalImage.image = model.isShow ? [self comitImage] : [UIImage imageNamed:@"car_sc_item_type"];
    _sclImage_Height_Constraint.constant = model.isShow ? 14 : 24;
    _sclImage_width_Constraint.constant = model.isShow ? 22 : 14;
}

- (IBAction)buttonPressd:(id)sender {
    self.btnBlock(self.section);
}


@end
