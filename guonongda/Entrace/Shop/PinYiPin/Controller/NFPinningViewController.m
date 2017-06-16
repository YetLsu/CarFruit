//
//  NFPinningViewController.m
//  guonongda
//
//  Created by guest on 16/11/4.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFPinningViewController.h"
#import "NFPublisherView.h"
#import "NFTimeView.h"

@interface NFPinningViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NFTimeView *timeView;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation NFPinningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    
    [self setupContent];
    
}

- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"拼单中";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
}
- (void)setupContent{
    self.view.backgroundColor = [UIColor whiteColor];
    NFPublisherView *pubView = [[[NSBundle mainBundle] loadNibNamed:@"NFPublisherView" owner:nil options:nil] lastObject];
    pubView.y = 64;
    [self.view addSubview:pubView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, pubView.bottom, kScreenWidth, 5*44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIButton *goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goButton.frame = CGRectMake(15, kScreenHeight - 45 - 20, kScreenWidth - 30, 45);
    [goButton setTitle:@"走起" forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goButton setBackgroundImage:[UIImage imageNamed:@"pin_done1"] forState:UIControlStateNormal];
    [goButton setBackgroundImage:[UIImage imageNamed:@"pin_done2"] forState:UIControlStateHighlighted];
    [goButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goButton];
    CGFloat viewWidth = goButton.top -_tableView.bottom-60 - 2;
    CGFloat viewHeight = viewWidth;
    _timeView = [[NFTimeView alloc] initWithFrame:CGRectMake((kScreenWidth-viewWidth)/2, _tableView.bottom+30, viewWidth, viewHeight)];
    _timeView.time = 60;
    _timeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_timeView];
    
    
    _timeLabel = [[UILabel alloc] initWithFrame:_timeView.frame];
    _timeLabel.font = [UIFont systemFontOfSize:20];
    [_timeLabel setTextColor:kBaseColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.text = [NSString stringWithFormat:@"%.0fs",_timeView.time];
    [self.view addSubview:_timeLabel];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}
- (void)timeAction{
    if (_timeView.time != 0) {
        _timeView.time = _timeView.time - 1;
        _timeLabel.text = [NSString stringWithFormat:@"%.0fs",_timeView.time];
    }else{
        [_timer invalidate];
    }
}



- (void)click{
    NSLog(@"go");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行",indexPath.row];
    return cell;
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
