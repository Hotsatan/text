//
//  FeedBackSendViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/7.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "AppDelegate.h"

#import "IssueFeedBackViewController.h"

#import "FeedBackSendViewController.h"
#import "OpenTableViewCell.h"
#import "SectionObj.h"
#import "LinePhoTableViewCell.h"
//#import "DQPhotoBrowser.h"
#import "TakePictureView.h"
#import <AVFoundation/AVFoundation.h>
#import "SectionViewCell.h"
NSString *const opencellIdentffer = @"openCell";
NSString *const sectionCellFfer = @"sectionCell";

#define imagesList @[@"grea_item_v",@"yellow_item_v",@"red_item_v"]
#define button_tag 100



typedef void(^sectionStr)(NSString *title);



@interface FeedBackSendViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,mTextViewDelegate,UIAlertViewDelegate> {
    
    NSMutableArray *_dataSorce;
    //    LinePhoTableViewCell *_linePhoTableView;
    NSMutableArray *_imageList; //图片集
    // DQPhotoBrowser *photoBrowser;
    NSMutableArray *_cellList;
    
    NSArray *oooArray;
    
    NSArray *bbbArray;
    UIImage *constimage;
    UIImage *scalimage;
    int lineHeghit;
    int twoLineHeghit;
    BOOL _isEdit;
    
    LinePhoTableViewCell *_linePhoTableView;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy) sectionStr block;
@property (nonatomic,retain) NSMutableArray *buttonList;
@property (nonatomic,assign) int status;
@property (nonatomic,copy) NSString *status_summary;

@end

@implementation FeedBackSendViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"return"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //    [leftBtn setAction:@selector(pushBack)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    

    
    if (ScreenWidth == 375) {
        twoLineHeghit = 290;
        lineHeghit = 205;
    } else if(ScreenWidth > 320) {
        twoLineHeghit = 290;
        lineHeghit = 205;
    } else if (ScreenWidth  == 320) {
        twoLineHeghit = 269;
        lineHeghit = 190;
    }
    
       [self comitRightBtn];
//    self.titleLabel.text = self.title;
    [self.tableView registerNib:[OpenTableViewCell nib] forCellReuseIdentifier:opencellIdentffer];
    
    _imageList = [NSMutableArray array];
    _dataSorce = [NSMutableArray array];
    
    SectionObj *obj = [[SectionObj alloc] init];
    obj.titles = @[@"租客"];
    obj.selected = YES;
    
    SectionObj *obj2 = [[SectionObj alloc] init];
    obj2.titles = @[@"房东"];
    obj2.selected = NO;
    
    SectionData *data = [[SectionData alloc] init];
    data.array = [@[obj,obj2] mutableCopy];
    data.name = @"租客";
    data.typeName = @"用户类型";
    data.isShow = NO;
    //高速路况
    SectionObj *ooo1 = [[SectionObj alloc] init];
    ooo1.titles = @[@"高速畅通",@"",@""];
    ooo1.status = 0;
    SectionObj *ooo2 = [[SectionObj alloc] init];
    ooo2.titles = @[@"缓行拥堵",@"施工变道",@""];
    ooo2.status = 1;
    SectionObj *ooo3 = [[SectionObj alloc] init];
    ooo3.titles = @[@"高速事故",@"高速封闭",@"雨雪结冰"];
    ooo3.status = 2;
    
    //市区路况
    SectionObj *bbb1 = [[SectionObj alloc] init];
    bbb1.titles = @[@"畅通",@"",@""];
    bbb1.status = 0;
    SectionObj *bbb2 = [[SectionObj alloc] init];
    bbb2.titles = @[@"缓行",@"拥堵",@"事故"];
    bbb2.status = 1;
    SectionObj *bbb3 = [[SectionObj alloc] init];
    bbb3.titles = @[@"封道",@"管制",@""];
    bbb3.status = 2;
    
    oooArray = @[bbb1,bbb2,bbb3];
    
    bbbArray = @[ooo1,ooo2,ooo3];
    
    SectionData *data2 = [[SectionData alloc] init];
    data2.array = [oooArray mutableCopy];
    data2.name = @"畅通";
    data2.typeName = @"选择路况";
    data2.isShow = NO;
    
    [_dataSorce addObject:data];
//    [_dataSorce addObject:data2];
    _isEdit = YES;
    self.status_summary = ooo1.titles[0];
    self.status = 0;
    self.buttonList = [NSMutableArray array];
    _linePhoTableView = [LinePhoTableViewCell linePhoTableView];
    _linePhoTableView.bounds = CGRectMake(0, 0, ScreenWidth, lineHeghit);//269
    _linePhoTableView.delegate = self;
//    for (int i = 0; i < 5; i ++) {
//        
//        UIButton *button = (UIButton *)[ _linePhoTableView viewWithTag:100+i];
//        [button addTarget:self action:@selector(imageViewClicked:) forControlEvents:UIControlEventTouchUpInside];
//    }
    [_linePhoTableView.addBtn addTarget:self action:@selector(takePhoPress) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = _linePhoTableView;
//    _linePhoTableView.bgView.backgroundColor = UIColorFromRGB(0xf1f1f1);
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    self.view.backgroundColor = _linePhoTableView.backgroundColor;
    
//    self.tableView.backgroundColor = UIColorFromRGB(0xf1f1f1);
    self.tableView.tableFooterView = footerView;
}

- (void)textViewBegin:(BOOL)Edit {
    _isEdit = !Edit;
}

- (void)pushBack {

    [self.view endEditing:YES];
    if (_isEdit) {
            [self.navigationController popViewControllerAnimated:YES];
        
    }
    else {
         UIAlertView *alrtView = [[UIAlertView alloc]initWithTitle:nil message:@"确认放弃编辑？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alrtView show];
    }
    
}

//AlertView的取消按钮的事件
- (void)alertViewCancel:(UIAlertView *)alertView {
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    
}

//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)comitRightBtn {
    
    UIButton *rightBt  = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBt.frame = CGRectMake(0, 0, 52, 44);
    // [rightBt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightBt setTitle:@"发送" forState:UIControlStateNormal];
    rightBt.titleLabel.font = [UIFont systemFontOfSize:18];
    rightBt.tintColor = [UIColor whiteColor];
    [rightBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    [rightBt addTarget:self action:@selector(rightBarPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark 上传数据..
- (void)rightBarPressed {
    [self.view endEditing:YES];
    if ([self->_linePhoTableView.textView.text length] == 0 && [self->_imageList count] == 0) {
        
        
        [DisplayView disPlayShowWithTitle:@"请填入数据"];
    }
    else {
        
        [self showLoadingActivityViewWithString:@"正在上传数据中..."];
        NSString *content = self->_linePhoTableView.textView.text;
        NSMutableArray *images =  self->_imageList;
        
       
        NSDictionary *upDict = @{@"people_id":[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]],@"content":content,@"images":images};
       
        __unsafe_unretained typeof(self)myself = self;
        
        [NetWorkHandler feedbacksubmitFeedbackParams:upDict completionHandler:^(id content) {
            NSLog(@"》》》%@",content);
            if ([content[@"error"] integerValue] == 0) {
                [myself hideLoadingActivityViewText:@"上传成功"];
//                myself -> _linePhoTableView.textView.text = nil;
//                [images removeAllObjects];
                [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(pushBack) userInfo:nil repeats:NO];
                
                
            }
            else {
                [myself hideLoadingActivityViewText:@"上传失败,输入信息栏不能为空!"];
            }
            NSLog(@"%@",content[@"msg"]);
            _isEdit = YES;
        }];
        

    }
    
}
///**
// *用户方向更新后，会调用此函数
// *@param userLocation 新的用户位置
// */
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    //[_mapView updateLocationData:userLocation];
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    
//    NSLog(@"heading is %@",userLocation.heading);
//}
//
///**
// *用户位置更新后，会调用此函数
// *@param userLocation 新的用户位置
// */
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    [_locService stopUserLocationService];
//    _currentlocation(userLocation);
//}
//- (void)didFailToLocateUserWithError:(NSError *)error {
//    _currentlocation(nil);
//    NSLog(@"didFailToLocateUserWithError %@",error);
//}
//

- (void)imageViewClicked:(UIButton *)sender {
    
//    [self.view endEditing:YES];
//    __unsafe_unretained typeof(self)myself = self;
//    __weak  UIButton *senders = sender;
//    DQPhotoBrowser  *photoBrowser = [DQPhotoBrowser nibPhotoBrowserDatas:@[_imageList[sender.tag-100]] UseingBlock:^{
//        
//        [myself->_linePhoTableView upImageList];
//        [myself->_imageList removeObjectAtIndex:senders.tag-100];
//        [myself uplinePhoTableView];
//    }];
////    photoBrowser.title = @"报路况";
//    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:photoBrowser];
//    //   // nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    //    [self presentViewController:nav animated:YES completion:^{
//    //
//    //    }];
//    //
//    [self.navigationController pushViewController:photoBrowser animated:YES];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    //   [Common convertToInt:toBeString];
    _isEdit = NO;
    if ([Common textLength:toBeString] <= 40) {
        
        return YES;
    }else {
        [self.view endEditing:YES];
//        [DisplayView disPlayShowWithTitle:@"只能输入40字以内"];
        //[DisplayView disPlayShowWithTitle:@"只能输入12位"];
        return NO;
    }
    
}
- (void)uplinePhoTableView {
    
    [_linePhoTableView lineDatas:_imageList];
    if (_imageList.count >= 4) {
        
        if (CGRectGetHeight(_linePhoTableView.bounds) == lineHeghit) {
            _linePhoTableView.bounds = CGRectMake(0, 0, ScreenWidth, twoLineHeghit);//269
            self.tableView.tableHeaderView = nil;
            self.tableView.tableHeaderView = _linePhoTableView;
        }
        
        //        _linePhoTableView.bounds = CGRectMake(0, 0, KScreenWidth, 269);//269
        //        self.tableView.tableHeaderView = nil;
        //        self.tableView.tableHeaderView = _linePhoTableView;
    } else {
        
        NSLog(@"%@",NSStringFromCGRect(_linePhoTableView.bounds));
        if (CGRectGetHeight(_linePhoTableView.bounds) == twoLineHeghit) {
            _linePhoTableView.bounds = CGRectMake(0, 0, ScreenWidth, lineHeghit);//269
            self.tableView.tableHeaderView = nil;
            self.tableView.tableHeaderView = _linePhoTableView;
        }
        
    }
    [_linePhoTableView layoutIfNeeded];
}

- (void)takePhoPress {

    [self.view endEditing:YES];
    if ([_imageList count] == 5) {
//        [DisplayView disPlayTitle:@"最多可添加五张图片"];
        return;
    }
    [TakePictureView takePictureViewWithTakePictureBlock:^(PickMethods method) {
        switch (method) {
            case pickTakePhotos:
                [self pickImageFromCamera];
                break;
            case pickImageFromAlbum:
                
                [self pickImageFromAlbum];
                break;
            case pickCancel:
                
                break;
            default:
                break;
        }
    }];
    
}
#pragma mark -相册相关-
- (void)pickImageFromAlbum
{
    
    [self.view endEditing:YES];
    //    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
    //检查是否有相机
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
    imagepicker.delegate = self;
    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagepicker.allowsEditing = YES;
    
    //        [self presentModalViewController:imagepicker animated:YES];
    [self presentViewController:imagepicker animated:YES completion:^{
        
    }];
    //    }
}

#pragma mark- UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _isEdit = NO;
    //压缩图片分辨率
    //图片编辑状态
    NSData *imageData1 = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerEditedImage"], 0.1);
    //这段代码的作用是修复拍摄图片传到服务器时倒置等情况
    //UIImage *img = ((UIImage *)[info objectForKey:@"UIImagePickerControllerOriginalImage"]).fixOrientation;
    
    //    NSData *imageData1 = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1.0);
    UIImage *img = [UIImage imageWithData:imageData1];
    [_imageList addObject:img];
    
    for (int i = 0 ; i < _imageList.count; i++) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString * _filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"img_%d.jpg", i]];   // 保存文件的名称
        [UIImagePNGRepresentation(_imageList[i])writeToFile:_filePath atomically:YES];
    }
    
    
    
    //  NSLog(@"%d",_imageList.count);
    [self uplinePhoTableView];
    //tempimg = [self compressUploadPic:img];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)pickImageFromCamera
{
    [self.view endEditing:YES];
    
    if (IOS7) {
        NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        // This status is normally not visible—the AVCaptureDevice class methods for discovering devices do not return devices the user is restricted from accessing.
        
        if(authStatus ==AVAuthorizationStatusRestricted){
            NSLog(@"Restricted");
        }
        // The user has explicitly denied permission for media capture.
        else if(authStatus == AVAuthorizationStatusDenied){
            NSLog(@"Denied");     //应该是这个，如果不允许的话
//            [Common showAlert:@"没有权限访问你的相机，请进入系统“设置>隐私>相机”,允许访问您的相机"];
            return;
            
        }
        // The user has explicitly granted permission for media capture, or explicit user permission is not necessary for the media type in question.
        else if(authStatus == AVAuthorizationStatusAuthorized){
            NSLog(@"Authorized");
        }
        // Explicit user permission is required for media capture, but the user has not yet granted or denied such permission.
        else if(authStatus == AVAuthorizationStatusNotDetermined){
            
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if(granted){
                    NSLog(@"Granted access to %@", mediaType);
                }
                else{
                    NSLog(@"Not granted access to %@", mediaType);
                }
            }];
            
        }
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagepicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagepicker.allowsEditing = YES;
        
        //        [self presentModalViewController:imagepicker animated:YES];
        [self presentViewController:imagepicker animated:YES completion:^{
            
        }];
    }
}

//上传图片
-(UIImage *)compressUploadPic:(UIImage *)image
{
    if (image.size.width>640 || image.size.height>1136) {
        float width = 0;
        float height = 0;
        float zoomWidth = image.size.width/640;
        float zoomHeight = image.size.height/1136;
        if (zoomWidth>zoomHeight) {
            width = 640;
            height = image.size.height / zoomWidth;
        }else{
            width = image.size.width/zoomHeight;
            height = 1136;
        }
        UIImage *img = [self imageWithImageSimple:image scaledToSize:CGSizeMake(width, height)];
        return img;
    }else{
        return image;
    }
}

//改变图片大小
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    SectionData *data = _dataSorce[section];
    if (data.isShow) {
        return 0;
       // return [data.array count];
    } else {
        //  self.tableView.tableHeaderView = [LinePhoTableViewCell linePhoTableView];
        return 0;
    }
    // return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    SectionData *data = _dataSorce[section];
    
    //  SectionObj *obj = data.array[section];
    SectionViewCell *sectionView = [SectionViewCell sectionViewSection:section useBlock:^(NSInteger section) {
        [self.view endEditing:YES];
//        _isEdit = NO;
        SectionData *data = [_dataSorce objectAtIndex:section];
        // 改变组的显示状态
        if ([data isShow]) {
            [data setIsShow:NO];
        }else{
            [data setIsShow:YES];
        }
        // 刷新点击的组标题
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        // [self.tableView reloadData];
    }];
    
    sectionView.model = data;
//    [self category_idTitle:sectionView.sectionLabel.text];
    NSLog(@"%@",sectionView.sectionLabel.text);
    //  __weak typeof(self)myself = self;
    self.block = ^(NSString *title) {
        data.name = title;
        sectionView.sectionLabel.text = title;
        
        //  [myself category_idTitle:sectionView.sectionLabel.text];
    };
    return sectionView;
}
//- (void)category_idTitle:(NSString *)title {
//    NSString *cid;
//    if ([title isEqualToString:@"市区路况"]) {
//        cid = @"0";
//    } else if ([title isEqualToString:@"高速路况"]) {
//        cid = @"1";
//    } else {
//        return;
//    }
//    self.category_id = cid;
//    NSLog(@"category_id :%@",self.category_id);
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SectionData *data = _dataSorce[indexPath.section];
    SectionObj *obj =   data.array[indexPath.row];
    
    OpenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:opencellIdentffer forIndexPath:indexPath];
    [cell CEL_referesh];
    for (UIButton *button in cell.buttonList) {
        //  button.titleLabel.font = [UIFont systemFontOfSize:15];
        [cell isHightLight:button YESorNo:NO];
    }
    if (indexPath.section == 0) {
        SectionData *data = _dataSorce[indexPath.section];
        SectionObj *obj =   data.array[indexPath.row];
        
        cell.ishighlight = obj.selected;
        //  NSLog(@"%@",obj.titles);
        cell.type = typeImageA;
        cell.cellBtn.hidden = NO;
        [cell.cellBtn addTarget:self action:@selector(btnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cellBtn setTitle:obj.titles[0] forState:UIControlStateNormal];
//        cell.cellBtn.tintColor = UIColorFromRGB(0x8e8e8e);
        //  cell.cellBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [cell.cellBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-ScreenWidth/2, 0, 0)];
    } else {
        cell.type = typeImageB;
        cell.cellBtn.hidden = YES;
        [cell setTitles:obj.titles dataName:data.name];
        for (int i = 0; i < obj.titles.count; i ++) {
            
            if ([data.name isEqualToString:obj.titles[i]]) {
                self.status_summary = data.name;
//                 self.status = indexPath.row;
                //   NSLog(@"%@ %d",self.status_summary,self.status);
            }
        }
        
        for (UIButton *button in cell.buttonList) {
            //            NSLog(@"button :%@  " ,button.titleLabel.text);
            [button addTarget:self action:@selector(cellBtnPressd:event:) forControlEvents:UIControlEventTouchDown];
        }
        
        cell.vLeftImage.image = [UIImage imageNamed:imagesList[obj.status]];
        cell.status = obj.status;
    }
    cell.block = ^(NSString *title){
        self.block(title);
        NSLog(@"%@",title);
        //    SectionViewCell *section =   (SectionViewCell *)[self tableView:self.tableView viewForHeaderInSection:1];
        //       section.sectionLabel.text = title;
    };
    
    return cell;
}

- (void)buttonPressd:(UIButton *)sender {
    
    
}

- (void)cellBtnPressd:(UIButton *)sender event:(id)event {
    
    [self.view endEditing:YES];
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    
    OpenTableViewCell *indexCell = (OpenTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    self.status_summary = sender.titleLabel.text;
    self.status = indexCell.status;
    for (OpenTableViewCell *cell in [self.tableView visibleCells]) {
        
        if (indexCell == cell) {
            // cell.ishighlight = YES;
            
        } else {
            //sender.tintColor = UIColorFromRGB(0x8e8e8e);
            for (UIButton *button in cell.buttonList) {
                //   button.titleLabel.font = [UIFont systemFontOfSize:15];
                [cell isHightLight:button YESorNo:NO];
            }
            // cell.ishighlight = NO;
        }
    }
}
- (void)btnClicked:(UIButton *)sender event:(id)event
{
    [self.view endEditing:YES];
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
//    sender.tintColor = UIColorFromRGB(0x2d2d2d);
    OpenTableViewCell *indexCell = (OpenTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    SectionData *data = _dataSorce[indexPath.section];
    data.name = sender.titleLabel.text;
    SectionObj *obj =   data.array[indexPath.row];
    for (SectionObj *oooo in data.array) {
        oooo.selected = NO;
    }
    obj.selected = YES;
    
//    SectionData *secondModel = _dataSorce[1];
//    
//    //   NSLog(@"%d",indexPath.row);
//    if (indexPath.row == 0) {
//        
//        secondModel.array = [oooArray mutableCopy];
//    } else if (indexPath.row == 1) {
//        secondModel.array = [bbbArray mutableCopy];
//    }
//    SectionObj *obj2 = secondModel.array[0];
//    secondModel.name = obj2.titles[0];
    [self.tableView reloadData];
    
    if (indexPath.section == 0) {
        for (OpenTableViewCell *cell in [self.tableView visibleCells]) {
            
            
            if (indexCell == cell) {
                cell.ishighlight = YES;
                
            } else {
                
                cell.ishighlight = NO;
            }
            
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //
    //    OpenTableViewCell *indexCell = (OpenTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    //
    //    if (indexPath.section == 0) {
    //        for (OpenTableViewCell *cell in [self.tableView visibleCells]) {
    //
    //            if (indexCell == cell) {
    //                cell.ishighlight = YES;
    //            } else {
    //
    //                cell.ishighlight = NO;
    //            }
    //        }
    //
    //    }
    //   //    OpenTableViewCell *cell = (OpenTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    //    indexCell.ishighlight = YES;
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    for (id cell in [self.tableView visibleCells]) {
    //        [cell setIshighlight:NO];
    //    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//加载数据activity
#pragma mark -loading

#define AnnimationTime 0.5
#define KEY_LOAD 201316
- (void)showLoadingActivityViewWithString:(NSString *)titleString
{
    UIView* blockerView1 = [self.view viewWithTag:KEY_LOAD];
    NSLog(@"blockerView1:%@",blockerView1);
    if (blockerView1) {
        return;
    }
    
    [self hideLoadingActivityView];
    UIView* _blockerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 200,44)];
    // _blockerView.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 0.8];
    _blockerView.backgroundColor = UIColorFromRGB(0x1d1d1d);
    _blockerView.alpha = 0.55;
    ;
    _blockerView.center = CGPointMake([AppDelegate App].window.frame.size.width/2, [AppDelegate App].window.frame.size.height/ 2-50);
    _blockerView.alpha = 0.0;
    _blockerView.clipsToBounds = YES;
    _blockerView.tag=KEY_LOAD;
    //
    if ([_blockerView.layer respondsToSelector: @selector(setCornerRadius:)])
    {
        [(id) _blockerView.layer setCornerRadius: 5];
    }
    
    
    UIActivityIndicatorView	*spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
    [spinner startAnimating];
    spinner.center = CGPointMake(CGRectGetWidth(spinner.bounds)+5, _blockerView.bounds.size.height / 2 );
    [_blockerView addSubview: spinner];
    [self.view addSubview: _blockerView];
    
    UILabel	*label = [[UILabel alloc] initWithFrame: CGRectMake(CGRectGetWidth(spinner.bounds), 0, _blockerView.bounds.size.width-CGRectGetWidth(spinner.bounds), 44)];
    label.text = NSLocalizedString(titleString, nil);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.font = [UIFont boldSystemFontOfSize: 15];
    [_blockerView addSubview: label];
    
    _blockerView.alpha = 0.0;
    [UIView animateWithDuration:AnnimationTime
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         _blockerView.alpha = 0.75;
     }
                     completion:^(BOOL finished)
     {
         //
     }];
}

//取消activity效果
-(void)hideLoadingActivityView
{
    UIView* _blockerView = [self.view viewWithTag:KEY_LOAD];
    _blockerView.hidden = YES;
    [UIView animateWithDuration:AnnimationTime //
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         _blockerView.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         if (_blockerView)
         {
             [_blockerView removeFromSuperview];
         }
         
     }];
}
- (void)hideLoadingActivityViewText:(NSString *)text {
    UIView* _blockerView = [self.view viewWithTag:KEY_LOAD];
    [UIView animateWithDuration:AnnimationTime //
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         _blockerView.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         if (_blockerView)
         {
             [_blockerView removeFromSuperview];
             [DisplayView disPlayShowWithTitle:text];
         }
         
     }];
}

#define Tage_view 201313
- (void)showAcTitle:(NSString*)titleString {
    
    UIView* blockerView1 = [self.view viewWithTag:Tage_view];
    if (blockerView1) {
        return;
    }
    
    [self hideLoadingActivityView];
    UIView* _blockerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 200, 60)];
    _blockerView.backgroundColor = [UIColor clearColor];
    _blockerView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    _blockerView.alpha = 0.0;
    _blockerView.clipsToBounds = YES;
    _blockerView.tag=Tage_view;
    //
    if ([_blockerView.layer respondsToSelector: @selector(setCornerRadius:)])
    {
        [(id) _blockerView.layer setCornerRadius: 10];
    }
    
    UILabel	*label = [[UILabel alloc] initWithFrame: CGRectMake(0, 5, _blockerView.bounds.size.width, 15)];
    label.text = NSLocalizedString(titleString, nil);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = UIColorFromRGB(0x8e8e8e);
    [label setTextAlignment:NSTextAlignmentCenter];
    label.font = [UIFont systemFontOfSize: 15];
    [_blockerView addSubview: label];
    
    UIActivityIndicatorView	*spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
    [spinner stopAnimating];
    spinner.hidden = YES;
    spinner.center = CGPointMake(_blockerView.bounds.size.width / 2, _blockerView.bounds.size.height / 2 + 10);
    [_blockerView addSubview: spinner];
    [self.view addSubview: _blockerView];
    //_blockerView.alpha = 0.0;
    //    [UIView animateWithDuration:AnnimationTime
    //                          delay:0.1
    //                        options:UIViewAnimationOptionCurveEaseIn
    //                     animations:^
    //     {
    _blockerView.alpha = 1.0;
    //     }
    //                     completion:^(BOOL finished)
    //     {
    //         //
    //     }];
    
    
}
- (void)hideTitle {
    
    UIView* _blockerView = [self.view viewWithTag:Tage_view];
    [_blockerView removeFromSuperview];
    //    [UIView animateWithDuration:AnnimationTime //
    //                          delay:0.1
    //                        options:UIViewAnimationOptionCurveEaseInOut
    //                     animations:^
    //     {
    //         _blockerView.alpha = 0;
    //     }
    //                     completion:^(BOOL finished)
    //     {
    //         if (_blockerView)
    //         {
    //             [_blockerView removeFromSuperview];
    //         }
    //
    //     }];
}

#define EMpty_tag 20131225
- (void)emptyTitle:(NSString *)text {
    
    UIView* blockerView1 = [self.view viewWithTag:EMpty_tag];
    if (blockerView1) {
        return;
    }
    
    [self hideLoadingActivityView];
    UIView* _blockerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 200, 60)];
    _blockerView.backgroundColor = [UIColor clearColor];
    _blockerView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    _blockerView.alpha = 0.0;
    _blockerView.clipsToBounds = YES;
    _blockerView.tag=EMpty_tag;
    //
    if ([_blockerView.layer respondsToSelector: @selector(setCornerRadius:)])
    {
        [(id) _blockerView.layer setCornerRadius: 10];
    }
    
    UILabel	*label = [[UILabel alloc] initWithFrame: CGRectMake(0, 5, _blockerView.bounds.size.width, 15)];
    label.text = NSLocalizedString(text, nil);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = UIColorFromRGB(0x8e8e8e);
    [label setTextAlignment:NSTextAlignmentCenter];
    label.font = [UIFont systemFontOfSize: 15];
    [_blockerView addSubview: label];
    
    //    UIActivityIndicatorView	*spinner = [[UIActivityIndicatorView alloc]
    //                                        initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
    //    [spinner startAnimating];
    //    spinner.hidden = YES;
    //    spinner.center = CGPointMake(_blockerView.bounds.size.width / 2, _blockerView.bounds.size.height / 2 + 10);
    //    [_blockerView addSubview: spinner];
    [self.view addSubview: _blockerView];
    _blockerView.alpha = 0.0;
    [UIView animateWithDuration:AnnimationTime
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         _blockerView.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         //
     }];
    
}
- (void)hideEmpty {
    
    UIView* _blockerView = [self.view viewWithTag:EMpty_tag];
    [_blockerView removeFromSuperview];
}

#define TAG_WEB 201311
#define AnnimationTime 0.5
//加载网页样式
- (void)showWebViewActivityString:(NSString *)text {
    UIView* blockerView1 = [self.view viewWithTag:TAG_WEB];
    if (blockerView1) {
        return;
    }
    
    [self hideLoadingActivityView];
    UIView* _blockerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 200,44)];
    // _blockerView.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 0.8];
    //_blockerView.backgroundColor = UIColorFromRGB(0x1d1d1d);
    //_blockerView.backgroundColor = [UIColor grayColor];
    // _blockerView.alpha = 0.55;
    _blockerView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    _blockerView.alpha = 0.0;
    _blockerView.clipsToBounds = YES;
    _blockerView.tag=TAG_WEB;
    //
    if ([_blockerView.layer respondsToSelector: @selector(setCornerRadius:)])
    {
        [(id) _blockerView.layer setCornerRadius: 5];
    }
    
    
    UIActivityIndicatorView	*spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    // spinner.center = CGPointMake(CGRectGetWidth(spinner.bounds)+5, _blockerView.bounds.size.height / 2 );
    spinner.center = CGPointMake(CGRectGetMidX(_blockerView.bounds), CGRectGetMidY(_blockerView.bounds));
    [_blockerView addSubview: spinner];
    [self.view addSubview: _blockerView];
    
    UILabel	*label = [[UILabel alloc] initWithFrame: CGRectMake(CGRectGetWidth(spinner.bounds), 0, _blockerView.bounds.size.width-CGRectGetWidth(spinner.bounds), 44)];
    // label.text = NSLocalizedString(text, nil);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.font = [UIFont systemFontOfSize: 15];
    [_blockerView addSubview: label];
    
    _blockerView.alpha = 0.0;
    [UIView animateWithDuration:AnnimationTime
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         _blockerView.alpha = 1;
     }
                     completion:^(BOOL finished)
     {
         //
     }];
    
}

- (void)hideWebViewActivityString:(NSString *)text {
    UIView* _blockerView = [self.view viewWithTag:TAG_WEB];
    _blockerView.hidden = YES;
    [UIView animateWithDuration:AnnimationTime //
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         _blockerView.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         if (_blockerView)
         {
             [_blockerView removeFromSuperview];
         }
         
     }];
    
}






@end
