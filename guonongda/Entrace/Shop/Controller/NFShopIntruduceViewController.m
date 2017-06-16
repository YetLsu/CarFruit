//
//  NFShopIntruduceViewController.m
//  meituan2
//
//  Created by guest on 16/9/6.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopIntruduceViewController.h"
#import "NFIntruduceCell.h"
#import "DSAlert.h"
#import "DSActionSheet.h"
#import "NFShopMapViewController.h"

#define kHeaderViewWidth 180
#define kFooterViewWidth 225

@interface NFShopIntruduceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat lastOffsetY;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *imagesArray;
@end

static NSString *const shopIntruduceId = @"shopIntruduceId";
@implementation NFShopIntruduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    
    [self setupContent];
    
}

- (void)setupData{
    _titlesArray = @[@"营业时间:",@"联系电话:",@"店铺地址:"];
    _imagesArray = @[@"store_opentime",@"store_call",@"store_location"];
}


- (void)setupContent{
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeaderViewWidth)];
    headerView.image = [UIImage imageNamed:@"2.png"];

    UIImageView *footerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFooterViewWidth)];
    footerView.image = [UIImage imageNamed:@"3.png"];

    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"NFIntruduceCell" bundle:nil] forCellReuseIdentifier:shopIntruduceId];
    _tableView.tableFooterView = footerView;
    _tableView.tableHeaderView = headerView;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 180, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    [self.view addSubview:_tableView];
}
#pragma mark 表视图的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NFIntruduceCell *cell = [tableView dequeueReusableCellWithIdentifier:shopIntruduceId forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.contentLabel.text = @"10:00-21:00";
        cell.cellButton.hidden = YES;
        
    }else if (indexPath.row == 1){
        cell.contentLabel.text = @"15072467577";
        cell.cellButton.hidden = NO;
        [cell.cellButton setTitle:@"拨出" forState:UIControlStateNormal];
        [cell.cellButton setImage:[UIImage imageNamed:@"store_callout"] forState:UIControlStateNormal];
    }else if (indexPath.row == 2){
        cell.contentLabel.text = @"华齐路156号纺都大厦15楼";
        cell.cellButton.hidden = NO;
        [cell.cellButton setTitle:@"出发" forState:UIControlStateNormal];
        [cell.cellButton setImage:[UIImage imageNamed:@"store_goout"] forState:UIControlStateNormal];
    }
    cell.cellImageView.image = [UIImage imageNamed:_imagesArray[indexPath.row]];
    cell.beginLabel.text = _titlesArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        NFIntruduceCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *tel = cell.contentLabel.text;
        NSString *telString = [NSString stringWithFormat:@"呼叫：%@",tel];
        [DSActionSheet ds_showActionSheetWithStyle:DSCustomActionSheetStyleTitle contentArray:@[telString] imageArray:nil redIndex:1 title:@"联系商家" ClikckButtonIndex:^(NSInteger index) {
            if (index == 0) {
                NSString *telnum = [NSString stringWithFormat:@"tel://%@",tel];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telnum]];
            }
        }];
    }else if (indexPath.row == 2){
        NFShopMapViewController *shopMapVc = [[NFShopMapViewController alloc] init];
        [self.navigationController pushViewController:shopMapVc animated:YES];
    
    }

}


//计算上滑还是下拉
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
