//
//  NFMeViewController.m
//  guonongda
//
//  Created by guest on 16/8/29.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFMeViewController.h"
#import "UINavigationBar+Awesome.h"
#import "NFMeHeaderView.h"
#import "NFQRCodeReaderViewController.h"
#import "NFLoginViewController.h"
#import "NFNaviController.h"
#import "NFCardBaseViewController.h"
#import "NFPinViewController.h"
#import "NFNotificationViewController.h"

@interface NFMeViewController ()<UITableViewDelegate,UITableViewDataSource,NFMeHeaderViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, strong) NSArray *imageDatasource;
@property (nonatomic, strong) NFMeHeaderView *headerView;

@property (nonatomic, strong) UIView *redView;

@end

static NSString *const meCellIdentifier = @"meCellIdentifier";
@implementation NFMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self configureContent];
    [self configureNavi];
    
}

- (void)setData{
    NSArray *arrayOne = @[@"通知信息",@"我的收藏",@"晒单美图",@"我来掌柜"];
    NSArray *imageOne = @[@"person_message",@"person_fav",@"person_pic",@"person_shop"];

    NSArray *arrayTwo = @[@"帮助反馈",@"关于我们",@"分享有礼"];
    NSArray *imageTwo = @[@"person_help",@"person_app",@"person_share"];
    
    _datasource = @[arrayOne,arrayTwo];
    _imageDatasource = @[imageOne,imageTwo];
}


#pragma mark 设置导航栏

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = YES;
}

- (void)configureNavi{
    
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    naviView.backgroundColor = [UIColor clearColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 60, 34);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(13, 0, 0, 4);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:backButton];
    [self.view addSubview:naviView];
    
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    setButton.frame = CGRectMake(kScreenWidth - 60, 20, 60, 34);
    [setButton setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    setButton.imageEdgeInsets = UIEdgeInsetsMake(13, 0, 0, 4);
    [setButton addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:setButton];
    [self.view bringSubviewToFront:naviView];
    
}

- (void)setting{
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _headerView = [[NFMeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 258)];
    _headerView.delegate = self;
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 75)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kScreenWidth, 44);
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"客服电话：10109777" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom, kScreenWidth, 30)];
    label.text = @"服务时间：9:00-23:00";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:label];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = footerView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
}

- (void)callAction:(UIButton *)button{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"工作时间：每天9:00-21:00" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"呼叫：10109777" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"tel...");
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark headerView delegate
- (void)accountClickAction{
#warning TODO 判断是否已经登录
    NFLoginViewController *loginVc = [[NFLoginViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVc];
    [self.navigationController pushViewController:loginVc animated:YES];
//    [self presentViewController:navi animated:YES completion:nil];
}

- (void)itemClickAction:(NSNumber *)tag{
    NSLog(@"tag:%ld",[tag integerValue]);
    
    switch ([tag integerValue]) {
        case 0:{
            NFQRCodeReaderViewController *codeReaderVc = [[NFQRCodeReaderViewController alloc] init];
            [self.navigationController pushViewController:codeReaderVc animated:YES];
        }
            break;
        case 1:{
            NFCardBaseViewController *cardBaseVc = [[NFCardBaseViewController alloc] init];
            [self.navigationController pushViewController:cardBaseVc animated:YES];
        }
            break;
        case 2:{
            NFPinViewController *pinVc = [[NFPinViewController alloc] init];
            [self.navigationController pushViewController:pinVc animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datasource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:meCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:meCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.section == 0 && indexPath.row == 0) {
            _redView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 17, 10, 10)];
            _redView.layer.cornerRadius = 5;
            _redView.layer.masksToBounds = YES;
            
            _redView.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:_redView];
        }
    }
    
    cell.textLabel.text = _datasource[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_imageDatasource[indexPath.section][indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == _datasource.count - 1) {
        return 10;
    }
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                _redView.hidden = YES;
                NFNotificationViewController *notificationVc = [[NFNotificationViewController alloc] init];
                [self.navigationController pushViewController:notificationVc animated:YES];
            
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
                
            default:
                break;
        }
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
                
            default:
                break;
        }
    }
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
