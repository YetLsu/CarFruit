//
//  NFShopDetailViewController.m
//  meituan2
//
//  Created by guest on 16/9/6.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopDetailViewController.h"
#import "NFShopShowViewController.h"
#import "NFShopFoodsViewController.h"
#import "NFShopIntruduceViewController.h"
#import "UINavigationBar+Awesome.h"
#import "NFShopDetailHeaderView.h"
#import "TempPingppBuy.h"
#import "NFNewProViewController.h"
#import <DIOpenSDK/DIOpenSDK.h>
#import "NFTakePhotoViewController.h"
#import "NFItemButton.h"
#import "NFPinPublishViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kShopButtonTitle @"呼叫滴滴"
#define kGoodsButtonTitle @"添加新品"
#define kShowButtonTitle @"拍照展示"

@interface NFShopDetailViewController ()<UIScrollViewDelegate,NFShopDetailHeaderViewDelegate>

@property (nonatomic, strong) UIView *mainView;

//@property (nonatomic, strong) UIScrollView *mainView;
//@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NFShopDetailHeaderView *headerView;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, strong) UIButton *selectedButton;

@property (nonatomic, strong) UIScrollView *scrollView;

//@property (nonatomic, strong) UIButton *purcharseBtn;
@property (nonatomic, strong) UILabel *naviTitle;

@property (nonatomic, strong) UIButton *bottomBtn;

@property (nonatomic, strong) UIView *pinView;

@property (nonatomic, strong) UIView *maskView;
@end

@implementation NFShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupChildVC];
    
    [self setupNavigation];
    
    [self setupHeader];
    
    [self setupTitleView];
    
    [self setupContent];
    
    [self setupNotification];
    
    
}
#pragma mark 设置子视图
- (void)setupChildVC{
    NFShopIntruduceViewController *intruduceVc = [[NFShopIntruduceViewController alloc] init];
    intruduceVc.title = @"商家";
    [self addChildViewController:intruduceVc];
    
    NFShopFoodsViewController *foodsVc = [[NFShopFoodsViewController alloc] init];
    foodsVc.title = @"推荐";
    [self addChildViewController:foodsVc];
    
    NFShopShowViewController *showVc = [[NFShopShowViewController alloc] init];
    showVc.title = @"展示";
    [self addChildViewController:showVc];
    
}

#pragma mark 设置导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}


- (void)setupNavigation{
    _naviTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 40)];
    _naviTitle.textAlignment = NSTextAlignmentCenter;
    _naviTitle.textColor = [UIColor whiteColor];
    _naviTitle.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = _naviTitle;

    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(0, 0, 46, 40);
    [moreButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreButton setContentEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [moreButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

#pragma mark 右边Item点击的方法
- (void)more{
    
}

#pragma mark 设置头
- (void)setupHeader{
    _mainView = [[UIView alloc] initWithFrame:self.view.bounds];
//    _mainView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    _mainView.delegate = self;
//    _mainView.contentSize = CGSizeMake(0, kScreenHeight);
    [self.view addSubview:_mainView];

#warning TODO 根据商店信息更新视图
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"NFShopDetailHeaderView" owner:nil options:nil] lastObject];
    _headerView.delegate = self;
    [_mainView addSubview:_headerView];
}

#pragma mark 设置segment
- (void)setupTitleView{
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), kScreenWidth, 40)];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = kBaseColor;
    _indicatorView.height = 2;
    _indicatorView.tag = -1;
    _indicatorView.y = _titleView.height - 2;
    
    CGFloat btnW = kScreenWidth/self.childViewControllers.count;
    CGFloat btnH = 38;
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle: vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:kBaseColor forState:UIControlStateDisabled];
        button.tag = i;
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:button];
        if (i==0) {
            button.enabled = NO;
            self.selectedButton = button;
            [button.titleLabel sizeToFit];
            _indicatorView.width = button.titleLabel.width;
            _indicatorView.centerX = button.centerX;
        }
    }
    [_mainView addSubview:_titleView];
    
    [_titleView addSubview:_indicatorView];
}

#pragma mark 设置内容视图
- (void)setupContent{
    // 让view的原点从左上角开始
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, kScreenWidth, kScreenHeight)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(kScreenWidth*self.childViewControllers.count, 0);
    [_mainView addSubview:_scrollView];
    [self scrollViewDidEndScrollingAnimation:_scrollView];

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 75, kScreenWidth, 75)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 15, kScreenWidth - 30, 45);
    [button setBackgroundImage:[UIImage imageNamed:@"botton_didi"] forState:UIControlStateNormal];
    [button setTitle:kShopButtonTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:@selector(bottomClick:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomBtn = button;
    [bottomView addSubview:button];
    [self.view addSubview:bottomView];
    
    _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:0.5];
    _maskView.hidden = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pinViewHidden)];
    [_maskView addGestureRecognizer:tapGR];
    [self.view addSubview:_maskView];
    
    _pinView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 220)];
    _pinView.backgroundColor = [UIColor whiteColor];
    
    NSArray *titles = @[@"拼餐",@"拼桌",@"拼单",@"拼车",@"取消",@"拼积分"];
    NSArray *images = @[@"pin1_food",@"pin1_chair",@"pin1_order",@"pin1_car",@"pin1_cancel",@"pin1_gift"];
    CGRect rect = CGRectMake(30, 50, _pinView.width - 2*30, _pinView.height-30);
    UIView *pinInnerView = [[UIView alloc] initWithFrame:rect];
    [_pinView addSubview:pinInnerView];
    CGFloat itemW = rect.size.width/3;
    CGFloat itemH = rect.size.height/2;
    for (int i=0; i<6; i++) {
        NFItemButton *itemBtn = [[NFItemButton alloc] initWithFrame:CGRectMake(i%3*itemW,i/3*itemH, itemW, itemH)];
        [itemBtn setItemTitle:titles[i]];
        [itemBtn setItemImage:[UIImage imageNamed:images[i]] forControlState:UIControlStateNormal];
        [itemBtn setItemTitleFont:13];
        [itemBtn setItemTitleColor:[UIColor grayColor]];
        itemBtn.tag = i;
        [itemBtn addTarget:self action:@selector(pinAction:) forControlEvents:UIControlEventTouchUpInside];
        [pinInnerView addSubview:itemBtn];
    }
    [self.view addSubview:_pinView];
}

- (void)pinAction:(NFItemButton *)sender{
    NSLog(@"%ld",sender.tag);
    switch (sender.tag) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 5:
        {
            [self pinViewHidden];
            NFPinPublishViewController *pinPublishVc = [[NFPinPublishViewController alloc] init];
            [self.navigationController pushViewController:pinPublishVc animated:YES];
        }
            break;
        default:
            [self pinViewHidden];
            break;
    }
}
#pragma mark 底部按钮的方法
- (void)bottomClick:(UIButton *)button{
    NSString *string = button.currentTitle;
    if ([string isEqualToString:kShopButtonTitle]) {
        [DIOpenSDK showDDPage:self animated:YES params:nil delegate:nil];
    }else if ([string isEqualToString:kGoodsButtonTitle]){
        NSLog(@"%@",string);
        NFNewProViewController *newProVc = [[NFNewProViewController alloc] init];
        [self.navigationController pushViewController:newProVc animated:YES];
    }else if([string isEqualToString:kShowButtonTitle]){
        NSLog(@"%@",string);
        NFTakePhotoViewController *takePhotoVc = [[NFTakePhotoViewController alloc] init];
        [self presentViewController:takePhotoVc animated:YES completion:nil];
    }

}


#pragma mark 添加通知
- (void)setupNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollUp:) name:@"shanghua" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollDown:) name:@"xiahua" object:nil];

}

//#pragma mark 购买按钮
//- (void)purcharseAction{
//    TempPingppBuy *pingBuy = [[TempPingppBuy alloc] init];
//    [self.navigationController pushViewController:pingBuy animated:YES];
//}

#pragma mark 接收通知
- (void)scrollUp:(NSNotification *)notification{
    [UIView animateWithDuration:0.2 animations:^{
        _naviTitle.text = @"先锋水果";
        [self.navigationController.navigationBar lt_setBackgroundColor:[kBaseColor colorWithAlphaComponent:1]];
        self.mainView.transform = CGAffineTransformMakeTranslation(0, -160 + 64);
        
    }];
}
- (void)scrollDown:(NSNotification *)notification{
    [UIView animateWithDuration:0.2 animations:^{
        self.mainView.transform = CGAffineTransformIdentity;
        [self.navigationController.navigationBar lt_setBackgroundColor:[kBaseColor colorWithAlphaComponent:0]];
         _naviTitle.text = @"";
    }];
}
//滚动的时候，动态的改变透明视图的不透明度
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == _mainView) {
//        UIColor * color = kBaseColor;
//        CGFloat offsetY = scrollView.contentOffset.y;
//        if (offsetY > NAVBAR_CHANGE_POINT) {
//            CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
//            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//        } else {
//            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
//        }
//    }
//}

#pragma mark 标题点击
- (void)titleClick:(UIButton *)button{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        _indicatorView.width = button.titleLabel.width;
        _indicatorView.centerX = button.centerX;
    }];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = button.tag*kScreenWidth;
    [self.scrollView setContentOffset:offset animated:YES];
}


#pragma mark segment 子视图的切换
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    if (index == 0) {
        [self.bottomBtn setTitle:kShopButtonTitle forState:UIControlStateNormal];
    }else if(index == 1){
        [self.bottomBtn setTitle:kGoodsButtonTitle forState:UIControlStateNormal];
    }else if (index == 2){
        [self.bottomBtn setTitle:kShowButtonTitle forState:UIControlStateNormal];
    }
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, kScreenWidth, kScreenHeight);
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x /kScreenWidth;
    [self titleClick:self.titleView.subviews[index]];
    
}

#pragma mark 移除观察者
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark 弹出拼一拼
- (void)pinClick{
    NSLog(@"pinClick");
    _maskView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _pinView.y = kScreenHeight - _pinView.height;
    }];
}
- (void)pinViewHidden{
    _maskView.hidden = YES;
    [UIView animateWithDuration:0.2 animations:^{
        _pinView.y = kScreenHeight;
    }];
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
