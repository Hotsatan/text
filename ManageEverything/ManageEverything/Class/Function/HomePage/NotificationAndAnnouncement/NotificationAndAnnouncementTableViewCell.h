//
//  NotificationAndAnnouncementTableViewCell.h
//  ManageEverything
//
//  Created by zz on 15/6/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "RootTableViewCell.h"

@interface NotificationAndAnnouncementTableViewCell : RootTableViewCell

@property (nonatomic, strong) UILabel *labelTime;       //上传时间
@property (nonatomic, strong) UILabel *labelContent;    //上传内容
@property (nonatomic, strong) UIView *imageContentView; //照片显示界面
@property (nonatomic, strong) UILabel *status;          //处理状态
@property (nonatomic, strong) NSString *serviceID;
+ (CGFloat)HeightWithModel:(NotificationAndAnnouncementModel *)model;


- (void)setCellWithModel:(NotificationAndAnnouncementModel *)model;

@end
