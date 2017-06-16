//
//  NFAddCardViewController.m
//  guonongda
//
//  Created by guest on 16/10/13.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFAddCardViewController.h"

#define kOwnerViewHeight 80

@interface NFAddCardViewController ()
//@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *cardNum;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *numTF;
@end

@implementation NFAddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    
    [self setupContent];
}

- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    titleLabel.text = @"添加会员卡";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}

- (void)setupContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 15 + 64, kScreenWidth, 20)];
    label.text = @"请绑定持卡人本人的卡号";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    
    UIView *ownerView = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom + 12, kScreenWidth, kOwnerViewHeight)];
    ownerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ownerView];
#warning TODO
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, kOwnerViewHeight/2)];
    _nameTF.placeholder = @"持卡人";
    _nameTF.backgroundColor = [UIColor whiteColor];
    UIImageView *nameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    nameImageView.contentMode = UIViewContentModeCenter;
    nameImageView.image = [UIImage imageNamed:@"addcard_name"];
    _nameTF.leftViewMode = UITextFieldViewModeAlways;
    _nameTF.leftView = nameImageView;
    [ownerView addSubview:_nameTF];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15, _nameTF.bottom - 1, kScreenWidth - 30, 1)];
    line1.backgroundColor = kBaseBackgroundColor;
    [ownerView addSubview:line1];
    
    _numTF = [[UITextField alloc] initWithFrame:CGRectMake(15, line1.bottom, kScreenWidth - 30, kOwnerViewHeight/2)];
    _numTF.placeholder = @"卡号";
    _numTF.backgroundColor = [UIColor whiteColor];
    UIImageView *numImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    numImageView.contentMode = UIViewContentModeCenter;

    numImageView.image = [UIImage imageNamed:@"addcard_No"];
    _numTF.leftViewMode = UITextFieldViewModeAlways;
    _numTF.leftView = numImageView;
//  添加扫描的按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 30);
    [button addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"gift_sao2"] forState:UIControlStateNormal];
    _numTF.rightView = button;
    _numTF.rightViewMode = UITextFieldViewModeAlways;
    [ownerView addSubview:_numTF];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(15, ownerView.bottom + 30, kScreenWidth - 30, 45);
    addButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [addButton setBackgroundImage:[UIImage imageNamed:@"add_check_botton1"] forState:UIControlStateNormal];
    [addButton setTitle:@"提交审核" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];

    
}

#pragma mark - 扫描按钮
- (void)scanAction{
    NSLog(@"扫描。。。");
}
- (void)addAction{
    NSLog(@"提交。。");
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
