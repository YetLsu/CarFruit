//
//  NFShopWrongViewController.m
//  guonongda
//
//  Created by guest on 16/10/12.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopWrongViewController.h"
#import "NFNewShopCell.h"

#define kCellWidth (kScreenWidth - 40)/3
@interface NFShopWrongViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,NFNewShopCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITextField *shopNameTF;
@property (nonatomic, strong) UITextView *descTextView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
//照片数组
@property (nonatomic, strong) NSMutableArray *imagesArray;
//错误类型
@property (nonatomic, strong) NSArray *wrongTypes;
//遮罩视图
//@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
//@property (nonatomic, strong) UIButton *wrongTypeButton;

//表视图的frame
//@property (nonatomic, assign) CGRect tableViewFrame;
//表视图大小
//@property (nonatomic, assign) CGSize tableViewSize;
//@property (nonatomic, assign) BOOL isShow;
//选中的indexPath
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, copy) NSString *wrongString;
@end

static NSString *const shopWrongCellIdentifier = @"shopWrongCellIdentifier";
@implementation NFShopWrongViewController

- (NSMutableArray *)imagesArray{
    if (_imagesArray == nil) {
        _imagesArray = [NSMutableArray array];
        
    }
    return _imagesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBaseBackgroundColor;
    [self setupData];
    
    [self setupNavi];
    
    [self setupContent];
    
    [self setupImagePicker];
}

- (void)setupData{
    _wrongTypes = @[@"地理位置错误",@"倒闭",@"装修中",@"找不到"];
    _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _wrongString = _wrongTypes[0];
}

- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"店铺纠错";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.frame = CGRectMake(0, 2, 60, 40);
    [publishButton setTitle:@"提交" forState:UIControlStateNormal];
    [publishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishButton.titleLabel.font = [UIFont systemFontOfSize:18];
    publishButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [publishButton addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:publishButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupContent{
    _shopNameTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 64 + 10, kScreenWidth - 30, 44)];
    _shopNameTF.placeholder = @"店名";
    _shopNameTF.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_shopNameTF];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, _shopNameTF.bottom, kScreenWidth - 30, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    _descTextView = [[UITextView alloc] initWithFrame:CGRectMake(12, line.bottom, kScreenWidth-24, 90)];
    _descTextView.text = @"描述一下这家店";
    _descTextView.font = [UIFont systemFontOfSize:16];
    _descTextView.backgroundColor = kBaseBackgroundColor;
    [self.view addSubview:_descTextView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kCellWidth, kCellWidth + 15);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _descTextView.bottom + 15, kScreenWidth, kCellWidth + 15) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[NFNewShopCell class] forCellWithReuseIdentifier:shopWrongCellIdentifier];
    [self.view addSubview:_collectionView];
    
//    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(0, _collectionView.bottom + 10, kScreenWidth, 44)];
//    typeView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:typeView];
//    
//    
//    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 44)];
//    typeLabel.text = @"错误类型:";
//    typeLabel.font = [UIFont systemFontOfSize:16];
//    [typeView addSubview:typeLabel];
//    
//    _wrongTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _wrongTypeButton.frame = CGRectMake(typeLabel.right + 10, 0, kScreenWidth - typeLabel.right - 10, 44);
////    _wrongTypeButton.backgroundColor = [UIColor redColor];
//    [_wrongTypeButton addTarget:self action:@selector(showWrongTable) forControlEvents:UIControlEventTouchUpInside];
//    [_wrongTypeButton setTitle:@"地址错误" forState:UIControlStateNormal];
//    [_wrongTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_wrongTypeButton setImage:[UIImage imageNamed:@"downopen"] forState:UIControlStateNormal];
//    _wrongTypeButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    NSMutableDictionary *attriM = [NSMutableDictionary dictionary];
//    attriM[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    attriM[NSForegroundColorAttributeName] = [UIColor blackColor];
//    [typeView addSubview:_wrongTypeButton];
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(typeLabel.right + 10, typeView.bottom, 0, 0) style:UITableViewStylePlain];
//    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
//
//    _tableViewSize = CGSizeMake(kScreenWidth - typeLabel.right - 10, kScreenHeight - typeView.bottom - 10);
    
    UILabel *wrongLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _collectionView.bottom, kScreenWidth - 30, 40)];
    wrongLabel.text = @"请选择错误类型";
    wrongLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:wrongLabel];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, wrongLabel.bottom, kScreenWidth, 4*44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"add_check_botton1"] forState:UIControlStateNormal];
    commitButton.frame = CGRectMake(15, _tableView.bottom + 15, kScreenWidth - 30, 45);
    [commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
}

-(void)setupImagePicker{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController.delegate = self;
    
}

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.imagesArray.count < 3) {
        return self.imagesArray.count + 1;
    }else{
        return 3;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NFNewShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopWrongCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row == _imagesArray.count && _imagesArray.count < 3) {
        cell.shopImageView.image = [UIImage imageNamed:@"add_plus"];
        cell.deleteBtn.hidden = YES;
        
    }else {
        cell.shopImageView.image = _imagesArray[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.imagesArray.count == indexPath.row){
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

#pragma mark 拍照后的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [_imagePickerController dismissViewControllerAnimated:YES completion:nil];
    [self.imagesArray addObject:info[UIImagePickerControllerOriginalImage]];
    [_collectionView reloadData];
}

#pragma mark 删除照片
- (void)deleteThePhotoFromCell:(NFNewShopCell *)shopCell{
    UIImage *image = shopCell.shopImageView.image;
    [self.imagesArray removeObject:image];
    [_collectionView reloadData];
}

#pragma mark tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _wrongTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        
    }
    if (_selectedIndexPath == indexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = _wrongTypes[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [_wrongTypeButton setTitle:_wrongTypes[indexPath.row] forState:UIControlStateNormal];
//    _isShow = YES;
//    [self showWrongTable];
    _wrongString = _wrongTypes[indexPath.row];
    _selectedIndexPath = indexPath;
    [self.tableView reloadData];
}
#pragma mark - 提交
- (void)commitAction{
    
}

#pragma mark - 展示tableView
//- (void)showWrongTable{
//    if (_isShow) {
//        [UIView animateWithDuration:0.3 animations:^{
//            _tableView.size = CGSizeMake(0, 0);
//            [_wrongTypeButton setImage:[UIImage imageNamed:@"downopen"] forState:UIControlStateNormal];
//        }];
//    }else{
//        [UIView animateWithDuration:0.3 animations:^{
//            _tableView.size = _tableViewSize;
//            [_wrongTypeButton setImage:[UIImage imageNamed:@"upclose"] forState:UIControlStateNormal];
//        }];
//    }
//    _isShow = !_isShow;
//}


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
