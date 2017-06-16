//
//  NFFarmViewController.m
//  guonongda
//
//  Created by guest on 16/8/29.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFFarmViewController.h"
//#import "NFShopViewController.h"
#import "DOPDropDownMenu.h"
#import "NFFarmTableViewCell.h"
#import "NFFarmDetailViewController.h"

@interface NFFarmViewController ()<DOPDropDownMenuDelegate,DOPDropDownMenuDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) DOPDropDownMenu *menu;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *datasource;

//筛选
@property (nonatomic, strong) NSArray *choices;
//地区
@property (nonatomic, strong) NSArray *areas;
//排序
@property (nonatomic, strong) NSArray *sorts;


@end


static NSString *const farmTableViewCellId = @"farmTableViewCellId";
@implementation NFFarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor brownColor];

    [self configureMenu];
    
    [self configureContent];
    
    
    
    
}
- (void)configureMenu{
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    // 数据
    self.areas = @[@"全城",@"柯桥区",@"越城区",@"上虞区",@"新昌区",@"嵊州区",@"诸暨区"];
    self.sorts = @[@"默认排序",@"离我最近",@"好评优先",@"人气优先"];
    self.choices = @[@"筛选",@"折扣",@"优惠券",@"可预约",@"亲子"];
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    menu.textSelectedColor = kBaseColor;
    
    [self.view addSubview:menu];
    self.menu = menu;
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    [menu selectDefalutIndexPath];
    
    

}
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.areas.count;
    }else if (column == 1){
        return self.sorts.count;
    }else {
        return self.choices.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.areas[indexPath.row];
    } else if (indexPath.column == 1){
        return self.sorts[indexPath.row];
    } else {
        return self.choices[indexPath.row];
    }
}
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
#warning TODO 在这里调用网络请求的方法
    if(indexPath.column == 0){
        NSLog(@"%@" ,self.areas[indexPath.row]);
    }else if(indexPath.column == 1){
        NSLog(@"%@" ,self.sorts[indexPath.row]);
    }else{
        NSLog(@"%@" ,self.choices[indexPath.row]);
    }
}




#pragma mark 设置内容
- (void)configureContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _menu.bottom, kScreenWidth, kScreenHeight - _menu.bottom) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"NFFarmTableViewCell" bundle:nil] forCellReuseIdentifier:farmTableViewCellId];
    _tableView.rowHeight = 270;
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
//    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NFFarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:farmTableViewCellId forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NFFarmDetailViewController *farmDeatilVc = [[NFFarmDetailViewController alloc] init];
    [self.navigationController pushViewController:farmDeatilVc animated:YES];
}

//给cell添加动画效果
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layer.transform = CATransform3DMakeScale(0.6, 0.6, 1);
    cell.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.20 animations:^{
        cell.layer.transform = CATransform3DIdentity;
    }];
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
