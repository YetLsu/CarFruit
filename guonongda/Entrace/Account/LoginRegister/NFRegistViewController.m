//
//  NFRegistViewController.m
//  fram
//
//  Created by guest on 16/7/5.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFRegistViewController.h"
#import <SMS_SDK/SMSSDK.h>

#define kRegisterBaseUrl @"http://chen.pgy198.com/index.php/app/user/registerbyphone"
@interface NFRegistViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *telTF;
@property (nonatomic, strong) UITextField *verifyTF;
@property (nonatomic, strong) UIButton *verifyButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

@end

@implementation NFRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"注册";
//    self.title = @"用户登录";
    [self setupNavi];
    [self setupContent];
    
}

- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    titleLabel.text = @"注册";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

}

- (void)setupContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    
    _telTF = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth - 300)*0.5, 64 + 20, 300, 30)];
    _telTF.placeholder = @"请输入您的手机号";
    _telTF.font = [UIFont systemFontOfSize:16];
    _telTF.keyboardType = UIKeyboardTypeNumberPad;
    _telTF.clearsOnBeginEditing = YES;
    _telTF.delegate = self;
    [self.view addSubview:_telTF];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(_telTF.x, _telTF.bottom, _telTF.width, 1)];
    line1.backgroundColor = [UIColor colorWithRed:0.7183 green:0.7183 blue:0.7183 alpha:1.0];
    [self.view addSubview:line1];
    
    _verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _verifyButton.frame = CGRectMake(_telTF.right-100, _telTF.y, 100, 30);
    [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifyButton setTitle:@"30s后重试" forState:UIControlStateDisabled];
    [_verifyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_verifyButton addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    _verifyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_verifyButton];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(_verifyButton.x - 2, _telTF.y, 1, _telTF.height)];
    line3.backgroundColor = [UIColor colorWithRed:0.7183 green:0.7183 blue:0.7183 alpha:1.0];
    [self.view addSubview:line3];
    
    
    
    _verifyTF = [[UITextField alloc] initWithFrame:CGRectMake(_telTF.x, _telTF.bottom + 15, _telTF.width, 30)];
    _verifyTF.placeholder = @"请填写验证码";
    _verifyTF.font = [UIFont systemFontOfSize:16];
    _verifyTF.keyboardType = UIKeyboardTypeNumberPad;
//    _verifyTF.clearsOnBeginEditing = YES;
    [self.view addSubview:_verifyTF];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(_telTF.x, _verifyTF.bottom, _verifyTF.width, 1)];
    line2.backgroundColor = [UIColor colorWithRed:0.7183 green:0.7183 blue:0.7183 alpha:1.0];
    [self.view addSubview:line2];
    
    UILabel *remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(_telTF.x, _verifyTF.bottom + 12, 200, 20)];
//    remindLabel.text = @"点击注册，即表示您同意用户协议";
    
    remindLabel.text = @"点击注册，即表示您同意用户协议";
    remindLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:remindLabel];
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(_telTF.x, remindLabel.bottom + 40, _telTF.width, 40);
    
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    
//    [registButton setTitle:@"登录" forState:UIControlStateNormal];
    registButton.backgroundColor = kBaseColor;
    [registButton addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
}

- (void)registClick{
    [SMSSDK commitVerificationCode:_verifyTF.text phoneNumber:_telTF.text zone:@"86" result:^(NSError *error) {
        if (!error) {
#warning TODO 注册成功接口接入
//            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//            parameters[@"phone"] = self.telTF.text;
//            [NFUtils postDataWithBaseURL:kRegisterBaseUrl parameters:parameters block:^(id data) {
//
//                
//            }];
            
        }else{
            NSLog(@"fail error %@",error);
//            [NFUtils createAlterViewWithMessage:@"验证码错误"];
            UIAlertController *alert = [NFUtils creatAlertWithMessage:@"验证码错误"];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];

}

- (void)getVerifyCode{
    NSString *phoneNum = _telTF.text;
    if (![NFUtils isMobileNumber:phoneNum]){
        NSLog(@"请输入正确的手机号");
//        [NFUtils createAlterViewWithMessage:@"请输入正确的手机号"];
        UIAlertController *alert = [NFUtils creatAlertWithMessage:@"请输入正确的手机号"];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    //发送短信验证
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_telTF.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"succ");
        }else{
            NSLog(@"error %@",error);
        }
    }];
    
    _verifyButton.enabled = NO;
    _time = 30;
    _telTF.enabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
   
}

- (void)timeAction{
    if (_time == 0) {
        [_timer invalidate];
        _verifyButton.enabled = YES;
        _telTF.enabled = YES;
        [_verifyButton setTitle:@"30s后重试" forState:UIControlStateDisabled];
    }else{
        _time--;
        NSString *str = [NSString stringWithFormat:@"%lds后重试",_time];
        [_verifyButton setTitle:str forState:UIControlStateDisabled];
    
    }

}

//如果验证码不为空，再来修改手机号的话，就清空验证码
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(self.verifyTF.text != nil){
        self.verifyTF.text = nil;
    }
    return YES;
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
