//
//  DQPhotoBrowser.h
//  AtuTableCellHight
//
//  Created by dqdeng on 15/1/29.
//  Copyright (c) 2015年 dqdeng. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "BaseViewController.h"
//UIViewController
@interface DQPhotoBrowser : BaseViewController

@property (nonatomic,copy)dispatch_block_t blockPage;

+ (instancetype)nibPhotoBrowser;
+ (instancetype)nibPhotoBrowserDatas:(NSArray *)datas;
+ (instancetype)nibPhotoBrowserDatas:(NSArray *)datas UseingBlock:(dispatch_block_t)block ;

- (void)initImages:(NSArray *)datas andPage:(NSInteger)page;
- (void)tagWithPage:(NSInteger)page;

@end
