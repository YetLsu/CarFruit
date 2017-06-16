//
//  NFNewProViewController.m
//  guonongda
//
//  Created by guest on 16/9/29.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFNewProViewController.h"
#import "NFNewShopCell.h"

#define kCellWidth (kScreenWidth - 40)/3
@interface NFNewProViewController ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NFNewShopCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITextField *proNameTF;
@property (nonatomic, strong) UITextField *proPriceTF;
@property (nonatomic, strong) UITextView *publishReasonTV;
@property (nonatomic, strong) UILabel *publishLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@end

static NSString *const newProCellIdentifier = @"newProCellIdentifier";
@implementation NFNewProViewController

- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    [self setupContent];
    [self setupImagePicker];
}

-(void)setupImagePicker{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController.delegate = self;

}


- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
    titleLabel.text = @"发布商品";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.frame = CGRectMake(0, 2, 50, 40);
    [publishButton setTitle:@"发布" forState:UIControlStateNormal];
    [publishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishButton.titleLabel.font = [UIFont systemFontOfSize:16];
    publishButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [publishButton addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:publishButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupContent{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _proNameTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 16 + 64, kScreenWidth - 30, 44)];
    _proNameTF.placeholder = @"商品名称";
//    _proNameTF.borderStyle = UITextBorderStyleLine;
    _proNameTF.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_proNameTF];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15, _proNameTF.bottom, kScreenWidth - 30, 1)];
    line1.backgroundColor = kBaseBackgroundColor;
    [self.view addSubview:line1];
    
    
    _proPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(15, _proNameTF.bottom, kScreenWidth - 30, 44)];
    _proPriceTF.placeholder = @"商品价格";
    _proPriceTF.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_proPriceTF];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(15, _proPriceTF.bottom, kScreenWidth - 30, 1)];
    line2.backgroundColor = kBaseBackgroundColor;
    [self.view addSubview:line2];
    
    _publishReasonTV = [[UITextView alloc] initWithFrame:CGRectMake(15, _proPriceTF.bottom + 2, kScreenWidth - 30, 84)];
    _publishReasonTV.font = [UIFont systemFontOfSize:16];
    _publishLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 8, kScreenWidth, 20)];
    _publishLabel.textColor = [UIColor colorWithRed:202/255.0 green:202/255.0 blue:207/255. alpha:1];
    _publishLabel.text = @"发布理由";
    _publishLabel.font = [UIFont systemFontOfSize:16];
    [_publishReasonTV addSubview:_publishLabel];
    
    _publishReasonTV.delegate = self;
    [self.view addSubview:_publishReasonTV];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kCellWidth, kCellWidth + 15);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _publishReasonTV.bottom + 15, kScreenWidth, kCellWidth + 15) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[NFNewShopCell class] forCellWithReuseIdentifier:newProCellIdentifier];
    [self.view addSubview:_collectionView];

}

#pragma mark collectionView datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.datasource.count < 3) {
        return self.datasource.count + 1;
    }else{
        return 3;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NFNewShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:newProCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row == _datasource.count && _datasource.count < 3) {
        cell.shopImageView.image = [UIImage imageNamed:@"add_plus"];
        cell.deleteBtn.hidden = YES;
        
    }else {
        cell.shopImageView.image = _datasource[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.datasource.count == indexPath.row){
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

#pragma mark 拍照后的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [_imagePickerController dismissViewControllerAnimated:YES completion:nil];
    [self.datasource addObject:info[UIImagePickerControllerOriginalImage]];
    [_collectionView reloadData];
    
}

#pragma mark 删除照片
- (void)deleteThePhotoFromCell:(NFNewShopCell *)shopCell{
    UIImage *image = shopCell.shopImageView.image;
    [self.datasource removeObject:image];
    [_collectionView reloadData];
}

#pragma mark 用来给textView做placeholder
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        _publishLabel.text = @"发布理由";
    }else{
        _publishLabel.text = @"";
    }
    
}


#pragma mark 发布按钮
- (void)publishAction{

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
