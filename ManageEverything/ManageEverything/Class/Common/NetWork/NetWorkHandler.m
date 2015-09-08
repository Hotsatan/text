//
//  NetWorkHandler.m
//  ConvenienceLife
//
//  Created by zz on 15/5/27.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "NetWorkHandler.h"
#import "AFNetworking.h"

@implementation NetWorkHandler

+ (void)requestPostDict:(NSDictionary *)dict url:(NSString *)url completeHandler:(CompleteHandler)completeHandler {
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //Server那邊的人有可能沒把head內的 meta的content格式指定好 完整的head
//    manager.requestSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//     [manager.requestSerializer setValue:@"MDAwMDAwMDAwMH292Wd-h62bg5mibw" forHTTPHeaderField:@"people_id"];
    
    
    if ([Common getUserInfo] && [[Common getUserInfo] isKindOfClass:[NSDictionary class]] && ((NSDictionary *)[Common getUserInfo]).count > 0) {
        NSString *string = [[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]] mutableCopy];
        [manager.requestSerializer setValue:string forHTTPHeaderField:@"people_id"];
    }
    
    
    [manager POST:URL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completeHandler(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@",error);
        NSLog(@"operation:%@",operation.responseString);
    }];
}

//+ (void)serviceImageWithMothedName:(NSString *)mothedName params:(NSDictionary *)params imageDatas:(NSArray *)imageDatas name:(NSArray *)name fileNames:(NSArray *)fileNames mimeType:(NSString *)mimeType succeed:(void (^)(id response))successBlock fail:(void (^)(void))failBlock
//{
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];
//    
//    AFHTTPRequestOperation *operation = [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,mothedName] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        if (imageDatas.count ==0) {
//            return ;
//        }
//        for (int i = 0; i < imageDatas.count; i ++) {
//            [formData appendPartWithFileData:imageDatas[i] name:name[i] fileName:fileNames[i] mimeType:mimeType];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        successBlock(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"responseString == %@",operation.responseString);
//        
////        //失败的返回
////        [RequestData reachability:error];
////        failBlock();
//    }];
//    //获得上传进度
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        NSLog(@"上传进度:%f",totalBytesWritten*1.0/totalBytesExpectedToWrite);
//    }];
//
//}

+ (void)feedBackParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseUrl,Url_feedBack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //Server那邊的人有可能沒把head內的 meta的content格式指定好 完整的head
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    NSLog(@"%@",URL);
    
//    [ manager.requestSerializer setValue:[Common getUserInfo][@"token"] forHTTPHeaderField:@"token"];
//    [manager.requestSerializer setValue:@"6UEJSM1KQZBU4WHZ" forHTTPHeaderField:@"serial"];
//    [ manager.requestSerializer setValue:@"ios"forHTTPHeaderField:@"OS_VERSION"];
//    [ manager.requestSerializer setValue:@"1.0.0" forHTTPHeaderField:@"APP_VERSION"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];
    
    if ([Common getUserInfo] && [[Common getUserInfo] isKindOfClass:[NSDictionary class]] && ((NSDictionary *)[Common getUserInfo]).count > 0) {
        NSString *string = [[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]] mutableCopy];
        [manager.requestSerializer setValue:string forHTTPHeaderField:@"people_id"];
    }
    
    
    NSMutableDictionary *dict  = [params mutableCopy];
    NSLog(@"%@",dict);
   
    [dict removeObjectForKey:@"images"];
    NSMutableArray *dataArray = [NSMutableArray array];
    NSLog(@"%@",dict);
    AFHTTPRequestOperation *operation = [manager POST:URL parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
//        for (UIImage *image in params[@"images"]) {
//            NSData *data = UIImageJPEGRepresentation(image, 0.1);
//            
//            [formData appendPartWithFileData :data name:@"images" fileName:@"images.png" mimeType:@"image/jpeg"];
////            NSLog(@"fordata:%@",formData);
//        }
//        
        
        for (UIImage *image in params[@"images"]) {
            NSData *data = UIImageJPEGRepresentation(image, 0.1);
            [dataArray addObject:data];
        }
        

        for (int i = 0; i < dataArray.count; i ++) {
            [formData appendPartWithFileData:dataArray[i] name:@"n[]" fileName:[NSString stringWithFormat:@"img_%d.jpg",i] mimeType:@"image/jpeg"];
            
        }
//        UIImage *image = [UIImage imageNamed:@"adImage"];
//        NSData *data = UIImageJPEGRepresentation(image, 0.1);
//        [formData appendPartWithFileData:data name:@"haha" fileName:@"haha" mimeType:@"image/jpeg"];
//        
    } success:^(AFHTTPRequestOperation *operation,id responseObject) {
        
        NSLog(@"Success: %@", responseObject);
        completion(responseObject);
        NSLog(@"----%@",responseObject[@"data"]);
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"Error: %@", error);
//        NSDictionary *dict = @{net_status : @"404",
//                               net_message : @"网络不可用,请检查网络"};
        completion(dict);
        
    }];
    
    //获得上传进度
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"上传进度:%f",totalBytesWritten*1.0/totalBytesExpectedToWrite);
    }];

    
}

//登录

+ (void)loginParams:(NSDictionary *)params completionHandler:(CompleteHandler)completion {
    
    [self requestPostDict:params url:Url_login completeHandler:completion];
}

+ (void)getPeopleParams:(NSDictionary *)params completionHandler:(CompleteHandler)completion {
    
    [self requestPostDict:params url:Url_houseMessage completeHandler:completion];
}
//我要吐槽 反馈信息提交
+ (void)feedbacksubmitFeedbackParams:(NSDictionary *)params completionHandler:(void (^)(id))completion {
    
    [self feedBackParams:params completionHandler:completion];
}

+(void)feedbackgetFeedbackParams:(NSDictionary *)params completionHandler:(void (^)(id))completion {
    
     [self requestPostDict:params url:Url_getfeedBack completeHandler:completion];
}

//办事指南
+ (void)guideServiceWithParams:(NSDictionary *)params completionHandle:(void(^)(id))completion {
    
    [self requestPostDict:params url:Url_service_guide completeHandler:completion];
}


//办事指南详情
+ (void)guideServiceOfDetailsWithParams:(NSDictionary *)params completionHandle:(void(^)(id))completion {
    
    [self requestPostDict:params url:Url_detail_service_guide completeHandler:completion];

    
}


//百姓公告列表
+ (void)notificationAndAnnouncementWithParams:(NSDictionary *)params completionHandle:(void (^)(id))completion {
    
     [self requestPostDict:params url:Url_people_notice completeHandler:completion];
}

//百姓公告详细

+ (void)notificationAndAnnouncementOfDetailsWithParams:(NSDictionary *)params completionHandle:(void (^)(id))completion {
    
     [self requestPostDict:params url:Url_shwo_people_notice completeHandler:completion];
}
//注册
+ (void)registerVipParams:(NSDictionary *)params completionHandler:(void (^)(id))completion {
    
    
}

//修改密码
+ (void)changePasswdParams:(NSDictionary *)params completionHandler:(void (^)(id))completion {
    
    
}

@end

