//
//  NotificationAndAnnouncementTableViewCell.m
//  ManageEverything
//
//  Created by zz on 15/6/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "NotificationAndAnnouncementTableViewCell.h"

@implementation NotificationAndAnnouncementTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, ScreenWidth - 16, 30)];
        //        self.labelContent.backgroundColor = [UIColor blueColor];
        self.labelContent.font = [UIFont fontWithName:@"Arial" size:12];
        self.labelContent.lineBreakMode = NSLineBreakByCharWrapping;
        [self.labelContent setNumberOfLines:1];
        //        self.labelContent.layer.borderColor = [UIColor blackColor].CGColor;
        //        self.labelContent.layer.borderWidth = 1;
        self.labelContent.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.labelContent];
        
        
        self.labelTime = [[UILabel alloc] initWithFrame:CGRectMake(0, self.labelContent.bounds.size.height + 8, ScreenWidth - 8, 10)];
        self.labelTime.textAlignment = NSTextAlignmentRight;
        self.labelTime.textColor = [UIColor grayColor];
        self.labelTime.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.labelTime];
        
        
    }
    return self;
}

-(void)setCellWithModel:(GuideOfServiceTableViewCellModel *)model {
    
    if (!model) {
        return;
    }
    
    self.labelContent.text = model.title;
    
    
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    fomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.update_time doubleValue]];
    self.labelTime.text = [fomatter stringFromDate:date];
    
}


@end
