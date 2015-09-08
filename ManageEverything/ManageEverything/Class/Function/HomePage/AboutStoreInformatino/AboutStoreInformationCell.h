//
//  AboutStoreInformationCell.h
//  ManageEverything
//
//  Created by zz on 15/6/23.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "RootTableViewCell.h"
@class AboutStoreInformationCell;

@protocol AboutStoreInformationCellDelegate <NSObject>

- (void)buttonClick:(AboutStoreInformationCell *)cell;

@end

@interface AboutStoreInformationCell : RootTableViewCell


@property (nonatomic, assign) id<AboutStoreInformationCellDelegate> delegate;

@property (nonatomic, copy) void (^block)(AboutStoreInformationCell *cell);

@property (nonatomic, strong) UILabel *fLabel;
@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) UITextView *textView;
- (void)setDataSource:(NSDictionary *)dict;

@end
