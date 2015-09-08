//
//  FeedBackCell.m
//  ManageEverything
//
//  Created by zz on 15/6/7.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "FeedBackCell.h"



@interface FeedBackCell () {
    
    NSMutableArray *imageArray;
}

@end

@implementation FeedBackCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, ScreenWidth - 16, 40)];
        self.labelContent.font = [UIFont fontWithName:@"Arial" size:16];
        self.labelContent.lineBreakMode = NSLineBreakByCharWrapping;
        [self.labelContent setNumberOfLines:2];
        self.labelContent.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.labelContent];
        
        self.imageContentView = [[UIView alloc]init];
        self.imageContentView.backgroundColor = [UIColor clearColor];
        self.imageContentView.hidden = NO;
        self.imageContentView.userInteractionEnabled = YES;
//        self.imageContentView.frame = CGRectMake(8, 16 + CGRectGetHeight(self.labelContent.bounds), 55, 55);
        [self addSubview:_imageContentView];

        
        self.labelTime = [[UILabel alloc] init];
        self.labelTime.textAlignment = NSTextAlignmentRight;
        self.labelTime.textColor = [UIColor grayColor];
        self.labelTime.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.labelTime];
    }
    return self;
}

+ (CGFloat)HeightWithModel:(FeedBackCellModel * )model {

    CGFloat height = 0;
    
//    if ([model.picture_list isKindOfClass:[NSArray class]]) {
//        NSUInteger height = [model.picture_list count];
//        return [FeedBackCell HeightWithModel:height];
//    }
//    else {
//        NSInteger height = [(NSNumber *)model.picture_list integerValue];;
//        return [FeedBackCell HeightWithModel:height];
//    }

//    NSLog(@"picture_list%@",[model.picture_list[@"path"] integerValue]);
//    
    NSInteger pictureNum = [model.picture_list count];
    
    
    if (pictureNum == 0) {
        height  += 75;
    }
    else if (pictureNum <= 3) {
        height += 150;
    }
    else {
        height += 225;
    }

    return height;
}

- (void)setCellWithModel:(FeedBackCellModel *)model {
    imageArray = [[NSMutableArray alloc] init];
    if (!model) {
        return;
    }
    
    CGFloat cellHeight = [FeedBackCell HeightWithModel:model];
//    if ([model.picture_list isKindOfClass:[NSArray class]]) {
//        NSUInteger height = [model.picture_list count];
//        cellHeight =  [FeedBackCell HeightWithModel:height];
//    }
//    else {
//        NSInteger height = [(NSNumber *)model.picture_list integerValue];;
//         cellHeight =  [FeedBackCell HeightWithModel:height];
//    }

//    CGFloat cellHeight = [FeedBackCell HeightWithModel:[(NSNumber *)model.picture_list integerValue]];
    
    self.labelContent.text = model.content;
    
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    fomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.addtime doubleValue]];
    self.labelTime.text = [fomatter stringFromDate:date];
    
    
    self.imageContentView.frame = CGRectMake(5 , CGRectGetHeight(self.labelContent.frame)+ 8 , ScreenWidth - 55, 55) ;
    
    for (UIView *view in _imageContentView.subviews) {
        [view removeFromSuperview];
    }
    if ([model.picture_list isKindOfClass:[NSArray class]]) {
        for (int i = 0; i < [model.picture_list count]; i++) {
            
            
            UIImageView *imagView = [[UIImageView alloc]init];
            imagView.userInteractionEnabled = YES;
            imagView.frame = CGRectMake(5 + 70 * (i % 3) , 0 + 75* (i / 3), 65, 65);
            imagView.backgroundColor = [UIColor clearColor];
            imagView.clipsToBounds = YES;
            [_imageContentView addSubview:imagView];
            
            NSString *url = [NSString stringWithFormat:@"http://gdk.pw/%@",model.picture_list[i][@"path"]];
            [imageArray addObject:url];
            
            [imagView setImageWithURL:[NSURL URLWithString:url]];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
            [imagView addGestureRecognizer:tapGesture];
    
        }

    }
    //时间
    self.labelTime.frame = CGRectMake(0, cellHeight - 40, ScreenWidth - 8, 30);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//监听imageView点击
- (void)tapGesture{
    
    NSLog(@"12345");
    NSLog(@"image array = %@",imageArray);
//    for (int i = 0; i < array.count; i ++) {
//
//    }
    
    if (_sendImage) {
        _sendImage(imageArray);
    }
}
@end
