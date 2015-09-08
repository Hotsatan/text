//
//  NetWorkHandler.h
//  ConvenienceLife
//
//  Created by zz on 15/5/27.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteHandler) (id content);
@interface NetWorkHandler : NSObject

@property (nonatomic,copy) CompleteHandler completeHandle;

+ (void)requestPostDict:(NSDictionary *)dict url:(NSString *)url completeHandler:(CompleteHandler)completeHandler;

//帐号登录
+ (void)loginParams:(NSDictionary *)params completionHandler:(CompleteHandler)completion;

//修改密码
+ (void)changePasswdParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//注册
+ (void)registerVipParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;


//获取百姓绑定的房屋信息
+ (void)getPeopleParams:(NSDictionary *)params completionHandler:(CompleteHandler)completion;;

//获取意见反馈
+ (void)feedbackgetFeedbackParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;
//提交意见反馈
+ (void)feedbacksubmitFeedbackParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//办事指南
+ (void)guideServiceWithParams:(NSDictionary *)params completionHandle:(void(^)(id content))completion;

//办事指南详情
+ (void)guideServiceOfDetailsWithParams:(NSDictionary *)params completionHandle:(void(^)(id content))completion;

//百姓公告详细

+ (void)notificationAndAnnouncementWithParams:(NSDictionary *)params completionHandle:(void(^)(id content))completion;

//百姓公告列表

+ (void)notificationAndAnnouncementOfDetailsWithParams:(NSDictionary *)params completionHandle:(void(^)(id content))completion;
@end
