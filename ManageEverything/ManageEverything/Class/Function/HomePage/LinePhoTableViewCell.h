//
//  LinePhoTableViewCell.h
//  LuZhouTong
//
//  Created by dqdeng on 15/1/30.
//  Copyright (c) 2015年 choice. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol mTextViewDelegate <NSObject>

- (void)textViewBegin:(BOOL)Edit;

@end
@interface LinePhoTableViewCell : UIView <UITextViewDelegate> {

    NSInteger _count;
    float _height;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *promptTitle;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic,weak) id <mTextViewDelegate>delegate;
+ (instancetype)linePhoTableView;
- (void)lineDatas:(NSMutableArray *)data;
- (void)upImageList;

@end
