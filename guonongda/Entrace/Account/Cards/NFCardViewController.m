//
//  NFCardViewController.m
//  guonongda
//
//  Created by guest on 16/10/10.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFCardViewController.h"
#import "NFCardCell.h"
@interface NFCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@end

static NSString *const cardCellIdentifier = @"cardCellIdentifier";
@implementation NFCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBaseBackgroundColor;
    
    [self setupTableView];
    
}


- (void)setupTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 145;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"NFCardCell" bundle:nil] forCellReuseIdentifier:cardCellIdentifier];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 108, 0);
    [self.view addSubview: _tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NFCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cardCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
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
