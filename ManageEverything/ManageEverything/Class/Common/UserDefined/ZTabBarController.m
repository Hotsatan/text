//
//  ZTabBarController.m
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "ZTabBarController.h"
#define NumberOfTabBar 5
#define ArrayImage @[@"shouye",@"tongzhi",@"dynamic1",@"lishi",@"geren"]
#define ArrayImageSelected @[@"shouye_s",@"tongzhi_s",@"dynamic2",@"lishi_s",@"geren_s"]
#define TabNameArray @[@"首页",@"我的消息",@"",@"发现",@"个人中心"]
@interface ZTabBarController ()

@end


@implementation ZTabBarController

@synthesize currentSelectedIndex;
@synthesize bgView;
@synthesize redPoints;

//- (id)init {
//    
//    if (self = [super init]) {
//        self.tabType = TabTypeName;
//    }
//    return self;
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    UIButton *button = (UIButton *)[self.view viewWithTag:2];
//    [self.view bringSubviewToFront:button];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self setHideZTabBar:YES];
//    [self showTabBarButtonName];
//}
//
////隐藏父类的View
//- (void)setHideZTabBar:(BOOL)hide {
//    
//    for (UIView *view in self.view.subviews) {
//        view.hidden = hide;
//        break;
//
//    }
//}
//
////隐藏本类Btn
//- (void)setHideZTabBarBtn:(BOOL)hide {
//    
//    CGRect frame;
//    CGFloat height = 0;
//    if (hide) {
//        for (UIButton *btn in self.btnArray) {
//            frame = btn.frame;
//            frame.size.height = height;
//            btn.frame = frame;
//        }
//        frame = self.bgView.frame;
//        frame.size.height = height;
//        self.bgView.frame = frame;
//        bgView.backgroundColor = [UIColor clearColor];
//        bgView.hidden = NO;
//    }
//}
//
////用索引改变状态
//- (void)tabBarSelectIndex:(int)index {
//    
//    UIButton *btn = [self.btnArray objectAtIndex:index];
//    [self tabBarSelectBtn:btn];
//    
//}
//
//- (void)setHideRedPoint:(BOOL)hide index:(NSInteger)index {
//    
//    UIView *redPoint = redPoints[index];
//    [redPoint setHidden:hide];
//}
//
////设置btn选中
//
//- (void)tabBarSelectBtn:(UIButton *)btn {
//    
//    UIButton *button = [self.btnArray objectAtIndex:self.currentSelectedIndex];
//    button.selected = NO;
//    btn.selected = YES;
//    self.currentSelectedIndex = btn.tag;
//    self.selectedIndex = btn.tag;
//}
//
////图片无文字模式
//- (void)showTabBarButtonName {
//    
//    redPoints = [[NSMutableArray alloc]init];
//    self.btnArray = [[NSMutableArray alloc]initWithCapacity:NumberOfTabBar];
//    bgView = [[UIImageView alloc]init];
//    bgView.backgroundColor = [UIColor clearColor];
//    bgView.image = GET_IMAGE(@"bottom1");
//    bgView.contentMode = UIViewContentModeScaleAspectFill;
//    bgView.clipsToBounds = YES;
//    bgView.userInteractionEnabled = YES;
//    bgView.frame = CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49);
//    [self.view addSubview:bgView];
//    
//    //创建按钮
//    NSArray *array = ArrayImage;
//    NSArray *arraySelected = ArrayImageSelected;
//    NSArray *nameArray = TabNameArray;
//    double _width = ScreenWidth / [nameArray count];
//    for (int i = 0 ; i < arraySelected.count; i ++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.userInteractionEnabled = YES;
//        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        btn.backgroundColor = [UIColor clearColor];
//        [btn addTarget:self action:@selector(tabBarSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
//        btn.tag = i;
//        if (i == 2) {
//            btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
//            btn.window.windowLevel = UIWindowLevelAlert;
//            
//            UIImage *image = [UIImage imageNamed:array[i]];
//            [btn setImage:image forState:UIControlStateNormal];
//            
//            image = [UIImage imageNamed:ArrayImageSelected[i]];
//            [btn setImage:image forState:UIControlStateSelected];
//            
//            btn.backgroundColor = [UIColor whiteColor];
//            btn.bounds = CGRectMake(0, 0, 55, 55);
//            btn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetHeight(self.bgView.frame) - 26);
//            btn.layer.cornerRadius = CGRectGetHeight(btn.bounds)/ 2.0;
//            btn.clipsToBounds = YES;
//            
//            UIImageView *imageView = [[UIImageView alloc]init];
//            imageView.frame = CGRectMake(1.5, 1.5, CGRectGetWidth(btn.frame) - 3, CGRectGetHeight(btn.frame) - 3);
//            imageView.image = GET_IMAGE(@"saomiao");
//            imageView.layer.cornerRadius = CGRectGetWidth(btn.frame) / 2.0;
//            imageView.clipsToBounds = YES;
//            [btn addSubview:imageView];
//        }
//        else {
//            
//            [btn setImage:[UIImage imageNamed:ArrayImage[i]] forState:UIControlStateNormal];
//            [btn setImage:[UIImage imageNamed:ArrayImageSelected[i]] forState:UIControlStateSelected];
//            [btn setTitle:nameArray[i] forState:UIControlStateNormal];
//            btn.frame = CGRectMake(i *_width, 0, _width, 59);
//            btn.titleLabel.font = [UIFont systemFontOfSize:12];
//            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            [btn setTitleColor:CUstomBlue forState:UIControlStateSelected];
//            btn.imageEdgeInsets = UIEdgeInsetsMake(5, 20, 20, 20);
//            btn.titleEdgeInsets = UIEdgeInsetsMake(3, -44, 0, 0);
//        }
//        [self.btnArray addObject:btn];
//        [self.bgView addSubview:btn];
//        UIView *redPoint = [[UIView alloc]init];
//        redPoint.frame = CGRectMake(CGRectGetWidth(btn.frame) - 20, 5, 8, 8);
//        redPoint.backgroundColor = [UIColor redColor];
//        redPoint.userInteractionEnabled = YES;
//        redPoint.layer.cornerRadius = 8 / 2;
//        redPoint.hidden = YES;
//        [redPoints addObject:redPoint];
//        [btn addSubview:redPoint];
//    }
//    [self tabBarSelectBtn:[self.btnArray objectAtIndex:2]];
//    
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

- (id)init
{
    if (self) {
        // Custom initialization
        self.tabType = TabTypeName;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIButton *button = (UIButton *)[self.view viewWithTag:2];
    [self.view bringSubviewToFront:button];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //隐藏父类tabBar
    [self setHideEsunTabBar:YES];
    [self showTabBarButtonName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *隐藏父类的view
 */
- (void)setHideEsunTabBar:(BOOL)hide
{
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = hide;
            break;
        }
    }
}

/*
 *隐藏本类的Btn
 */
- (void)setHideEsunTabBarBtn:(BOOL)hide
{
    CGFloat height = 0;
    if(hide)
    {
        height = 0;
        for(UIButton *btn in self.btnArray)
        {
            CGRect frame = btn.frame;
            frame.size.height = height;
            btn.frame = frame;
        }
        CGRect frame = self.bgView.frame;
        frame.size.height = height;
        self.bgView.frame = frame;
        bgView.backgroundColor = [UIColor clearColor];
        bgView.hidden = YES;
    }
    else
    {
        height = 55;
        for (int i = 0; i<[self.btnArray count]; i++)
        {
            UIButton *btn = [self.btnArray objectAtIndex:i];
            CGRect frame = btn.frame;
            frame.size.height = height;
            if (i == 2)
            {
                frame.size.height = 65;
                frame.size.width = 65;
                btn.layer.cornerRadius = 65/2;
            }
            btn.frame = frame;
            CGRect bgframe = self.bgView.frame;
            bgframe.size.height = height;
            self.bgView.frame = bgframe;
            bgView.backgroundColor = [UIColor clearColor];
            bgView.hidden = NO;
        }
    }
}
//用索引改变状态
- (void)tabbarSelectIndex:(int)index
{
    UIButton *button = [self.btnArray objectAtIndex:index];
    [self tabbarSelectBtn:button];
}

- (void)setHideRedPoint:(BOOL)hide index:(NSInteger)index {
    
    UIView *redPoint = redPoints[index];
    [redPoint setHidden:hide];
}

/*
 *设置btn选中
 */
- (void)tabbarSelectBtn:(UIButton *)button
{
    UIButton *btn = [self.btnArray objectAtIndex:self.currentSelectedIndex];
    btn.selected = NO;
    button.selected = YES;
    self.currentSelectedIndex = button.tag;
    self.selectedIndex = button.tag;
}

//图片文字模式
- (void)showTabBarButtonName
{
    
    redPoints = [[NSMutableArray alloc] init];
    self.btnArray = [[NSMutableArray alloc] initWithCapacity:5];
    bgView = [[UIImageView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
//    bgView.image = GET_IMAGE(@"tabBarImage.png");
    bgView.image = [UIImage imageNamed:@"tabBarImage"];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    bgView.clipsToBounds = NO;
    bgView.userInteractionEnabled = YES;
    bgView.frame = CGRectMake(0, ScreenHeight - 55, ScreenWidth, 55);
    [self.view addSubview:bgView];
    //创建按钮
//    NSArray *arr=[NSArray arrayWithObjects:@"participation1",@"secret1",@"dynamic1",@"news1",@"mine1",nil];
//    NSArray *arrSelect=[NSArray arrayWithObjects:@"participation2",@"secret2",@"dynamic2",@"news2",@"mine2",nil];
//    NSArray *nameArray = @[@"参与",@"私密",@"微动态",@"资讯",@"我的"];
    NSArray *arr = ArrayImage;
    NSArray *arrSelect = ArrayImageSelected;
    NSArray *nameArray = TabNameArray;
    double _width = ScreenWidth / [nameArray count];
    for (int i = 0; i < arrSelect.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        btn.clipsToBounds = YES;
        btn.userInteractionEnabled = YES;
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(tabbarSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        if (i == 2)
        {
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//            btn.window.windowLevel = UIWindowLevelAlert;
            
            //            btn.imageView.clipsToBounds = YES;
//            UIImage *image = [UIImage imageNamed:arr[i]];
//            //            image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//            [btn setImage:image forState:UIControlStateNormal];
//            
//            image = [UIImage imageNamed:arrSelect[i]];
//            //            image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//            [btn setImage:image forState:UIControlStateSelected];
//            btn.imageEdgeInsets = UIEdgeInsetsMake(-5, -5, -5, -5);
            btn.backgroundColor = [UIColor whiteColor];
            btn.bounds = CGRectMake(0, 0, 65, 65);
            btn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetHeight(self.bgView.frame) - 26 + 3);
            btn.layer.borderWidth = 2.0;
            btn.layer.borderColor = [UIColor colorWithRed:66 / 255.0 green:150 / 255.0 blue:235 / 255.0 alpha:1.0].CGColor;
            btn.layer.cornerRadius = CGRectGetHeight(btn.bounds) / 2.0;
            btn.backgroundColor = [UIColor colorWithRed:0.969f green:0.969f blue:0.969f alpha:1.00f];
            btn.clipsToBounds = YES;
            //            btn.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
            
            UIImageView *imageView = [[UIImageView alloc] init];
//            imageView.frame = CGRectMake(15,15, CGRectGetWidth(btn.frame) , CGRectGetHeight(btn.frame) );
            
            imageView.bounds = CGRectMake(0, 0, CGRectGetWidth(btn.frame)-10, CGRectGetHeight(btn.frame) - 24);
            imageView.center = CGPointMake(CGRectGetWidth(btn.frame) / 2.0, CGRectGetHeight(btn.frame) / 2.0);
//            imageView.image = GET_IMAGE(@"saomiao.png");
            imageView.image = [UIImage imageNamed:@"saomiao"];
            imageView.layer.cornerRadius = CGRectGetWidth(btn.frame) / 2;
//            imageView.clipsToBounds = YES;
            [btn addSubview:imageView];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:arrSelect[i]] forState:UIControlStateSelected];
        
            [btn setTitle:nameArray[i] forState:UIControlStateNormal];
            btn.frame = CGRectMake(i*_width ,0, _width, 59);
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:CUstomBlue forState:UIControlStateSelected];
            btn.imageEdgeInsets = UIEdgeInsetsMake(5, 20, 20, 20);
            if (ScreenWidth == 320) {
                btn.titleEdgeInsets = UIEdgeInsetsMake(30, -25, 0, 0);
            }
            else {
                btn.titleEdgeInsets = UIEdgeInsetsMake(30, -34, 0, 0);
            }
            
        }
        [self.btnArray addObject:btn];
        [self.bgView  addSubview:btn];
       
        UIView *redPoint = [[UIView alloc] init];
        redPoint.frame = CGRectMake(CGRectGetWidth(btn.frame) - 20, 5, 8, 8);
        redPoint.backgroundColor = [UIColor redColor];
        redPoint.userInteractionEnabled = YES;
        redPoint.layer.cornerRadius = 8/2;
        redPoint.hidden = YES;
        [redPoints addObject:redPoint];
        [btn addSubview:redPoint];
        
        UILabel *numLabel = [[UILabel alloc]init];
        numLabel.frame = CGRectMake(CGRectGetWidth(btn.frame) - 20, 5, 8, 8);
        numLabel.backgroundColor = [UIColor redColor];
        numLabel.font = [UIFont systemFontOfSize:10];
        numLabel.hidden = YES;
        [btn addSubview:numLabel];
    }
    [self tabbarSelectBtn:[self.btnArray objectAtIndex:2]];
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
