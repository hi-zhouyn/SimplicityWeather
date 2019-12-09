//
//  WeatherViewController.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/28.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "WeatherViewController.h"
#import "NowWeatherHeadView.h"
#import "CopyrightFooterView.h"
#import "DayWeatherContentTableViewCell.h"
#import "OtherContentTableViewCell.h"

@interface WeatherViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bgHeadView;
@property (nonatomic, strong) NowWeatherHeadView *headView;
@property (nonatomic, strong) CopyrightFooterView *footerView;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self tableView];
    [self bgHeadView];
    [self footerView];
//    [self testPost];
}


- (void)testPost
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row) {
        DayWeatherContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KDayWeatherContentTableViewCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        OtherContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KOtherContentTableViewCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kColorBg;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row) {
        return 185;
    }else{
        return KSCREEN_WIDTH;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offictY = scrollView.contentOffset.y;
    if (offictY < 0) {
        CGRect rect = self.bgHeadView.frame;
        rect.origin.y = offictY;
        rect.size.height = KNowWeatherHeadViewHeight - offictY;
        self.headView.frame = CGRectMake(0, offictY , rect.size.width, rect.size.height);
        [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgHeadView).offset(offictY);
        }];
    }
}

- (UIView *)bgHeadView
{
    if (!_bgHeadView) {
        _bgHeadView = [[UIView alloc] init];
        _bgHeadView.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KNowWeatherHeadViewHeight);
        self.tableView.tableHeaderView = _bgHeadView;
        self.headView = [NowWeatherHeadView instanceView];
        [_bgHeadView addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.headView.superview);
        }];
    }
    return _bgHeadView;
}

- (CopyrightFooterView *)footerView
{
    if (!_footerView) {
        UIView *copyrightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KCopyrightFooterViewHeight)];
        _footerView = [CopyrightFooterView instanceView];
        [copyrightView addSubview:_footerView];
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(copyrightView);
        }];
        self.tableView.tableFooterView = copyrightView;
    }
    return _footerView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[DayWeatherContentTableViewCell class] forCellReuseIdentifier:KDayWeatherContentTableViewCellID];
        [_tableView registerClass:[OtherContentTableViewCell class] forCellReuseIdentifier:KOtherContentTableViewCellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.tableHeaderView = self.headView;
//        _tableView.tableFooterView = self.footerView;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
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
