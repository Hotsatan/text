//
//  ZPhotoBrowserViewController.m
//  ManageEverything
//
//  Created by zz on 15/6/16.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "ZPhotoBrowserViewController.h"

@interface ZPhotoBrowserViewController ()<UIScrollViewDelegate> {
    
    UIScrollView *_scrollView;
    UIView *_midView;
    NSInteger mCurrentPage;
    NSMutableArray *_dataSource;
}

@property (nonatomic,assign) BOOL photoType;
@property (nonatomic,strong) NSMutableArray *dataSource;

- (void)initializeInterface;

@end

@implementation ZPhotoBrowserViewController

//+ (instancetype)photoBrowserDatas:(NSArray *)datas using{
//    
//    ZPhotoBrowserViewController *vc = [[ZPhotoBrowserViewController alloc]init];
//    vc.dataSource = [datas mutableCopy];
//    vc.blockPage = blo
//}

+ (instancetype)photoBrowserDatas:(NSArray *)datas UseingBlock:(dispatch_block_t)block {
    
    ZPhotoBrowserViewController *vc = [[ZPhotoBrowserViewController alloc]init];
    vc.dataSource = [datas mutableCopy];
    vc.blockPage = block;
    vc.photoType = YES;
    return vc;
}

+ (instancetype)photoBrowserDatas:(NSArray *)datas {
    
    ZPhotoBrowserViewController *vc = [[ZPhotoBrowserViewController alloc]init];
    vc.dataSource = [datas mutableCopy];
    vc.photoType = NO;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeInterface];
    UIImage *image = [UIImage imageNamed:@"return"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    btn.clipsToBounds = YES;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //   [leftBtn setAction:@selector(pushBack)];
    self.navigationItem.leftBarButtonItem = leftBtn;

    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)pushBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self commInit];
}

#pragma mark UI初始化
- (void)commInit{
    
   
//    self.automaticallyAdjustsScrollViewInsets = YES;
    
//    if (IsIOS7) {
//        self.edgesForExtendedLayout = UIRectEdgeNone ;
//    }
    _midView = [[UIView alloc] init];
    _midView.bounds = CGRectMake(0, 0, ScreenWidth, 200);
    _midView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2 - 32);
    _midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_midView];
    
    //初始化滑动列表
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = _midView.bounds;
//        _scrollView.bounds = CGRectMake(0, 0, ScreenWidth, 200);
//        _scrollView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2 - 32);
//        _scrollView.frame = _midView.bounds;
        
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
//        _scrollView.clipsToBounds = YES;
//        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [_midView addSubview:_scrollView];
    }
    
//    if (!self.photoType) {
//        
//        UIButton *leftBtn = [self arrowBtnType];
//        leftBtn.center = CGPointMake(CGRectGetWidth(leftBtn.bounds)/2 + 5, CGRectGetMidY(_midView.bounds));
//        [leftBtn addTarget:self action:@selector(leftPressd) forControlEvents:UIControlEventTouchUpInside];
//        [_midView addSubview:leftBtn];
//        
//        UIButton *rightBtn = [self arrowBtnType];
//        UIImage *image = [Common scalImageOrientaiton:UIImageOrientationDown scalName:@"paging_item"];
//        [rightBtn setImage:image forState:UIControlStateNormal];
//        [rightBtn setImage:image forState:UIControlStateHighlighted];
//        
//        rightBtn.center = CGPointMake(CGRectGetMaxX(_midView.frame)-CGRectGetWidth(rightBtn.bounds)/2- 5, CGRectGetMidY(_midView.bounds));
//        [rightBtn addTarget:self action:@selector(rightPressd) forControlEvents:UIControlEventTouchUpInside];
//        
//        [_midView addSubview:rightBtn];
//        NSLog(@"%@",self.dataSource);
//        if ([self.dataSource count] <= 1) {
//            leftBtn.hidden = YES;
//            rightBtn.hidden = YES;
//        }
//        
//    }
    
    
    mCurrentPage = 0;
    // _dataSource = [@[@"1",@"2",@"3"] mutableCopy];
    [self initImages:_dataSource];
}

- (void)leftPressd {
    mCurrentPage--;
    if (mCurrentPage == -1) {
        mCurrentPage = 0;
    }
    
    [self scrollViewAnimation];
}

- (void)tagWithPage:(NSInteger)page {
    
    mCurrentPage = page;
    [self scrollViewAnimation];
}

- (void)rightPressd {
    mCurrentPage++;
    if (mCurrentPage == [_dataSource count]) {
        mCurrentPage = [_dataSource count]-1;
    }
    [self scrollViewAnimation];
}

- (void)scrollViewAnimation {
    
    CGFloat offset =  ScreenWidth * (mCurrentPage);
    [_scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

//
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if([scrollView isEqual:_scrollView]){
        
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2.0) / pageWidth) + 1;
        
        if (mCurrentPage == page) {
            return;
        }
        mCurrentPage = page;
        
    }
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部。
}


//
- (UIButton *)arrowBtnType {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //15, 23
    button.bounds = CGRectMake(0, 0, 15, 23);
    
    // [button setTitle:@"zuo" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"paging_item"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"paging_item"] forState:UIControlStateHighlighted];
    return button;
}

- (void)initImages:(NSArray *)datas {
    
    NSInteger aPage = [datas count];
    if ([datas count] ) {
//        NSLog(@"path:%@",[NSURL URLWithString:[NSString stringWithFormat:@"http://gdk.pw/%@",datas[i][@"path"]]]);
//        [imagView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://gdk.pw/%@",datas[@"path"]]]];
    }
    
    

    
    mCurrentPage = 0;
    [_scrollView setContentSize:CGSizeMake(ScreenWidth * aPage, _scrollView.frame.size.height)];
    NSLog(@"contenSize:%@",NSStringFromCGSize(_scrollView.contentSize));
    for (int i = 0; i < aPage; i ++) {
        UIImageView *view = [[UIImageView alloc] init];
        view.bounds = _scrollView.bounds;
        view.center = CGPointMake(CGRectGetWidth(view.bounds)/2 + i*ScreenWidth, CGRectGetMidY(_scrollView.frame) );
//        view.frame = _scrollView.frame;
        view.contentMode = UIViewContentModeScaleAspectFill;
        
        NSLog(@"Viwe:%@",NSStringFromCGRect(view.frame));
        NSLog(@"ScroView:%@",NSStringFromCGRect(_scrollView.frame));
        view.clipsToBounds = YES;
        if (!self.photoType) {
            [view setImageWithURL:[NSURL URLWithString:datas[i]]];
            
        } else {
            [view setImageWithURL:[NSURL URLWithString:datas[i]]];
        }
        // view.backgroundColor = i%2 == 0 ?  [UIColor redColor]: [UIColor orangeColor];
        [_scrollView addSubview:view];
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
