//
//  AdvertisementTableViewCell.m
//  ManageEverything
//
//  Created by zz on 15/6/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "AdvertisementTableViewCell.h"

@interface AdvertisementTableViewCell () <UIScrollViewDelegate> {
    
    
    NSTimer *_timer;
}

@property (weak, nonatomic) IBOutlet UIView *contentsView;

@property (weak, nonatomic) IBOutlet UIView *adView;



@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong , nonatomic) UIPageControl *pageController;

//获取实际图片展示索引
- (NSInteger)realIndexWithIndex:(NSInteger)index;

//刷新界面
//- (void)updateUserInterfaceWithScrollViewContentOffset:(CGPoint)contentOffset;
@end

@implementation AdvertisementTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)advertisementTableViewCellBlock:(void (^)())block {
    
    AdvertisementTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AdvertisementTableViewCell" owner:nil options:nil] firstObject];
//    cell.scrollView = [[UIScrollView alloc]init];
    cell.scrollView.clipsToBounds = YES;
    [cell.adView addSubview:cell.scrollView];
    cell.scrollView.contentSize = cell.scrollView.frame.size;
    cell.scrollView.pagingEnabled = YES;
    cell.scrollView.contentOffset = CGPointZero;
    cell.scrollView.delegate = cell;
    cell.scrollView.showsHorizontalScrollIndicator = NO;
    cell.scrollView.showsVerticalScrollIndicator = NO;
    cell.gesturePress = block;
    
    return cell;
}

- (void)drawRect:(CGRect)rect {
    
//    _pageController = [[UIPageControl alloc]init];
//    _pageController.frame = CGRectMake(ScreenWidth - 80, 110, 80, 10);
//    [self addSubview:_pageController];
//    
//    self.scrollView.frame = CGRectMake(0, 0, ScreenWidth, 149);
//    self.scrollView.clipsToBounds = YES;
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [singleTapGesture setNumberOfTapsRequired:1];
    [self addGestureRecognizer:singleTapGesture];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [self addGestureRecognizer:doubleTapGesture];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0
                                              target:self
                                            selector:@selector(processTimer:)
                                            userInfo:nil
                                             repeats:YES];
    //    //这行很关键，意思是只有当没有检测到doubleTapGestureRecognizer 或者 检测doubleTapGestureRecognizer失败，singleTapGestureRecognizer才有效
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];

}

//
- (void)setData:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    else {
        
//        for (NSMutableArray *array in dataSource) {
//            [_dataSource addObject:array];
//        }
        _currentIndex = 0;
        self.pageControl.currentPage = _currentIndex;
        self.pageControl.numberOfPages = [_dataSource count];
        self.scrollView.contentSize = CGSizeMake(ScreenWidth * (_dataSource.count + 1), CGRectGetHeight(self.scrollView.bounds));
        
        for (int i = 0; i < _dataSource.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * i , 0, ScreenWidth, 149)];
            imageView.image = _dataSource[i];
            [_scrollView addSubview:imageView];
            
            if (i == _dataSource.count - 1) {
                i++;
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, CGRectGetHeight(_scrollView.bounds))];
                imageView.image = _dataSource[0];
                [_scrollView addSubview:imageView];
            }
        }
    }
//    if (!_dataSource) {
//        _dataSource = [NSMutableArray array];
//        
//    }
//    [_dataSource removeAllObjects];
//    
//    for (NSDictionary *dict in dataSource) {
//        NewsLiveListTop *modeol = [[NewsLiveListTop alloc]initWithDicitonary:dict];
//        [_dataSource addObject:modeol];
//    }
//    _currentIndex = 0;
//    
//    self.pageControl.currentPage = _currentIndex;
//    self.pageControl.numberOfPages = [_dataSource count];
//    self.newsLiveListTopModel = _dataSource[_currentIndex];
//    self.scrollView.contentSize = CGSizeMake(ScreenWidth * (_dataSource.count + 1), CGRectGetHeight(self.scrollView.bounds));
//    
//    for (int i = 0; i < [_dataSource count]; i ++) {
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * i , 0, ScreenWidth, 163)];
//        NewsLiveListTop *model = _dataSource[i];
//        NSURL *url = [NSURL URLWithString:[model news_url]];
//        [imageView setImageWithURL:url placeholderImage:nil];
//        [_scrollView addSubview:imageView];
//        
//        if (i == [_dataSource count] - 1) {
//            i++;
//            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * i , 0, ScreenWidth, CGRectGetHeight(_scrollView.bounds))];
//            model = _dataSource[0];
//            imageView.contentMode = UIViewContentModeScaleAspectFill;
//            [imageView setImageWithURL:url placeholderImage:nil];
//            [_scrollView addSubview:imageView];
//        }
//    }
}

- (NSInteger) realIndexWithIndex:(NSInteger)index {
    
    //获取最大索引值
    NSInteger maximumIndex = [_dataSource count] - 1;
    if (index > maximumIndex) {
        index = 0;
    }
    else if (index < 0){
        index = maximumIndex;
    }
    return index;
}

//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_scrollView]) {
        
        NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        if (index == [_dataSource count]) {
            
            [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.bounds) * 0, 0) animated:NO];
            return;
        }
        if (index == _currentIndex) {
            return;
        }
        else if(index > _currentIndex) {
                _currentIndex = [self realIndexWithIndex:_currentIndex++];
            }
        else {
                _currentIndex = [self realIndexWithIndex:_currentIndex--];
            }
        _currentIndex = index;
        self.pageControl.currentPage = _currentIndex;
//        self.newsLiveListTopModel = _dataSource[_currentIndex];
    }
}

- (void)processTimer:(NSTimer *)timer {
    
    BOOL isAnimated = YES;
    if (_currentIndex++ > [_dataSource count]) {
        _currentIndex = 0;
        isAnimated = NO;
    }
    
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds) * _currentIndex, 0) animated:isAnimated];
}

- (void)singleTap:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"1111");
    self.gesturePress();
}

- (void)doubleTap:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"222");
    self.gesturePress();
}



@end
