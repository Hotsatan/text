//
//  HomeMessageDetailViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/6.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "HomeMessageDetailViewController.h"
#import "ZHPickView.h"

@interface HomeMessageDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,ZHPickViewDelegate,UITextFieldDelegate> {
    
    NSArray *_cellData;
    HomeMessageDetailModel *homeDetail;
    
//    UIPickerView *_pickerView;
    ZHPickView *_pickerView;
    
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *array3;
    NSMutableArray *array4;
    NSMutableArray *array5;
    NSMutableArray *array6;
    NSMutableArray *array7;
    NSMutableArray *array8;
    NSMutableArray *array9;
    NSMutableArray *dataArray;
    
    NSInteger index;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) IBOutlet UITableViewCell *HSOCell;

@property (strong, nonatomic) IBOutlet UITableViewCell *HMCell;

@property (strong, nonatomic) IBOutlet UITableViewCell *HRCell;
//

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

@property (weak, nonatomic) IBOutlet UILabel *identityCard;
@property (weak, nonatomic) IBOutlet UITextField *certificateNumber;

@property (weak, nonatomic) IBOutlet UITextField *nationality;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *familyRegister;

//--------------------------

@property (weak, nonatomic) IBOutlet UILabel *architectureStyle;
@property (weak, nonatomic) IBOutlet UILabel *architectureProperty;
@property (weak, nonatomic) IBOutlet UITextField *architectureDecade;


@property (weak, nonatomic) IBOutlet UITextField *usefulLife;

@property (weak, nonatomic) IBOutlet UILabel *ownershipType;
@property (weak, nonatomic) IBOutlet UILabel *locality;
@property (weak, nonatomic) IBOutlet UITextField *localityDetail;

@property (weak, nonatomic) IBOutlet UITextField *localPoliceStation;


@property (weak, nonatomic) IBOutlet UIButton *nonrent;
@property (weak, nonatomic) IBOutlet UIButton *rent;

//-------------------------

@property (weak, nonatomic) IBOutlet UILabel *lodgingStyle;

@property (weak, nonatomic) IBOutlet UITextField *lodgingNumber;

@property (weak, nonatomic) IBOutlet UITextField *lodgingArea;


@property (weak, nonatomic) IBOutlet UILabel *lodgingPurpose;
@property (weak, nonatomic) IBOutlet UITextField *lodgingNumberOfPeople;


@property (weak, nonatomic) IBOutlet UILabel *lodgingOfBeginTime;
@property (weak, nonatomic) IBOutlet UILabel *lodgingOfEndTime;
@property (weak, nonatomic) IBOutlet UIButton *rentToDo;


@property (weak, nonatomic) IBOutlet UIButton *egister;
@property (weak, nonatomic) IBOutlet UIButton *nonRegister;

@property (weak, nonatomic) IBOutlet UIButton *contract;

@property (weak, nonatomic) IBOutlet UIButton *nonContract;

//
- (void)initializeData;
@end

@implementation HomeMessageDetailViewController

- (void)awakeFromNib {

    [super awakeFromNib];

}

- (void)dealloc
{
//    [_pickerView removeFromSuperview];
    NSLog(@"home message detail view controller has been dealloced.");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self initializeData];
    //
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"房屋基本信息";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    UIImage *image = [UIImage imageNamed:@"return"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //   [leftBtn setAction:@selector(pushBack)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //
    
    _cellData = @[@[_HSOCell],@[_HMCell],@[_HRCell]];
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:0.933f green:0.933f blue:0.933f alpha:1.00f];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
    
    
//    _pickerView = [[ZHPickView alloc] initPickviewWithArray:array1 isHaveNavControler:YES];
//    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight  - 200, ScreenWidth, 200)];
//    _pickerView.backgroundColor = [UIColor colorWithRed:0.933f green:0.933f blue:0.933f alpha:1.00f];
//    _pickerView.delegate = self;
//    [self.view addSubview:_pickerView];
//    //    [self.tableView addSubview:_pickerView];
//    [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
////    [self.tableView bringSubviewToFront:_pickerView];
//    _pickerView.hidden = YES;
//    [_pickerView show];
    array1 = [[NSMutableArray alloc]initWithObjects:@"身份证",@"护照", nil];
    array2 = [[NSMutableArray alloc]initWithObjects:@"居住建筑",@"写字楼", nil];
    array3 = [[NSMutableArray alloc]initWithObjects:@"普通住宅",@"高档别墅", nil];
    array4 = [[NSMutableArray alloc]initWithObjects:@"iphone1",@"iphone2", nil];
    array5 = [[NSMutableArray alloc]initWithObjects:@"iphone3",@"iphone4", nil];
    array6 = [[NSMutableArray alloc]initWithObjects:@"iphone5",@"iphone6", nil];
    array7 = [[NSMutableArray alloc]initWithObjects:@"iphone7",@"iphone8", nil];
    array8 = [[NSMutableArray alloc]initWithObjects:@"iphone9",@"iphone10", nil];
    array9 = [[NSMutableArray alloc]initWithObjects:@"iphone11",@"iphone12",@"iphone12Plus",@"iphone13",@"iphone13Plus", nil];
    dataArray = [[NSMutableArray alloc]initWithObjects:array1,array2,array3,array4,array5,array6,array7,array8,array9, nil];
    
}
- (IBAction)btnPressed:(UIButton *)sender {
    
    NSInteger i = sender.tag - 10000;
    if (i == 8) {
        _manBtn.selected = YES;
        _womanBtn.selected = NO;
    }
    else if (i == 9) {
        _manBtn.selected = NO;
        _womanBtn.selected = YES;
    }
    else if (i == 10) {
        _nonrent.selected = YES;
        _rent.selected = NO;
        
    }
    else if (i == 11) {
        _nonrent.selected = NO;
        _rent.selected = YES;
        
    }
    else if (i == 12) {
        _egister.selected = YES;
        _nonRegister.selected = NO;
    }
    else if (i == 13) {
        _egister.selected = NO;
        _nonRegister.selected = YES;
    }
    else if (i == 14) {
        _contract.selected = YES;
        _nonContract.selected = NO;
    }
    else if (i == 15) {
        _contract.selected = NO;
        _nonContract.selected = YES;
    }
}

//点击btn 弹出pickerView
- (IBAction)btnClick:(UIButton *)sender {
  
    
    NSInteger i = sender.tag - 10000;
    NSLog(@"%ld",i);
    index = i;
    if (i == 0) {
        [self displayDataPicker:array1];
    }
    else if (i == 1) {
        [self displayDataPicker:array2];
    }
    else if (i == 2) {
        [self displayDataPicker:array3];
    }
    else if (i == 3) {
        [self displayDataPicker:array4];
    }
    else if (i == 4) {
        [self displayDataPicker:array5];
    }
    else if (i == 5) {
        [self displayDataPicker:array6];
    }
    else if (i == 6) {
        [self displayDataPicker:array7];
    }
    else if (i == 7) {
     
        [self displayDataPicker:array8];
    }
    else if (i == 8) {
        
        [self displayDataPicker:array9];
    }
    
}

// pcikerView初始化
- (void)displayDataPicker:(NSMutableArray *)data {
    
    _pickerView = [[ZHPickView alloc]initPickviewWithArray:data isHaveNavControler:NO];
    _pickerView.frame = CGRectMake(0, ScreenHeight - 300 + 64, ScreenWidth, 300);
    _pickerView.delegate = self;
    [_pickerView show];
}

- (void)pushBack {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)initializeData {
    NSLog(@"%@",[Common getUserInfo]);
    [self showLoading];
    
    typeof(self) weakSelf = self;
    
    [NetWorkHandler getPeopleParams:@{@"people_id":[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]]} completionHandler:^(id content) {
        
        [self hideLoading];
        if (content) {
            homeDetail = [[HomeMessageDetailModel alloc] initWithDictionaryParams:content[@"data"]];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:homeDetail.admin_name forKey:@"admin_name"];
            [userDefaults synchronize];
            [weakSelf setData];
            NSLog(@".。。。。%@",content);
//            NSLog(@"%@",content[@"data"][@"district"]);
//            NSLog(@"%@",content[@"data"][@"search"]);
//            [_tableView reloadData];
            [weakSelf.tableView setHidden:NO];
            
        }
    }];

}

- (void)setData {
    
    _nameTextField.text = homeDetail.admin_name;
    _localityDetail.text = homeDetail.district;
    
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
        [self initializeData];
//    [self.view layoutIfNeeded];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [_pickerView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label =  [[UILabel alloc]initWithFrame:CGRectMake(8, 0,ScreenWidth,44)];
    
    if (section == 1) {
        label.text = @"     房屋信息";
    }
    else if(section == 2) {
        label.text = @"     出租信息";
    }
    else {
        label.text = @"     房主个人信息";
    }
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _cellData.count;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
//    view.backgroundColor = [UIColor colorWithRed:0.933f green:0.933f blue:0.933f alpha:1.00f];
//    return view;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_cellData[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = _cellData[indexPath.section][indexPath.row];
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 308;
    }
    if (indexPath.section == 1) {
        return 396;
    }
    else {
        return 397;
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    if (section == 0) {
//        return @"房主个人信息";
//    }
//    if (section == 1) {
//        return @"房屋信息";
//    }
//    else  {
//        return @"出租信息";
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    _pickerView.hidden = YES;
}


#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource

//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    
//    return 1;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    
//    return [array1 count];
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    
//    return [array1 objectAtIndex:row];
//}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
//    NSInteger index = [_pickerView selectedRowInComponent:0];
//    _identityCard.text = [array1 objectAtIndex:index];
//    _pickerView.hidden = NO;
}

//滚动监听
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _identityCard.text = [array1 objectAtIndex:row];
    _architectureStyle.text = [array1 objectAtIndex:row];
    _pickerView.hidden = NO;
//    if (component == 0) {
//        <#statements#>
//    }
}


#pragma mark - <>

- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(id)resultString {
    
    if (index == 0) {
        _identityCard.text = (NSString *)resultString;
    }
    else if (index == 1) {
        _architectureStyle.text = (NSString *)resultString;
    }
    else if (index == 2) {
        _architectureProperty.text = (NSString *)resultString;
    }
    else if (index == 3) {
        _ownershipType.text = (NSString *)resultString;
    }
    else if (index == 4) {
        _locality.text = (NSString *)resultString;
    }
    else if (index == 5) {
         _lodgingStyle.text = (NSString *)resultString;
    }
    else if (index == 6) {
        
        _lodgingPurpose.text = (NSString *)resultString;
    }
    else if (index == 7) {
         _lodgingOfBeginTime.text = (NSString *)resultString;
    }
    else if (index == 8) {
        _lodgingOfEndTime.text = (NSString *)resultString;

    }
   
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
