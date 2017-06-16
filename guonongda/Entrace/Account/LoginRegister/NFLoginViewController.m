//
//  NFLoginViewController.m
//  fram
//
//  Created by guest on 16/7/5.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFLoginViewController.h"
#import "NFRegistViewController.h"
#import "NFForgetPWViewController.h"
#import "UINavigationBar+Awesome.h"

@interface NFLoginViewController ()

@property (nonatomic, strong) UITextField *telTF;
@property (nonatomic, strong) UITextField *passwordTF;

@end

@implementation NFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登陆";
    
    [self setupNavi];
    
    [self setupSubViews];
    
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//}
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//}


- (void)setupNavi{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    titleLabel.text = @"登录";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    button.frame = CGRectMake(0, 0, 70, 40);
//    [button addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
//    [button setImage:[UIImage imageNamed:@"add_delet"] forState:UIControlStateNormal];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem = leftItem;

    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(0, 0, 60, 30);
    [registButton addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registButton.contentEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 0);
    registButton.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:registButton];
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registAction)];
    
    self.navigationItem.rightBarButtonItem = rightItem;


}

- (void)setupSubViews{
    self.view.backgroundColor = kBaseBackgroundColor;
    _telTF = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth - 300)*0.5, 64 + 20, 300, 30)];
    _telTF.placeholder = @"请输入您的手机号";
    _telTF.font = [UIFont systemFontOfSize:14];
    _telTF.keyboardType = UIKeyboardTypeNumberPad;
    _telTF.clearsOnBeginEditing = YES;
    [self.view addSubview:_telTF];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(_telTF.x, _telTF.bottom, _telTF.width, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(_telTF.x, _telTF.bottom + 15, _telTF.width, 30)];
    _passwordTF.placeholder = @"请填写密码，6-16位字符";
    _passwordTF.font = [UIFont systemFontOfSize:14];
    _passwordTF.secureTextEntry = YES;
    _passwordTF.clearsOnBeginEditing = YES;
    [self.view addSubview:_passwordTF];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(_telTF.x, _passwordTF.bottom, _passwordTF.width, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line2];
    
//    UILabel *remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(_telTF.x, _passwordTF.bottom + 12, 200, 20)];
//    remindLabel.text = @"点击登陆，即表示您同意用户协议";
//    remindLabel.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:remindLabel];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(_telTF.x, line2.bottom + 60, _telTF.width, 40);
    
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    loginButton.backgroundColor = kBaseColor;
    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *forgetPW = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPW.frame = CGRectMake(kScreenWidth - 60 - loginButton.x - 20, loginButton.bottom + 5, 80, 20);
    [forgetPW setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPW setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    forgetPW.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetPW addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPW];
    
}

//- (void)closeClick{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

//登陆页面
- (void)loginClick{
    [self.view endEditing:YES];
    if (![NFUtils isMobileNumber:_telTF.text]) {
        NSLog(@"请输入正确的手机号");
//        [NFUtils createAlterViewWithMessage:@"请输入正确的手机号"];
        UIAlertController *alert = [NFUtils creatAlertWithMessage:@"请输入正确的手机号"];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }else if (_passwordTF.text.length < 6 || _passwordTF.text.length > 16){
//        [NFUtils createAlterViewWithMessage:@"密码长度在6到16之间"];
        UIAlertController *alert = [NFUtils creatAlertWithMessage:@"密码长度必须在6到16之间"];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
#warning TODO 
//    [self.view createDimBackgroundHUD];
    NSLog(@"login,%@,%@",_passwordTF.text,_telTF.text);
}
//注册页面
- (void)registAction{
    NFRegistViewController *registVc = [[NFRegistViewController alloc] init];
    [self.navigationController pushViewController:registVc animated:YES];
}

//忘记密码
- (void)forgetAction{
    NFForgetPWViewController *forgetPW = [[NFForgetPWViewController alloc] init];
    [self.navigationController pushViewController:forgetPW animated:YES];
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
