//
//  NFForgetPWViewController.m
//  fram
//
//  Created by guest on 16/7/6.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFForgetPWViewController.h"
#import "NFGetPWViewController.h"


@interface NFForgetPWViewController ()
@property (nonatomic, strong) UITextField *telTF;
@end

@implementation NFForgetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    
    [self setupContent];
}

- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    titleLabel.text = @"忘记密码";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(0, 0, 70, 30);
    [registButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [registButton setTitle:@"下一步" forState:UIControlStateNormal];
    [registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registButton.contentEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    registButton.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:registButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)setupContent{
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
    
    UILabel *remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _telTF.bottom + 10, kScreenWidth, 20)];
    remindLabel.text = @"请输入注册过的手机号，点击下一步收取验证码";
    remindLabel.font = [UIFont systemFontOfSize:13];
    remindLabel.textAlignment = NSTextAlignmentCenter;
    remindLabel.textColor = [UIColor grayColor];
    [self.view addSubview:remindLabel];

}


- (void)nextAction{
    if (![NFUtils isMobileNumber:_telTF.text]) {
        NSLog(@"请输入正确的手机号");
        UIAlertController *alert = [NFUtils creatAlertWithMessage:@"请输入正确的手机号"];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    NFGetPWViewController *getPW = [[NFGetPWViewController alloc] init];
    getPW.phoneNum = _telTF.text;
    [self.navigationController pushViewController:getPW animated:YES];
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
