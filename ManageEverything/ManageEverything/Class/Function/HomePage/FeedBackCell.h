//
//  FeedBackCell.h
//  ManageEverything
//
//  Created by zz on 15/6/7.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SendImage) (NSMutableArray *array);

@interface FeedBackCell : UITableViewCell


@property (nonatomic ,copy) SendImage sendImage;
@property (nonatomic, strong) UILabel *labelTime;       //上传时间
@property (nonatomic, strong) UILabel *labelContent;    //上传内容
@property (nonatomic, strong) UIView *imageContentView; //照片显示界面
@property (nonatomic, strong) UILabel *status;          //处理状态

+ (CGFloat)HeightWithModel:(FeedBackCellModel *)model;

- (void)setCellWithModel:(FeedBackCellModel *)model;


@end
