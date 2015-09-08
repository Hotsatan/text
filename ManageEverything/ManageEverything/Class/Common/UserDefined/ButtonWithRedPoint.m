//
//  ButtonWithRedPoint.m
//  MicroDynamic
//
//  Created by Daniel on 15/1/29.
//  Copyright (c) 2015年 Daniel. All rights reserved.
//

#import "ButtonWithRedPoint.h"

@implementation ButtonWithRedPoint

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    
    CGFloat redPointWidth = 8;
    _redPoint = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(rect) - redPointWidth / 2, 0, redPointWidth, redPointWidth)];
    _redPoint.backgroundColor = [UIColor redColor];
    _redPoint.layer.cornerRadius = redPointWidth / 2;
    _redPoint.clipsToBounds = YES;
    [_redPoint setHidden:YES];
    [self addSubview:_redPoint];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
