//
//  OpenTableViewCell.h
//  LuZhouTong
//
//  Created by dqdeng on 15/1/30.
//  Copyright (c) 2015年 choice. All rights reserved.
//

#import "RootTableViewCell.h"

@class SectionObj;
typedef enum : NSUInteger {
    typeImageA = 0 , //市区路况
    typeImageB = 1
} typeImage;

typedef void(^titleStr)(NSString *title);
@interface OpenTableViewCell : RootTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;
@property (nonatomic,retain) NSMutableArray *buttonList;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *vLeftImage;
@property (nonatomic,assign) int status; //类型
@property (nonatomic,assign) BOOL ishighlight;
@property (nonatomic,assign) typeImage type;
@property (nonatomic,copy) titleStr block;

@property (nonatomic,retain)id addmodel;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UILabel *mNameLabel;

- (void)setTitles:(NSArray *)titles dataName:(NSString *)dataName;
- (void)settypeImageAtitle:(NSString *)title;
- (void)CEL_referesh;
- (void)isHightLight:(UIButton *)button YESorNo:(BOOL)boool;

@end
