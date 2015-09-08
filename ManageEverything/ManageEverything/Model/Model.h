//
//  Model.h
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

// 初始化
- (id)initWithDictionaryParams:(NSDictionary *)param;
- (id)initWithDicitonary:(NSDictionary *)dictionary;
// 转为服务器接收的字典
- (NSDictionary *)serverNeededDictionary;
// 获取属性列表
- (NSMutableArray *)properties;
+ (NSMutableArray *)properties;
// 计算完整自身对象数据完整度
- (float)integrity;
// 返回自身对象所有数据的数组集合
- (NSMutableArray *)valueForProperties;


@end

@interface NewsLiveListTop : Model

@property (nonatomic,copy) NSString *news_url;


@end

@interface HomeMessageDetailModel : Model

@property (weak, nonatomic)  NSString *admin_name;
@property (weak, nonatomic)  NSString *district;
@property (weak, nonatomic)  NSString *floor;

@property (weak, nonatomic)  NSString  *house_number;
@property (weak, nonatomic)  NSString *id;
@property (weak, nonatomic)  NSString *is_delete;

@property (weak, nonatomic)  NSString *is_street;
//--------------------------

@property (weak, nonatomic)  NSString *layer;
@property (weak, nonatomic)  NSString *search;
@property (weak, nonatomic)  NSString *type;
@property (weak, nonatomic)  NSString *unit;
@property (weak, nonatomic)  NSString *update_time;
//@property (weak, nonatomic)  NSString *locality;
//@property (weak, nonatomic)  NSString *localPoliceStation;
//@property (weak, nonatomic)  UIButton *nonrent;
//@property (weak, nonatomic)  UIButton *rent;
//
////-------------------------
//
//@property (weak, nonatomic)  NSString *lodgingStyle;
//@property (weak, nonatomic)  NSString *lodgingNumber;
//@property (weak, nonatomic)  NSString *lodgingArea;
//@property (weak, nonatomic)  NSString *lodgingPurpose;
//@property (weak, nonatomic)  NSString *lodgingNumberOfPeople;
//@property (weak, nonatomic)  NSString *lodgingOfBeginTime;
//@property (weak, nonatomic)  NSString *lodgingOfEndTime;
//@property (weak, nonatomic)  UIButton *egister;
//@property (weak, nonatomic)  UIButton *nonRegister;
//
//@property (weak, nonatomic)  UIButton *contract;
//
//@property (weak, nonatomic)  UIButton *nonContract;



@end

@interface FeedBackCellModel : Model

@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSArray *picture_list;
@property (nonatomic, strong) NSString *reply_picture_list;
@property (nonatomic, strong) NSString *status;

@end

@interface SectionData : Model
{
    NSMutableArray *_array;// 每组的数据
    BOOL _isShow;// 组的状态，yes显示组，no不显示组
    NSString *_name;// 组名
    //  NSString *_typeName;
}

@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) BOOL isShow;
@property (nonatomic,assign) NSString *typeName;

- (instancetype)initWithName:(NSString *)name;

@end

@interface GuideOfServiceTableViewCellModel :Model

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic, strong) NSString *update_time;
@end

@interface NotificationAndAnnouncementModel : Model

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic, strong) NSString *update_time;
@end

