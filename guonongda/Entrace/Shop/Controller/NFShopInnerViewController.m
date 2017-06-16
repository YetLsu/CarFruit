//
//  NFShopInnerViewController.m
//  guonongda
//
//  Created by guest on 16/12/1.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopInnerViewController.h"
#import "NFGoodsCell.h"
#import "NFIntruduceCell.h"

@interface NFShopInnerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *imagesArray;
@end


static NSString *const intruduceIdentifierId = @"intruduceIdentifierId";

static NSString *const goodsIdentifierId = @"goodsIdentifierId";

@implementation NFShopInnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self setupNavi];
    [self setupContent];
}

- (void)requestData{
    _titlesArray = @[@"营业时间:",@"联系电话:",@"店铺地址:"];
    _imagesArray = @[@"store_opentime",@"store_call",@"store_location"];

}
- (void)setupNavi{
    
}

- (void)setupContent{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        [tableView registerNib:[UINib nibWithNibName:@"NFIntruduceCell" bundle:nil] forCellReuseIdentifier:intruduceIdentifierId];
        return _titlesArray.count;
    }else{
        [tableView registerNib:[UINib nibWithNibName:@"NFGoodsCell" bundle:nil] forCellReuseIdentifier:goodsIdentifierId];
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        NFIntruduceCell *intruduceCell = [tableView dequeueReusableCellWithIdentifier:intruduceIdentifierId forIndexPath:indexPath];
        if (indexPath.row == 0) {
            intruduceCell.contentLabel.text = @"10:00-21:00";
            intruduceCell.cellButton.hidden = YES;
            
        }else if (indexPath.row == 1){
            intruduceCell.contentLabel.text = @"15072467577";
            intruduceCell.cellButton.hidden = NO;
            [intruduceCell.cellButton setTitle:@"拨出" forState:UIControlStateNormal];
            [intruduceCell.cellButton setImage:[UIImage imageNamed:@"store_callout"] forState:UIControlStateNormal];
        }else if (indexPath.row == 2){
            intruduceCell.contentLabel.text = @"华齐路156号纺都大厦15楼";
            intruduceCell.cellButton.hidden = NO;
            [intruduceCell.cellButton setTitle:@"出发" forState:UIControlStateNormal];
            [intruduceCell.cellButton setImage:[UIImage imageNamed:@"store_goout"] forState:UIControlStateNormal];
        }
        intruduceCell.cellImageView.image = [UIImage imageNamed:_imagesArray[indexPath.row]];
        intruduceCell.beginLabel.text = _titlesArray[indexPath.row];
        return intruduceCell;
    }else{
        NFGoodsCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:goodsIdentifierId forIndexPath:indexPath];
        
        return goodsCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else
        return 105;
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
