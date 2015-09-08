//
//  AdvertisementTableViewCell.h
//  ManageEverything
//
//  Created by zz on 15/6/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "RootTableViewCell.h"

@interface AdvertisementTableViewCell : RootTableViewCell {
    
@public NSInteger _currentIndex;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,copy) NSMutableArray *dataSource;
@property (nonatomic,copy)void (^gesturePress)();

//@property (nonatomic,strong) NewsLiveListTop *newsLiveListTopModel;

- (void)setData:(NSMutableArray *)dataSource;

+ (instancetype)advertisementTableViewCellBlock:(void(^)())block;
@end
