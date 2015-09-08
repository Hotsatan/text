//
//  DisplayView.h
//  LuZhouTong
//
//  Created by dqdeng on 14/12/12.
//  Copyright (c) 2014年 choice. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 -------弹出提示框文字---------
 */
//#define lognregist @"验证嘛已发送"
//#define @"手机号不能为空" @"验证码错误，请重新输入" @"请输入验证码" @"请输入密码" @"密码有6-18位，请重新输入" @"手机号码不能为空" @"手机号输入错误，请重新输入" @"该手机号还未注册，请重新输入" @"密码输入错误，请重新输入"
//@""

typedef enum : NSUInteger {
    registerA = 0, //@"验证嘛已发送"
    registerB = 1, //@"手机号不能为空"
    registerC = 2, //@"验证码错误，请重新输入"
    registerD = 3, //@"请输入验证码"
    registerE = 4, //@"请输入密码"
    registerF = 5, //@"密码有6-18位，请重新输入"
    
     loginA = 6,  //手机号码不能为空
     loginB = 7,  //手机号输入错误，请重新输入
     loginC = 8,  //该手机号还未注册，请重新输入
     loginD = 9,  //密码输入错误，请重新输入
    
    forgetA = 10, //验证码已发送
    forgetB = 11, //手机号码不能为空
    forgetC = 12, //该手机号还未注册，请重新输入
    forgetD = 13, //手机号输入错误，请重新输入
    forgetE = 14, //验证码错误，请重新输入
    forgetF = 15, //请输入验证码
    forgetG = 16, //密码有6-18位，请重新输入
  /*
    ------个人资料-------
   */
    personalA = 17, //头像上传成功
    personalB = 18, //头像上传成功
    personalC = 19, //保存成功
    personalD = 20, //确认放弃编辑？（按钮“确定”“继续编辑”）
    personalE = 21, //请输入新密码
    personalF = 22, //请再次输入新密码
    /*
     
     */

} AlertTypeString;
@interface DisplayView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) NSString *title;

- (void)disPlayShowType:(AlertTypeString)type;
+ (void)disPlayTitle:(NSString *)title;
+ (void)hideTitle;
+ (void)disPlayShowWithTitle:(NSString *)title;
@end
