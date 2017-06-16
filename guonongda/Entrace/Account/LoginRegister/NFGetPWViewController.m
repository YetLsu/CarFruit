//
//  NFGetPWViewController.m
//  fram
//
//  Created by guest on 16/7/6.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFGetPWViewController.h"
#import <SMS_SDK/SMSSDK.h>
@interface NFGetPWViewController ()
@property (nonatomic, strong) UITextField *verifyTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *verifyButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;
@end

@implementation NFGetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"重置密码";
    [self setupContent];
    
//    [self timerStart];
    [self getVerifyCode];
    
    
}

- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    titleLabel.text = @"重置密码";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

}


- (void)setupContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    UILabel *showTelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 5, kScreenWidth, 20)];
    showTelLabel.text = [NSString stringWithFormat:@"我们已将验证码发送到%@",self.phoneNum];
    showTelLabel.textAlignment = NSTextAlignmentCenter;
    showTelLabel.font = [UIFont systemFontOfSize:13];
    showTelLabel.textColor = [UIColor grayColor];
    [self.view addSubview:showTelLabel];
    _verifyTF = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth - 300)*0.5, showTelLabel.bottom + 15, 300, 30)];
    _verifyTF.placeholder = @"请填写验证码";
    _verifyTF.font = [UIFont systemFontOfSize:14];
    _verifyTF.keyboardType = UIKeyboardTypeNumberPad;
//    _verifyTF.clearsOnBeginEditing = YES;
    [self.view addSubview:_verifyTF];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(_verifyTF.x, _verifyTF.bottom, _verifyTF.width, 1)];
    line1.backgroundColor = [UIColor colorWithRed:0.7183 green:0.7183 blue:0.7183 alpha:1.0];
    [self.view addSubview:line1];
    
    _verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _verifyButton.frame = CGRectMake(_verifyTF.right-100, _verifyTF.y, 100, 30);
    [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifyButton setTitle:@"30s后重试" forState:UIControlStateDisabled];
    [_verifyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_verifyButton addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    _verifyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _verifyButton.enabled = NO;
    [self.view addSubview:_verifyButton];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(_verifyButton.x - 2, _verifyTF.y, 1, _verifyTF.height)];
    line3.backgroundColor = [UIColor colorWithRed:0.7183 green:0.7183 blue:0.7183 alpha:1.0];
    [self.view addSubview:line3];
    
    
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(_verifyTF.x, _verifyTF.bottom + 15, _verifyTF.width, 30)];
    _passwordTF.placeholder = @"请填写密码，6-16位字符";
    _passwordTF.font = [UIFont systemFontOfSize:14];
    _passwordTF.secureTextEntry = YES;
//    _passwordTF.clearsOnBeginEditing = YES;
    [self.view addSubview:_passwordTF];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(_verifyTF.x, _passwordTF.bottom, _passwordTF.width, 1)];
    line2.backgroundColor = [UIColor colorWithRed:0.7183 green:0.7183 blue:0.7183 alpha:1.0];
    [self.view addSubview:line2];
    
//    UILabel *remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(_verifyTF.x, _passwordTF.bottom + 12, 200, 20)];
//    remindLabel.text = @"点击注册，即表示您同意用户协议";
//    remindLabel.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:remindLabel];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame = CGRectMake(_verifyTF.x, _passwordTF.bottom + 40, _verifyTF.width, 40);
    
    [resetButton setTitle:@"重置密码" forState:UIControlStateNormal];
    resetButton.backgroundColor = kBaseColor;
    [resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
}

- (void)timerStart{
    self.time = 30;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)timerAction{
    _time--;
    if (_time == 0) {
        [_timer invalidate];
        _verifyButton.enabled = YES;
        [_verifyButton setTitle:@"30s后重试" forState:UIControlStateDisabled];
    }else{
        NSString *str = [NSString stringWithFormat:@"%lds后重试",_time];
        [_verifyButton setTitle:str forState:UIControlStateDisabled];
    }
}


- (void)getVerifyCode{
    //发送短信验证
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNum zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"succ");
        }else{
            NSLog(@"error %@",error);
        }
    }];
    _verifyButton.enabled = NO;
    [self timerStart];

}

- (void)resetAction{
    if (_passwordTF.text.length == 0 || _passwordTF.text.length < 6 || _passwordTF.text.length > 16) {
        NSLog(@"密码长度必须在6到16之间");
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码长度必须在6到16之间" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//        [alterView show];
        UIAlertController *alert = [NFUtils creatAlertWithMessage:@"密码长度必须在6到16之间"];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [SMSSDK commitVerificationCode:_verifyTF.text phoneNumber:_phoneNum zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSLog(@"reset succ");
#warning TODO 重置密码成功
            
        }else{
            NSLog(@"fail error %@",error);
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码错误" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//            [alterView show];
            UIAlertController *alert = [NFUtils creatAlertWithMessage:@"验证码错误"];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }];
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
