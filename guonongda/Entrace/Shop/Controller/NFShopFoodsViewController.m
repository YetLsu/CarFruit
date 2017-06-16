
//
//  NFShopFoodsViewController.m
//  meituan2
//
//  Created by guest on 16/9/6.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopFoodsViewController.h"
#import "NFGoodsCell.h"

@interface NFShopFoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, assign) CGFloat lastOffsetY;
@end

static NSString *const goodsCellIdentifierId = @"goodsCellIdentifierId";
@implementation NFShopFoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    [self setupContent];
}

- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

#pragma mark 请求数据
- (void)setupData{
    

}
#pragma mark 设置内容
- (void)setupContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 180, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    _tableView.rowHeight = 105;
    [_tableView registerNib:[UINib nibWithNibName:@"NFGoodsCell" bundle:nil] forCellReuseIdentifier:goodsCellIdentifierId];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

#pragma mark 表视图代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NFGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCellIdentifierId forIndexPath:indexPath];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_lastOffsetY - scrollView.contentOffset.y < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shanghua" object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"xiahua" object:nil];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _lastOffsetY = scrollView.contentOffset.y;
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
