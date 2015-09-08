//
//  AboutStoreInformatinoViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/23.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "AboutStoreInformatinoViewController.h"
#import "AboutStoreInformationCell.h"
#import "SexTableViewCell.h"
#import "ZHPickView.h"

//keyVBoard


@interface AboutStoreInformatinoViewController ()<UITableViewDelegate,UITableViewDataSource, AboutStoreInformationCellDelegate,ZHPickViewDelegate,UITextFieldDelegate> {
    
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    
    NSArray *_fLabelTexts;
    NSArray *_tLabelTexts;
    NSMutableArray *_trLabelTexts;
    
    UILabel *_fLabel;
    UILabel *_tLabel;
    
    UITextField *_fTextField;
    UITextField *_tTextField;
    UITextField *_trTextField;
    
    UITextField *textField1;
    
    ZHPickView *_pickerView;
    
    NSMutableArray *array2;
    NSMutableArray *array7;
    NSInteger index; // 记录
    
    BOOL _endEditing;
    
    UITableViewController *tableViewController;

}



- (void)initializeInterface;
- (void)initializeDataSource;
@end

@implementation AboutStoreInformatinoViewController

- (void)buttonClick:(AboutStoreInformationCell *)cell {

    NSIndexPath *indexpath = [_tableView indexPathForCell:cell];
    
}

- (void)initializeDataSource {
    
    _fLabelTexts = [NSArray array];
    _fLabelTexts = @[@[@"当前店名",@"当前店主",@"联系方式",@"主营业务",@"备    注"],@[@"以往店名",@"以往店主",@"联系方式",@"主营业务",@"备    注"],@[@"门市业主",@"",@"证件类型",@"证件号码",@"国    籍",@"户籍地",@"联系电话",@"门市地址",@""]];
    
    _tLabelTexts = [NSArray array];
    _tLabelTexts = @[@[@"",@"",@"",@"",@"RT，UITableview delegate中貌似只可以设置row"],@[@"",@"",@"",@"",@""],@[@"",@"",@"",@"",@"",@"",@"",@"",@""]];

    //配置pickerView数据源
    
    array2 = [[NSMutableArray alloc]initWithObjects:@"身份证",@"护照",nil];
    array7 = [[NSMutableArray alloc]initWithObjects:@"四川",@"成都",@"乐山",nil];
}

-(void)loadView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeInterface];
//    [self registerForKeyboardNotifications];
}


- (void)initializeInterface {
    
    
    _tableView = tableViewController.tableView;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//固定头部视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _fLabelTexts[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CELL";
    static NSString *cellID1 = @"CELL1";
    AboutStoreInformationCell *storeCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    SexTableViewCell *sexCell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    
    [self keyUp:indexPath];
    if (indexPath.section == 0 || indexPath.section == 1 ) {
        if (indexPath.row == 4) {
            
            storeCell = [[AboutStoreInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            storeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            storeCell.fLabel.text = _fLabelTexts[indexPath.section][indexPath.row];
//            storeCell.textField1.text = _tLabelTexts[indexPath.section][indexPath.row];
            storeCell.textView.hidden = NO;
//            storeCell.textView.delegate = self;
//            NSLog(@"x:%lf,y:%lf",storeCell.frame.origin.x,storeCell.frame.origin.y);
            return storeCell;
        }
        else {
            
            storeCell = [[AboutStoreInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            storeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            storeCell.fLabel.text = _fLabelTexts[indexPath.section][indexPath.row];
            storeCell.textField1.text = _tLabelTexts[indexPath.section][indexPath.row];
            storeCell.textField1.delegate = self;
            
//             NSLog(@"x:%lf,y:%lf",storeCell.frame.origin.x,storeCell.frame.origin.y);
            return storeCell;
        }
        
    }
    else  {
        if (indexPath.row == 1) {
            sexCell = [[SexTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            sexCell.selectionStyle = UITableViewCellSelectionStyleNone;
           
//            NSLog(@"x:%lf,y:%lf",sexCell.frame.origin.x,sexCell.frame.origin.y);
            
            return sexCell;
            
            
        }
        //显示（点击选择）
        else if (indexPath.row == 2 || indexPath.row == 7) {
            
//            NSLog(@"x:%lf,y:%lf",storeCell.frame.origin.x,storeCell.frame.origin.y);
            
            storeCell = [[AboutStoreInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            storeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [storeCell setBlock:^(AboutStoreInformationCell *cell) {
                NSIndexPath *i = [tableView indexPathForCell:cell];
//                NSLog(@"%@",i);
                index = i.row;
                cell.textField1.tag = index;
                if (i.row == 2) {
                    
                    [self displayDataPicker:array2];

                }
                else if (i.row == 7){
                    
                    [self displayDataPicker:array7];

                }
            }];
            storeCell.delegate = self;
            storeCell.fLabel.text = _fLabelTexts[indexPath.section][indexPath.row];
            storeCell.textField1.text = _tLabelTexts[indexPath.section][indexPath.row];
            storeCell.textField1.delegate = self;
            //关闭textFiled1 与用户之间交互
            storeCell.textField1.enabled = NO;
//            storeCell.textField1.hidden = YES;
            storeCell.textField1.placeholder = @"";
            storeCell.chooseBtn.hidden = NO;
            return storeCell;
        }
        
        else {
            
            storeCell = [[AboutStoreInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            storeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            storeCell.fLabel.text = _fLabelTexts[indexPath.section][indexPath.row];
            storeCell.textField1.text = _tLabelTexts[indexPath.section][indexPath.row];
            storeCell.textField1.delegate = self;
            
//            NSLog(@"x:%lf,y:%lf",storeCell.frame.origin.x,storeCell.frame.origin.y);
            
            return storeCell;
        }
        
        
        
    }
    
   
    
}

// pcikerView初始化
- (void)displayDataPicker:(NSMutableArray *)data {
    
    _pickerView = [[ZHPickView alloc]initPickviewWithArray:data isHaveNavControler:NO];
    _pickerView.frame = CGRectMake(0, ScreenHeight - 300 + 64, ScreenWidth, 300);
    _pickerView.delegate = self;
    [_pickerView show];
}

//pickerView 滚动监听

#pragma mark - <>

- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(id)resultString {
    
    NSLog(@"resultString:%@",resultString);
    if (index == 2) {
        textField1 = (UITextField *)[self.view viewWithTag:index];
        textField1.text = resultString;
    }
    else {
        textField1 = (UITextField *)[self.view viewWithTag:index];
        textField1.text = resultString;
    }
}

//设置组名
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    if (section == 0) {
////        return @"当前店铺信息";
//        return @"";
//    }
//    
//    if (section == 1) {
////        return @"以往店铺信息";
//        return @"";
//    }
//    else {
////        return @"门市信息";
//        return @"";
//    }
//}

-(void) keyUp:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
   
    
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, ScreenWidth)];
    view.backgroundColor = [UIColor colorWithRed:0.929f green:0.945f blue:0.957f alpha:1.00f];
    
    if (section == 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, ScreenWidth * 0.3 +10, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.text =  @"当前店铺信息";
        label.numberOfLines = 1;
        [view addSubview:label];
    }
    
    else if (section == 1) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, ScreenWidth * 0.3 +10, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.text =  @"以往店铺信息";
        label.numberOfLines = 1;
        [view addSubview:label];
        
    }
    else if(section == 2) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, ScreenWidth * 0.3 +10, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.text =   @"门市信息";
        label.numberOfLines = 1;
        [view addSubview:label];
       
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        if (indexPath.row == 4) {
            return 80;
        }
    }
    return 44;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self.view];
//    
//    NSLog(@"touchPoint:%@",NSStringFromCGPoint(touchPoint));
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    
//}
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    [textField endEditing:YES];
//    return YES;
//}
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    
//    [_tableView setContentOffset:CGPointMake(0, 216) animated:YES];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
//    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.view endEditing:YES];
    return YES;
}

// 注册监听键盘通知

- (void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)deleteKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}

- (void) keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
//    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
//    _endEditing = YES;
//    //   textField.contentInset = UIEdgeInsetsMake(0, 0,keyboardSize.height, 0);
////    _tableView.contentOffset = CGPointMake(0, keyboardSize.height/2 - 30);
//    _tableView.contentOffset = CGPointMake(0, keyboardSize.height);
    // 动画的持续时间
    double duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboarddF = [info[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
   [UIView animateWithDuration:duration animations:^{
//       
//       if (keyboarddF.origin.y > _tableView.frame.size.height) {
//
//       }
   }];
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    // keyboardWasShown = NO;
    _endEditing = NO;
    _tableView.contentOffset = CGPointZero;
    
    
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
