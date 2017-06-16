//
//  NFGiftViewController.m
//  guonongda
//
//  Created by guest on 16/10/10.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFGiftViewController.h"
#import "NFGiftDetailViewController.h"
#import "NFGiftCell.h"
#import "NFGiftedCell.h"
#import "NFCodeView.h"
@interface NFGiftViewController ()<UITableViewDataSource,UITableViewDelegate,NFGiftCellDelegate,NFGiftedCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSArray *sectionName;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NFCodeView *exchangeView;

@end


static NSString *const giftCellIdentifier = @"giftCellIdentifier";
static NSString *const giftedCellIdentifier = @"giftedCellIdentifier";
@implementation NFGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBaseBackgroundColor;
    [self setupData];
    [self setupContent];
}

- (void)setupData{
    _sectionName = @[@"已激活优惠券",@"未激活优惠券"];
}
- (void)setupContent{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 110;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 108, 0);
    [self.view addSubview: _tableView];
    
    _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.7];
    _maskView.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_maskView addGestureRecognizer:tap];
    [self.view addSubview:_maskView];
    
    _exchangeView = [[[NSBundle mainBundle] loadNibNamed:@"NFCodeView" owner:nil options:nil] lastObject];
    _exchangeView.x = 15;
    _exchangeView.y = kScreenHeight*0.2;
    _exchangeView.hidden = YES;
    [self.view addSubview:_exchangeView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 + section;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        [tableView registerNib:[UINib nibWithNibName:@"NFGiftCell" bundle:nil] forCellReuseIdentifier:giftCellIdentifier];
        NFGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:giftCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1){
        [tableView registerNib:[UINib nibWithNibName:@"NFGiftedCell" bundle:nil] forCellReuseIdentifier:giftedCellIdentifier];
        NFGiftedCell *cell = [tableView dequeueReusableCellWithIdentifier:giftedCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
        return cell;
    }
    
    return nil;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    headerView.backgroundColor = kBaseBackgroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 35)];
    label.text = _sectionName[section];
    label.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:label];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

#pragma mark - 兑换
- (void)cell:(NFGiftCell *)cell exchangeWithPrice:(NSString *)price{
    NSLog(@"%@",price);
    _maskView.hidden = NO;
    _exchangeView.hidden = NO;
}

#pragma mark - tap action
- (void)tapAction:(UITapGestureRecognizer *)tap{
    _maskView.hidden = YES;
    _exchangeView.hidden = YES;
}

#pragma mark - 查看
- (void)lookOverWithCell:(NFGiftedCell *)cell{
    NFGiftDetailViewController *giftDetailVc = [[NFGiftDetailViewController alloc] init];
    [self.navigationController pushViewController:giftDetailVc animated:YES];
    
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
