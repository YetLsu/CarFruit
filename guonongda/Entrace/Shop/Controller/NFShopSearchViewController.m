//
//  NFShopSearchViewController.m
//  guonongda
//
//  Created by guest on 16/9/18.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopSearchViewController.h"
#import "NFHotSearchCell.h"
#import "NFDatabase.h"
#import "NFNearShopCell.h"
#import "NFShopDetailViewController.h"

#define kCollectionViewHeight 80
@interface NFShopSearchViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSMutableArray *tagsWidth;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NFDatabase *database;
@property (nonatomic, strong) UITextField *field;

@property (nonatomic, strong) UITableView *resultTableView;
@property (nonatomic, strong) NSMutableArray *resultDatasource;

@property (nonatomic, strong) UIView *maskView;
@end

static NSString *const hotSearchCellIdentifier = @"hotSearchCellIdentifier";
static NSString *const resultCellIdentifier = @"resultCellIdentifier";
@implementation NFShopSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    [self setupNavi];
    
    [self setupContent];
    
    [self setupResultView];
}


- (NSMutableArray *)tagsWidth{
    if (_tagsWidth == nil) {
        _tagsWidth = [NSMutableArray array];
    }
    return _tagsWidth;
}

- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}


#pragma mark 设置数据
- (void)setupData{
    NSArray *tags = @[@"先锋水果店",@"乐思蜀",@"疏木果业店",@"御品果业店",@"果蔬坊",@"果真不一样",@"每日鲜果园"];
    self.tags = tags;
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attrDict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#666666"];
    for (NSString *tag in tags) {
        CGRect rect = [tag boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil];
        CGFloat tagWidth = rect.size.width;
        [self.tagsWidth addObject:@(tagWidth)];
    }
    
    _database = [NFDatabase database];
    _datasource =[NSMutableArray arrayWithArray: [_database selectSearchHistory]];
}


#pragma mark 设置导航栏
- (void)setupNavi{
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 40, 40);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    searchButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*0.7, 25)];
    field.layer.cornerRadius = 3;
    field.layer.masksToBounds = YES;
    field.font = [UIFont systemFontOfSize:14];
    field.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [UIImage imageNamed:@"seach"];
    field.leftViewMode = UITextFieldViewModeAlways;
    field.leftView = imageView;
    field.placeholder = @"请输入商家名称";
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.navigationItem.titleView = field;
    self.field = field;
    self.field.delegate = self;
//    [self.field becomeFirstResponder];
}





#pragma mark 设置view内容
- (void)setupContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40 + kCollectionViewHeight)];
    headerView.backgroundColor = kBaseBackgroundColor;
    
    UILabel *hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 40)];
    hotLabel.text = @"大家都在搜";
    hotLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    hotLabel.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:hotLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, hotLabel.bottom, kScreenWidth, kCollectionViewHeight)collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[NFHotSearchCell class] forCellWithReuseIdentifier:hotSearchCellIdentifier];
    [headerView addSubview:_collectionView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headerView;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

#pragma mark 设置搜索结束的视图
- (void)setupResultView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headerView.backgroundColor = kBaseBackgroundColor;
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 40)];
    headerLabel.text = @"搜索结果";
    headerLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    headerLabel.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:headerLabel];
    
    _resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _resultTableView.tableHeaderView = headerView;
    _resultTableView.delegate = self;
    _resultTableView.dataSource = self;
    _resultTableView.rowHeight = 140;
    [_resultTableView registerNib:[UINib nibWithNibName:@"NFNearShopCell" bundle:nil] forCellReuseIdentifier:resultCellIdentifier];
    _resultTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_resultTableView];
    _resultTableView.hidden = YES;
}


#pragma mark 搜索请求方法
- (void)searchAction:(UIButton *)sender{
#warning TODO
    NSLog(@"search");
    if(_field.text.length == 0){
        return;
    }
    
    [_field resignFirstResponder];
    [_database addSearchShopName: _field.text];
    [_datasource addObject:_field.text];
    _tableView.hidden = YES;
    _resultTableView.hidden = NO;
}


#pragma mark 大家都在搜的collection view
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NFHotSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotSearchCellIdentifier forIndexPath:indexPath];
    cell.tagLabel.text = _tags[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [self.tagsWidth[indexPath.row] floatValue];
    return CGSizeMake(width + 20, 25);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
#warning TODO 跳转到店铺内页
    NSString *tag = _tags[indexPath.row];
    NSLog(@"%@",tag);
}

#pragma mark tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
        return _datasource.count;
    }
    
//    return _datasource.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.imageView.image = [UIImage imageNamed:@"seach"];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 43, kScreenWidth-30, 1)];
            line.backgroundColor = kBaseBackgroundColor;
            [cell.contentView addSubview:line];
        }
//        cell.textLabel.text = @"乐思蜀";
        cell.textLabel.text = _datasource[indexPath.row];
        
        return cell;
    }else if(tableView == _resultTableView){
        NFNearShopCell *cell = [tableView dequeueReusableCellWithIdentifier:resultCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
#warning TODO 这里发送网络请求，和搜索按钮一样
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }else if (tableView == _resultTableView){
#warning TODO 这里跳转到店的内页
        NFShopDetailViewController *shopDetailVc = [[NFShopDetailViewController alloc] init];
        [self.navigationController pushViewController:shopDetailVc animated:YES];
    }

}

#pragma mark 设置头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _resultTableView) {
        return nil;
    }
    if (_datasource.count == 0) {
        return nil;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headerView.backgroundColor = kBaseBackgroundColor;
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 40)];
    headerLabel.text = @"搜索记录";
    headerLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    headerLabel.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:headerLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _resultTableView) {
        return 0;
    }
    if (_datasource.count == 0) {
        return 0;
    }
    return 40;
}
#pragma mark 设置尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == _resultTableView) {
        return nil;
    }
    if (_datasource.count == 0) {
        return nil;
    }
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.backgroundColor = [UIColor whiteColor];
    clearButton.frame = CGRectMake(0, 0, kScreenWidth, 40);
    [clearButton addTarget:self action:@selector(clearHistoryAction) forControlEvents:UIControlEventTouchUpInside];
    [clearButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [clearButton setTitle:@"清空搜索记录" forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:@"seach_clean"] forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:13];
    clearButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [footerView addSubview:clearButton];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == _resultTableView) {
        return 0;
    }
    if (_datasource.count == 0) {
        return 0;
    }
    return 40;
}

#pragma mark 滑动让键盘退出
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_field resignFirstResponder];
}

#pragma mark 清空搜索记录
- (void)clearHistoryAction{
    NSLog(@"clear");
    [_database clearTableSearch];
    [_datasource removeAllObjects];
    [_tableView reloadData];
}

#pragma mark textfield 代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_resultTableView.hidden == NO) {
        NSUInteger length = textField.text.length;
        if (length == 1) {
            _resultTableView.hidden = YES;
            _tableView.hidden = NO;
            [_tableView reloadData];
        }
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    _resultTableView.hidden = YES;
    _tableView.hidden = NO;
    [_tableView reloadData];
    return YES;
}

#pragma mark view will disappear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_field becomeFirstResponder];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
