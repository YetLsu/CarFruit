//
//  TempPingppBuy.m
//  guonongda
//
//  Created by guest on 16/9/7.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "TempPingppBuy.h"
#import "Pingpp.h"

@interface TempPingppBuy ()
@property (nonatomic, copy) NSString *channel;
@end

@implementation TempPingppBuy

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContent];
    
}

- (void)setupContent{
    self.title = @"支付订单";
    
    
    NSArray *buyWays = @[@"支付宝支付",@"微信支付",@"银行卡支付"];
    for (int i=0; i< 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 100+60*i, kScreenWidth, 44);
        [button setTitle:buyWays[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor orangeColor];
        [button addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view addSubview:button];
    }
}

- (void)payAction:(UIButton *)button{
    NSInteger tag = button.tag;
    if(tag == 0){
        self.channel = @"alipay";
    }else if (tag == 1){
        self.channel = @"wx";
    }else if (tag == 2){
        self.channel = @"upacp";
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"channel"] = self.channel;
    parameters[@"amount"] = @(0.01);
    
    NSString *url = @"";
    UIViewController *__weak weakSelf = self;
    [NFUtils postDataWithBaseURL:url parameters:parameters block:^(id responseObject) {
        if (responseObject != nil) {
            
            [Pingpp createPayment:responseObject viewController:weakSelf appURLScheme:kUrlSchema withCompletion:^(NSString *result, PingppError *error) {
                NSLog(@"result : %@",result);
                if (error) {
                    NSLog(@"支付失败 %@",error);
                    
                }
                
            }];
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
