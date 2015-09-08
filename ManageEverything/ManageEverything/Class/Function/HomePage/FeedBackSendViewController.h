//
//  FeedBackSendViewController.h
//  ManageEverything
//
//  Created by zz on 15/6/7.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshBlock)(void); //不传值的简单 回调

typedef void(^RefreshBlock2)(NSDictionary *dict); //需要这个界面的数据加载到上个界面


@interface FeedBackSendViewController : UIViewController


@property (nonatomic,retain) NSString *category_id;

-(void)hideLoadingActivityView;
- (void)hideLoadingActivityViewText:(NSString *)text;


@property (nonatomic,copy) RefreshBlock reshBlock;
@property (nonatomic,copy) RefreshBlock2 reshBlock2;

@end
