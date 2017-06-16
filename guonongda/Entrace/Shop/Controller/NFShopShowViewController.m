//
//  NFShopShowViewController.m
//  meituan2
//
//  Created by guest on 16/9/6.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopShowViewController.h"
#import "NFShowCell.h"



@interface NFShopShowViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, assign) CGFloat lastOffsetY;
@end


static NSString *const showCellIdentifierId = @"showCellIdentifierId";
@implementation NFShopShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContent];
    
}

- (void)setupContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenWidth - 30)/2, (kScreenWidth - 30)/2 + 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView registerNib:[UINib nibWithNibName:@"NFShowCell" bundle:nil] forCellWithReuseIdentifier:showCellIdentifierId];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 180, 0);
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview: _collectionView];
}


#pragma mark collectionView datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NFShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:showCellIdentifierId forIndexPath:indexPath];
    cell.shopShowImageView.image = [UIImage imageNamed:@"show"];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
}

#pragma mark 上滑下滑发送通知
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
