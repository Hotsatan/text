//
//  CarsMessageViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/11.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "CarsMessageViewController.h"

@interface CarsMessageViewController () <UITextViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>{
    
    UIScrollView *_scrollView;
    
    NSMutableArray *_fLabelTexts;
    NSMutableArray *_tLabelTexts;
    NSMutableArray *_trLabelTexts;
    
    UILabel *_fLabel;
    UILabel *_tLabel;
    
    UITextField *_fTextField;
    UITextField *_tTextField;
    UITextField *_trTextField;
    
}

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation CarsMessageViewController

- (void)initializeDataSource {
    
    _fLabelTexts = [NSMutableArray arrayWithObjects:@"车牌号码",@"车辆类型",@"使用性质",@"车辆使用人",@"车辆所有人",@"所有人身份证号",@"购车时间",@"品牌型号",@"车体颜色",@"是否买保险",@"保险时间",@"保险种类",@"保险单号",@"保险公司", nil];
    
    _tLabelTexts = [NSMutableArray arrayWithObjects:@"南K12001",@"小型汽车",@"身份证",@"张三",@"李四",@"510402198903046894",@"中国",@"奥迪RS5",@"红色",@"",@"2005-01-01",@"强制保险",@"8393293024820",@"平安保险公司", nil];
    _trLabelTexts = [NSMutableArray arrayWithObjects:@"(点击选择)",@"(点击选择)", nil];
    
}

//-(void)loadView
//{
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.view = scrollView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeInterface];
}

- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor colorWithRed:0.929f green:0.929f blue:0.929f alpha:1.00f];
    
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    //监听点击 回收键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textResignTap)];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _scrollView.contentSize = CGSizeMake(ScreenWidth, 44 * _fLabelTexts.count + 65);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.tag = 111;
    [self.view addSubview:_scrollView];
    [_scrollView addGestureRecognizer:tapGesture];
    
    for (int i = 0; i < _fLabelTexts.count; i ++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(8, 44 * i , ScreenWidth - 16, 1)];
        line.backgroundColor = [UIColor colorWithRed:0.871f green:0.871f blue:0.871f alpha:1.00f];
        [_scrollView addSubview:line];
        
        _fLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 14 + 44 *i, ScreenWidth * 0.3 +10, 20)];
//        _fLabel.layer.borderColor = [[UIColor blackColor]CGColor];
//        _fLabel.layer.borderWidth = 0.5;
        _fLabel.text = _fLabelTexts[i];
        _fLabel.font = [UIFont systemFontOfSize:14];
        _fLabel.textColor = [UIColor blackColor];
        _fLabel.numberOfLines = 1;
        [_scrollView addSubview:_fLabel];
    }
    
    for (int i = 0 ; i < _tLabelTexts.count; i ++) {
        
        if (i == 1) {
            
            _tTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth * 0.2 + 10 + 8, 14 + 44 * i , ScreenWidth - ScreenWidth * 0.3 - 18 - 40, 20)];
            _tTextField.text = _tLabelTexts[i];
            //            _tLabel.layer.borderColor = [[UIColor blackColor]CGColor];
            //            _tLabel.layer.borderWidth = 0.5;
            _tTextField.font = [UIFont systemFontOfSize:14];
            _tTextField.textColor = [UIColor grayColor];
            _tTextField.delegate = self;
            [_scrollView addSubview:_tTextField];
        }
        else if (i == 2) {
            
            _tTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth * 0.2 + 10 + 8, 14 + 44 * i , ScreenWidth - ScreenWidth * 0.3 - 18 - 40, 20)];
            _tTextField.text = _tLabelTexts[i];
            _tTextField.font = [UIFont systemFontOfSize:14];
            _tTextField.textColor = [UIColor grayColor];
            _tTextField.delegate = self;
            _tTextField.returnKeyType = UIReturnKeyNext;
            [_scrollView addSubview:_tTextField];
        }
        else if (i == 5) {
            _tTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth * 0.3 + 10 + 8, 14 + 44 * i , ScreenWidth - ScreenWidth * 0.3 - 18 - 40, 20)];
            _tTextField.text = _tLabelTexts[i];
//            _tLabel.layer.borderColor = [[UIColor blackColor]CGColor];
//            _tLabel.layer.borderWidth = 0.5;
            _tTextField.font = [UIFont systemFontOfSize:14];
            _tTextField.textColor = [UIColor grayColor];
            _tTextField.delegate = self;
//            _tTextField.numberOfLines = 1;
            [_scrollView addSubview:_tTextField];

        }
        else {
            _tTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth * 0.2 + 10 + 8, 14 + 44 * i , ScreenWidth - ScreenWidth * 0.3 - 18 - 40, 20)];
            _tTextField.text = _tLabelTexts[i];
//            _tLabel.layer.borderColor = [[UIColor blackColor]CGColor];
//            _tLabel.layer.borderWidth = 0.5;
            _tTextField.font = [UIFont systemFontOfSize:14];
            _tTextField.textColor = [UIColor grayColor];
            _tTextField.delegate = self;
//            _tTextField.numberOfLines = 1;
            [_scrollView addSubview:_tTextField];

        }
        
        //添加UIButton
        if (i == 1) {
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake( ScreenWidth - ScreenWidth * 0.3 - 18 - 40 + (ScreenWidth * 0.2 + 10 + 8) , 14 + 44 * i, 60, 20)];
            [btn setTitle:@"(点击选择)" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.tag = i;
            [_scrollView addSubview:btn];
        }
        else if (i == 2) {
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake( ScreenWidth - ScreenWidth * 0.3 - 18 - 40 + (ScreenWidth * 0.2 + 10 + 8) , 14 + 44 * i, 60, 20)];
            [btn setTitle:@"(点击选择)" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.tag = i;
            [_scrollView addSubview:btn];
        }
        else if (i == 9) {
            
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth * 0.2 + 10 + 8 + 10, 14 + 44 * i , 22, 22)];
            [btn1 setImage:[UIImage imageNamed:@"choose_no"] forState:UIControlStateNormal];
            [btn1 setImage:[UIImage imageNamed:@"choose_yes"] forState:UIControlStateSelected];
            
            [_scrollView addSubview:btn1];
            
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 15, 14 + 44 * i, 22, 22)];
            label1.text = @"否";
            label1.font = [UIFont systemFontOfSize:14];
            label1.textColor = [UIColor grayColor];
            [_scrollView addSubview:label1];
            
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 25, 14 + 44 * i , 22, 22)];
            [btn2 setImage:[UIImage imageNamed:@"choose_no"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"choose_yes"] forState:UIControlStateSelected];
            [_scrollView addSubview:btn2];
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame) + 15, 14 + 44 * i, 22, 22)];
            label2.text = @"是";
            label2.font = [UIFont systemFontOfSize:14];
            label2.textColor = [UIColor grayColor];
            [_scrollView addSubview:label2];
        }
        
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(8, 44 * _fLabelTexts.count  , ScreenWidth - 16, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.871f green:0.871f blue:0.871f alpha:1.00f];
    [_scrollView addSubview:line];
    

    
}

//响应点击 回收键盘
- (void)textResignTap {
    
    for (UITextField *textField in ((UIScrollView *)[self.view viewWithTag:111]).subviews) {
        [textField resignFirstResponder];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField becomeFirstResponder];
//    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    [[self.view viewWithTag:textField.tag +1] becomeFirstResponder];
//    if (textField.tag == 99) {
//        [((UIScrollView *)[self.view viewWithTag:500]) setContentOffset:CGPointMake(0, ((UIScrollView *)[self.view viewWithTag:500]).contentSize.height- mScreen.height+64) animated:YES];
//    }
//    
//    
//    return YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
