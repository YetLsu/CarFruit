//
//  NFCardBaseViewController.m
//  guonongda
//
//  Created by guest on 16/10/10.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFCardBaseViewController.h"
#import "NFCardViewController.h"
#import "NFGiftViewController.h"
#import "NFAddCardViewController.h"

@interface NFCardBaseViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation NFCardBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildVC];
    [self setupNavi];
    
    [self setupTitleView];
    [self setupContent];
}

- (void)setupChildVC{
    NFGiftViewController *giftVc = [[NFGiftViewController alloc] init];
    giftVc.title = @"优惠券";
    [self addChildViewController:giftVc];
    NFCardViewController *cardVc = [[NFCardViewController alloc] init];
    cardVc.title = @"会员卡";
    [self addChildViewController:cardVc];
    
}

- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    titleLabel.text = @"卡券";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(0, 0, 46, 40);
    [_addButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [_addButton setContentEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [_addButton addTarget:self action:@selector(addCardOrGift) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:_addButton];
    _addButton.hidden = YES;
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)setupTitleView{
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
    _titleView.backgroundColor = [UIColor whiteColor];
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
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle: vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
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
    [self.view addSubview:_titleView];
    [_titleView addSubview:_indicatorView];
}
- (void)setupContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, kScreenWidth, kScreenHeight)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(kScreenWidth*self.childViewControllers.count, 0);
    [self.view addSubview:_scrollView];
    [self scrollViewDidEndScrollingAnimation:_scrollView];
}


#pragma mark - 添加卡券
- (void)addCardOrGift{
    NFAddCardViewController *addCardVc = [[NFAddCardViewController alloc] init];
    [self.navigationController pushViewController:addCardVc animated:YES];
}

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
    UIViewController *vc = self.childViewControllers[index];
    if (index == 0) {
        _addButton.hidden = YES;
    }else if(index == 1){
        _addButton.hidden = NO;
    }
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, kScreenWidth, kScreenHeight);
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x /kScreenWidth;
    [self titleClick:self.titleView.subviews[index]];
    
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
