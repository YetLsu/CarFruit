//
//  NFChooseCityViewController.m
//  guonongda
//
//  Created by guest on 16/10/12.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFChooseCityViewController.h"
#import "NFCityCell.h"
@interface NFChooseCityViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *hotCities;

@end


static NSString *const cityCellIdentifier = @"cityCellIdentifier";
static NSString *const headerIdentifier = @"headerIdentifier";
@implementation NFChooseCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    [self setupNavi];
    
    [self setupContent];
}

- (void)setupData{
    
    _hotCities = @[@"北京",@"上海",@"杭州",@"深圳",@"武汉",@"绍兴",@"广州",@"成都",@"珠海",@"厦门"];
}

- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"城市选择";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;

}

- (void)setupContent{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBaseBackgroundColor;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (kScreenWidth - 40)/3;
    CGFloat itemH = 40;
    
    layout.itemSize = CGSizeMake(itemW, itemH);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[NFCityCell class] forCellWithReuseIdentifier:cityCellIdentifier];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [self.view addSubview: _collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 1) {
        return _hotCities.count;
    }else
        return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)   collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NFCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cityCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = kBaseColor;
    if (indexPath.section == 0) {
        cell.city = _currentCity;
    }else{
        cell.city = _hotCities[indexPath.row];
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 30)];
    label.font = [UIFont systemFontOfSize:18];
    [reusableView addSubview:label];
    if (indexPath.section == 0) {
        label.text = @"当前城市";
    }else{
        label.text = @"热门城市";
    }
    return reusableView;
}

//头视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 30);
}

#pragma mark - 城市选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NFCityCell *cell = (NFCityCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(getCity:)]) {
        [self.delegate performSelector:@selector(getCity:) withObject:cell.city];
    }
    [self.navigationController popViewControllerAnimated:YES];

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
