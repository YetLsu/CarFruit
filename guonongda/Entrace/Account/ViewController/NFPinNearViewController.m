//
//  NFPinNearViewController.m
//  guonongda
//
//  Created by guest on 16/11/1.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFPinNearViewController.h"
#import "NFPinNearCell.h"
#import "NFPinningViewController.h"

@interface NFPinNearViewController ()<UITableViewDelegate,UITableViewDataSource,NFPinNearCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@end

static NSString *const pinNearIdentifierId = @"pinNearIdentifierId";
@implementation NFPinNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContent];
    [self requestData];
}

- (void)setupContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 175;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"NFPinNearCell" bundle:nil] forCellReuseIdentifier:pinNearIdentifierId];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 108, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    [self.view addSubview:_tableView];
}

- (void)requestData{
    
}

#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NFPinNearCell *cell = [tableView dequeueReusableCellWithIdentifier:pinNearIdentifierId forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}
- (void)pinWithNearCell:(NFPinNearCell *)cell{
    NFPinningViewController *pinningVc = [[NFPinningViewController alloc] init];
    [self.navigationController pushViewController:pinningVc animated:YES];
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
