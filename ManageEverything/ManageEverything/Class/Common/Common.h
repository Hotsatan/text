//
//  Common.h
//  ManageEverything
//
//  Created by zz on 15/6/5.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define user_islogin @"user_islogin"


@interface Common : NSObject

#define IsIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7


//用户信息
+ (id)getUserInfo;
+ (id)getAccountANDpasswd;
+ (void)islogin;
+(void)saveUserInfo:(id)user;
+(BOOL)isUserLogin;

//退出账户
+ (void)loginOut;

//md5加密
+(NSString *)md5HexDigest:(NSString *)inPutText;
//32位加密
+ (NSString *)md5_32:(NSString *)str;

//获取用户Token
+(NSString *)getUserToken;
;

//计算字符串长度
+ (int)textLength:(NSString *)text;

+ (UINavigationController *)appRootViewController;

+ (UIImage *)scalImageOrientaiton:(UIImageOrientation)UIImageOrientation scalName:(NSString *)imageName;
@end
