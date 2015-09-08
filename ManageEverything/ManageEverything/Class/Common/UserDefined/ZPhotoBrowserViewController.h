//
//  ZPhotoBrowserViewController.h
//  ManageEverything
//
//  Created by zz on 15/6/16.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "BaseViewController.h"

@interface ZPhotoBrowserViewController : BaseViewController


@property (nonatomic,copy)dispatch_block_t blockPage;


+ (instancetype)photoBrowserDatas:(NSArray *)datas;
+ (instancetype)photoBrowserDatas:(NSArray *)datas UseingBlock:(dispatch_block_t)block ;

- (void)initImages:(NSArray *)datas andPage:(NSInteger)page;
- (void)tagWithPage:(NSInteger)page;


@end
