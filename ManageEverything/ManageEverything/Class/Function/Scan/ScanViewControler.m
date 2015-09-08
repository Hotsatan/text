//
//  ScanViewControler.m
//  ManageEverything
//
//  Created by zz on 15/6/5.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "ScanViewControler.h"
#import <AVFoundation/AVFoundation.h>
@interface ScanViewControler ()<AVCaptureMetadataOutputObjectsDelegate> {
    
    UILabel *label;
    AVCaptureDeviceInput *input;
    AVCaptureVideoPreviewLayer *preview;
    AVCaptureSession *session;
    
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    


}

@property (nonatomic, strong) UIImageView * line;

@property (nonatomic ,strong) UIView *scanView;
@property (nonatomic ,strong) UIButton *button;
@property (nonatomic ) AVCaptureSession *captureSession; //二维码生成绘画
@property (nonatomic) AVCaptureVideoPreviewLayer *previewLayer; //二维码生成图层
@property (nonatomic) BOOL lastResut;


@end

@implementation ScanViewControler

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"二维码扫描";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    UIButton *refreashBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [refreashBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refreashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [refreashBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:refreashBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    //配置二维码扫描
    [self configurationScan];
    
    
}

- (void)configurationScan {
    
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
//    scanButton.frame = CGRectMake(100, 420, 120, 40);
//    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:scanButton];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(30, 50, ScreenWidth - 60, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.font = [UIFont systemFontOfSize:15];
    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [self.view addSubview:labIntroudction];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, ScreenWidth - 100, 220)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(60, 110 , ScreenWidth - 120, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];

    
    //
//    label = [[UILabel alloc]init];
//    label.layer.borderColor = [[UIColor blueColor]CGColor];
//    label.layer.borderWidth = 1.0;
//    label.frame = CGRectMake( 8, 100, [UIScreen mainScreen].bounds.size.width - 16, 30);
//    [self.view addSubview:label];
    
    //获取摄像头
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //设置输入
    NSError *error = nil;
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error) {
        NSLog(@"没有摄像头");
        return;
    }
    
    //设置输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //    [output setRectOfInterest:CGRectMake(0.2, 0.2, 0.2, 0.2)];
    //拍摄会话
    session = [[AVCaptureSession alloc]init];
    [session addInput:input];
    [session addOutput:output];
    
    //设置输出格式
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //设置预览图层
    preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    
    //设置preview图层的属性
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //设置preview图层的大小
    [preview setFrame:CGRectMake(0, 0 , ScreenWidth , ScreenHeight)];
    

    [output setRectOfInterest:CGRectMake(100 / ScreenHeight, 50 / ScreenWidth, 220 / ScreenHeight, (ScreenWidth - 100) / ScreenWidth)];
    
    
    //将图层添加到视图的图层
    [self.view.layer insertSublayer:preview atIndex:0];
    self.previewLayer = preview;
    
    //启动会话
    [session startRunning];
    
    self.captureSession = session;

}

-(void)animation1
{
    
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(60, 110+2*num, ScreenWidth - 120, 2);
        if (2*num == 200) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(60, 110+2*num, ScreenWidth - 120, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
    
}

- (void)scan {
    
    _line.hidden = NO;
    [session startRunning];
    
    self.captureSession = session;
    
    
}

- (void)btnClick {
    
    [self scan];
}
#pragma mark -<>

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    _line.hidden = YES;
    //如果扫描完成，停止会话
    [self.captureSession stopRunning];
    
    //删除预览图层
    //    [self.previewLayer removeFromSuperlayer];
    
    NSLog(@"%@",metadataObjects);
    
    //设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        //提示：如果需要对url或者名片等信息进行扫描，可在此进行拓展
        label.text = obj.stringValue;
    }
    
}


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
