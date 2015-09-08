//
//  LinePhoTableViewCell.m
//  LuZhouTong
//
//  Created by dqdeng on 15/1/30.
//  Copyright (c) 2015年 choice. All rights reserved.
//

#import "LinePhoTableViewCell.h"

#define EmptyTitel  @"如该路况有图片,可以上传图片."
#define NemPiyTitle @"最多可以添加五张照片."

@implementation LinePhoTableViewCell

- (void)awakeFromNib {
    // Initialization code
  
  //  self.heightConstraint.constant
}

+ (instancetype)linePhoTableView {

    LinePhoTableViewCell *view = [[[NSBundle mainBundle] loadNibNamed:@"LinePhoTableViewCell" owner:nil options:nil] firstObject];
    view.textView.delegate = view;
    if (ScreenWidth  > 320) {
       view->_height = 73.5;
        
    } else {
        view->_height = 60;

    }
   
    view.heightConstraint.constant = view-> _height;
    UIButton *imageView = (UIButton *)[view viewWithTag:100];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.addBtn.bounds = CGRectMake(0, 0,view->_height , view->_height);
        view.addBtn.center = imageView.center;

    });
       return view;
}


- (void)setDataSource:(NSMutableArray *)dataSource {
   
   
}
- (void)drawRect:(CGRect)rect {
    
//     UIButton *imageView = (UIButton *)[self viewWithTag:100];
//     NSLog(@"%@",NSStringFromCGRect(imageView.bounds));
//    
//    self.addBtn.bounds = imageView.bounds;
    
  //  NSLog(@"%@",NSStringFromCGRect(rect));
    
    if (CGRectGetHeight(rect) == 269) {
        if (_count == 4) {
            [self addPhotoCenter:_count + 100];
        }

    } else {
        if (_count > 0) {
             [self addPhotoCenter:_count + 100];
        }
    }
    
  
}
- (void)upImageList {

    for (int i = 0; i < 5; i ++) {
        
        UIButton *imageView = (UIButton *)[self viewWithTag:100 + i];
       
        //  imageView.image = data[i];
     //   [imageView setBackgroundImage:data[i] forState:UIControlStateNormal];
        imageView.hidden = YES;
    }
    
}
- (void)lineDatas:(NSMutableArray *)data {
    
    int tag = 0;
    _count = [data count];
    for (int i = 0; i < [data count]; i ++) {
        UIButton *imageView = (UIButton *)[self viewWithTag:100 + i];
      //  imageView.image = data[i];
        imageView.imageView.contentMode = UIViewContentModeScaleAspectFill;
     //   [imageView setBackgroundImage:data[i] forState:UIControlStateNormal];
        [imageView setImage:data[i] forState:UIControlStateNormal];
        imageView.hidden = NO;
        tag = i;
    }
    
    if (_count == 0) {
        [self addPhotoCenter:tag+100];
    } else {
     [self addPhotoCenter:tag+1 + 100];
    }
    
}
- (void)addPhotoCenter:(NSInteger)tag {
    
    self.promptTitle.text = EmptyTitel;
    if (_count != 0 ) {
        self.promptTitle.hidden = YES;
    } else {
        self.promptTitle.hidden = NO;
    }
    if (_count == 5) {
        self.promptTitle.hidden = NO;
        self.promptTitle.text = NemPiyTitle;
    }
   // NSLog(@"image tag == %d",tag);
    UIImageView *imageView = (UIImageView *)[self viewWithTag:tag];
   // self.addBtn.bounds = CGRectMake(0, 0, CGRectGetWidth(imageView.bounds), CGRectGetHeight(imageView.bounds));
    //self.addBtn.backgroundColor = [UIColor orangeColor];
  //  NSLog(@"%@",NSStringFromCGRect(self.addBtn.frame));
    //[self layoutIfNeeded];
    self.addBtn.translatesAutoresizingMaskIntoConstraints = YES;
    self.promptTitle.translatesAutoresizingMaskIntoConstraints = YES;
    self.addBtn.bounds = imageView.bounds;
    self.addBtn.center = imageView.center;
    self.addBtn.hidden = NO;
  //  NSLog(@"%@",NSStringFromCGRect(self.addBtn.frame));
    self.promptTitle.center = CGPointMake(CGRectGetMaxX(self.addBtn.frame)+ CGRectGetWidth(self.promptTitle.bounds)/2 + 5, CGRectGetMidY(self.addBtn.frame));

}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeLabel.hidden = NO;
        [self.delegate textViewBegin:NO];
    }else{
        [self.delegate textViewBegin:YES];
        self.placeLabel.hidden = YES;
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSString * toBeString = [_textView.text stringByReplacingCharactersInRange:range withString:text]; //得到输入框的内容
    //   [Common convertToInt:toBeString];
    
    if ([Common textLength:toBeString] <= 40) {
        //[DisplayView disPlayShowWithTitle:@"只能输入12位"]
        return YES;
    }else {
         [self.textView endEditing:YES];
//        [DisplayView disPlayShowWithTitle:@"路况内容过长"];
        return NO;
    }

}


- (void)textViewDidEndEditing:(UITextView *)textView {

    self.textView.text = textView.text;
}


@end
