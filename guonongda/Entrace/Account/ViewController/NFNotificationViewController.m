//
//  NFNotificationViewController.m
//  guonongda
//
//  Created by guest on 16/11/7.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFNotificationViewController.h"

@interface NFNotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation NFNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContent];
}

- (void)setupContent{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
    titleLabel.text = @"消息中心";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;

    self.view.backgroundColor = kBaseBackgroundColor;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    UILabel *timeLabel = nil;
    UILabel *contentLabel = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.textColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:timeLabel];
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, timeLabel.bottom + 10, kScreenWidth-30, 20)];
        contentLabel.font = [UIFont systemFontOfSize:15];
        contentLabel.textColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
        [cell.contentView addSubview:contentLabel];
    }
    timeLabel.text = [NFUtils getCurrentTime];
    contentLabel.text = @"恭喜你完成任务，请及时兑换红包";
    return cell;
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
