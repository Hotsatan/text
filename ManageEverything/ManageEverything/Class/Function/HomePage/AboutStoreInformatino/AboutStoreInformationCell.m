//
//  AboutStoreInformationCell.m
//  ManageEverything
//
//  Created by zz on 15/6/23.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "AboutStoreInformationCell.h"

@interface AboutStoreInformationCell () {

}

@end

@implementation AboutStoreInformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *fLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 14, ScreenWidth * 0.2 +10, 20)];
        fLabel.textColor = [UIColor blackColor];
        fLabel.font = [UIFont systemFontOfSize:14];
        self.fLabel = fLabel;
//        fLabel = self.fLabel;
        [self addSubview:fLabel];
        
        UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fLabel.frame) + 10, 14, ScreenWidth - CGRectGetMaxX(fLabel.frame) - 70, 20)];
        textField1.textColor = [UIColor grayColor];
        textField1.font = [UIFont systemFontOfSize:14];
        textField1.placeholder = @"请输入";
        self.textField1 = textField1;
        [self addSubview:textField1];
        
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fLabel.frame) + 10, 14, ScreenWidth - CGRectGetMaxX(fLabel.frame) - 30, 52)];
        _textView.font = [UIFont systemFontOfSize:14];
        self.textView.text = @"沪指的走势可谓深V反弹，有惊无险，终结“端午劫”。早盘沪指高开低走，最低探底4264.77点";
        _textView.hidden = YES;
        [self addSubview:_textView];
        
        _chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake( ScreenWidth - ScreenWidth * 0.3 - 18 - 40 + (ScreenWidth * 0.2 + 10 + 8) , 14 , 60, 20)];
        [_chooseBtn setTitle:@"(点击选择)" forState:UIControlStateNormal];
        _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_chooseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_chooseBtn addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        _chooseBtn.hidden = YES;
        [self addSubview:_chooseBtn];
    }
    return self;
}

- (void)buttonPressed {

    //block
    
    self.block(self);
    
    // delegate
//    if ([_delegate respondsToSelector:@selector(buttonClick:)]) {
//        [_delegate buttonClick:self];
//    }
    
}


-(void)setDataSource:(NSDictionary *)dict {
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
