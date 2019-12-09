//
//  CityViewController.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/10/17.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "CityViewController.h"
#import "TopCityTableViewCell.h"
#import "CityNameTableViewCell.h"
#import "CityFirstTextHeaderView.h"
#import "UITableView+SCIndexView.h"
//#import "SCIndexView.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *keyArr;
@property (nonatomic, strong) NSDictionary *cityDict;
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getCityData];
    [self tableView];
    
}

- (void)getCityData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    self.cityDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSArray *tempArr = self.cityDict.allKeys;
    tempArr = [tempArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    self.keyArr = [NSMutableArray arrayWithArray:tempArr];
    NSMutableArray *titleArr = [NSMutableArray arrayWithArray:tempArr];
    [self.keyArr insertObject:@"热门城市" atIndex:0];
    [self.keyArr insertObject:@"快捷选择城市" atIndex:0];
    [self.keyArr insertObject:@"当前定位城市" atIndex:0];
    
    [titleArr insertObject:@"热门" atIndex:0];
    [titleArr insertObject:@"快捷" atIndex:0];
    [titleArr insertObject:@"当前" atIndex:0];
    self.tableView.sc_indexViewDataSource = titleArr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.keyArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < 3) {
        return 1;
    }
    NSString *key = self.keyArr[section];
    return [[self.cityDict objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 3) {
        TopCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTopCityTableViewCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        CityNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCityNameTableViewCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = [self.cityDict objectForKey:self.keyArr[indexPath.section]][indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 3) {
        return KCityNameTableViewCellHeight * 2 + 15 * 3;
    }
    return KCityNameTableViewCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CityFirstTextHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([CityFirstTextHeaderView class])];
    if (!headerView) {
        headerView = [[CityFirstTextHeaderView alloc] initWithFrame:CGRectZero];
    }
    headerView.viewMode = section < 3 ? CityFirstTextHeaderViewModeWhite : CityFirstTextHeaderViewModeGray;
    headerView.title = self.keyArr[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KCityNameTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = kColorBg;
        _tableView.separatorColor = kColorBg;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [_tableView registerClass:[TopCityTableViewCell class] forCellReuseIdentifier:KTopCityTableViewCellID];
        [_tableView registerClass:[CityNameTableViewCell class] forCellReuseIdentifier:KCityNameTableViewCellID];
        SCIndexViewConfiguration *configuration = [SCIndexViewConfiguration configurationWithIndexViewStyle:SCIndexViewStyleDefault];
        _tableView.sc_indexViewConfiguration = configuration;
//        _tableView.sc_translucentForTableViewInNavigationBar =
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
