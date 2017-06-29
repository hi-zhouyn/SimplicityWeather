//
//  HomeViewController.m
//  MyWeather
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "HomeViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "WXController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    NSString *_time;
    NowModel *_nowModel;
    AqiModel *_aqiModel;
    NSMutableArray *_dailyArr;
    NSMutableArray *_hourlyArr;
    SuggestionModel *_suggestionModel;
    NSString *_cityName;
    
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HomeLoadView *homeLoadView;
@property (nonatomic,strong) NowWeatherTableViewCell *nowWeatherCell;
@property (nonatomic,strong) ManyWeatherTableViewCell *manyWeatherCell;
@property (nonatomic,strong) LifeInformationTableViewCell *lifeInformationCell;
@property (nonatomic,strong) BMKLocationService *locService;
@property (nonatomic,strong) BMKGeoCodeSearch * geoCodeSearch;
@property (nonatomic,strong) LifeInformationView *lifeView;
@property (nonatomic,strong) UIView *bgView;
@end

@implementation HomeViewController

-(void)loadView
{
    _homeLoadView = [HomeLoadView viewFromXibName:@"HomeLoadView"];
    self.view = _homeLoadView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    _geoCodeSearch.delegate = self;
    
    _clearHeadViewHeight = kSCREEN_WIDTH;
    [self tableView];
    [self lifeView];
    [self bgView];
    [self addSwipeGestureReconmnizer];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
#pragma mark --- 请求天气数据
-(void) getWeatherData : (NSString *) cityName
{
    
    [NetWorkUtil getPath:[NSString stringWithFormat:@"city=%@",[cityName componentsSeparatedByString:@"市"][0]] parameters:nil sessionID:BaiDuApiKey success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"请求结果为:%@",responseObject);
        NSMutableDictionary *mutDict = responseObject[@"HeWeather data service 3.0"][0];
        _time = mutDict[@"basic"][@"update"][@"loc"];
        _nowModel = [[NowModel alloc] init];
        _aqiModel = [[AqiModel alloc] init];
        _dailyArr = [NSMutableArray array];
        _hourlyArr = [NSMutableArray array];
        _suggestionModel = [[SuggestionModel alloc] init];
        [_nowModel setValuesForKeysWithDictionary:mutDict[@"now"]];
        [_aqiModel setValuesForKeysWithDictionary:mutDict[@"aqi"][@"city"]];
        [_suggestionModel setValuesForKeysWithDictionary:mutDict[@"suggestion"]];
        for (NSDictionary *dict in mutDict[@"daily_forecast"]) {
            DailyForecastModel *model = [[DailyForecastModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [_dailyArr addObject:model];
        }
        for (NSDictionary *dict in mutDict[@"hourly_forecast"]) {
            HourlyForecastModel *model = [[HourlyForecastModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [_hourlyArr addObject:model];
        }
        [_homeLoadView updateUI:_nowModel CityName:cityName Time:_time Aqi:_aqiModel Daily:_dailyArr[0]];
        [_tableView reloadData];
        [self.nowWeatherCell.collectionView reloadData];
        [self.manyWeatherCell.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败:%@",operation.responseObject);
    }];
}


/**
 *  百度地图定位
 *
 */
-(void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    NSLog(@"经度是：%f",userLocation.location.coordinate.latitude);
    //    NSLog(@"纬度是:%f",userLocation.location.coordinate.longitude);
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverse = [[BMKReverseGeoCodeOption alloc] init];
    reverse.reverseGeoPoint = pt;
    BOOL flag = [_geoCodeSearch reverseGeoCode:reverse];
    if (flag) {
        //        NSLog(@"反编码检索成功");
    }else
    {
        NSLog(@"反编码检索失败");
    }
    //    NSLog(@"结果是：%d",)
}
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"地理位置改变了");
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
//        NSLog(@"地址是：%@",result.address);
//        NSLog(@"省份名称是：%@",result.addressDetail.province);
//        NSLog(@"城市名称是：%@",result.addressDetail.city);
//        NSLog(@"区县名称是：%@",result.addressDetail.district);
//        NSLog(@"街道名称是：%@",result.addressDetail.streetName);
        _cityName = result.addressDetail.city;
        if (_dailyArr.count == 0) {
            [self getWeatherData:result.addressDetail.city];
        }
    }else if (error == 8)
    {
        NSLog(@"定位失败，网络连接错误");
    }else if (error == 9)
    {
        NSLog(@"定位失败，网络连接超时");
    }
}
-(void) addSwipeGestureReconmnizer
{
    UISwipeGestureRecognizer *upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeGestureRecognizerAction :)];
    UISwipeGestureRecognizer *downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeGestureRecognizerAction :)];
    upSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    downSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    upSwipeGestureRecognizer.delegate = self;
    downSwipeGestureRecognizer.delegate = self;
    
    [_homeLoadView addGestureRecognizer:upSwipeGestureRecognizer];
    [_homeLoadView addGestureRecognizer:downSwipeGestureRecognizer];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        self.nowWeatherCell = [_tableView dequeueReusableCellWithIdentifier:KNowWeatherTableViewCellID forIndexPath:indexPath];
        self.nowWeatherCell.collectionView.dataSource = self;
        self.nowWeatherCell.collectionView.delegate = self;
        return self.nowWeatherCell;
    }else if (indexPath.section == 1)
    {
        self.manyWeatherCell = [_tableView dequeueReusableCellWithIdentifier:KManyWeatherTableViewCellID forIndexPath:indexPath];
        self.manyWeatherCell.collectionView.delegate = self;
        self.manyWeatherCell.collectionView.dataSource = self;
        return self.manyWeatherCell;
    }else if (indexPath.section == 2)
    {
        AirQualityTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:KAirQualityTableViewCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateUI:_aqiModel];
        return cell;
    }else if (indexPath.section == 3)
    {
        OtherNewsTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:KOtherNewsTableViewCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateUI:_nowModel Daily:_dailyArr[0]];
        return cell;
    }
    _lifeInformationCell = [_tableView dequeueReusableCellWithIdentifier:KLifeInformationTableViewCellID forIndexPath:indexPath];
    _lifeInformationCell.collectionView.delegate = self;
    _lifeInformationCell.collectionView.dataSource = self;
    [_lifeInformationCell.contentView bringSubviewToFront:_lifeInformationCell.newsShowLabel];
    return _lifeInformationCell;
    
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_hourlyArr.count == 0) {
            return FLT_MIN;
        }
        return KNowWeatherTableViewCellHeight;
    }else if (indexPath.section == 1)
    {
        return KManyWeatherTableViewCellHeight;
    }else if (indexPath.section == 2)
    {
        return KAirQualityTableViewCellHeight;
    }else if (indexPath.section == 3)
    {
        return KOtherNewsTableViewCellHeight;
    }
    return KLifeInformationTableViewCellHeight;
    
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.00001;
    }
    return 10 * kAUTOLAYOUTSCALE;
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}
/**
 *  UICollectionView
 *
 */
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.lifeInformationCell.collectionView)
    {
        return 8;
    }else if (collectionView == self.nowWeatherCell.collectionView)
    {
        return _hourlyArr.count;
    }
    return _dailyArr.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.nowWeatherCell.collectionView) {
        NowWeatherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KNowWeatherCollectionViewCellID forIndexPath:indexPath];
        [cell updateUI:_hourlyArr Index:indexPath.item];
        return cell;
        
    }else if (collectionView == self.manyWeatherCell.collectionView)
    {
        ManyWeaherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KManyWeaherCollectionViewCellID forIndexPath:indexPath];
        cell.arr = _dailyArr;
        cell.index = indexPath.item;
        [cell updateUI:_dailyArr Index:indexPath.item];
        return cell;
        
    }else if (collectionView == self.lifeInformationCell.collectionView)
    {
        LifeInformationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLifeInformationCollectionViewCellID forIndexPath:indexPath];
        [cell updateUI:_suggestionModel Index:indexPath.item];
        return cell;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _lifeInformationCell.collectionView) {
        [_lifeView updateUI:_suggestionModel Index:indexPath.item];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _lifeView.hidden = NO;
        _bgView.hidden = NO;
        [_homeLoadView bringSubviewToFront:_lifeView];
        _lifeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        [UIView animateWithDuration:0.3 animations:^{
            _lifeView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
        
    }else if (collectionView == self.manyWeatherCell.collectionView)
    {
        [self getWeatherData:_cityName];
    }
}

//-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    _clearHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH)];
//    _clearHeadView.backgroundColor = kColorBlack;
//    return _clearHeadView;
//}
//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return _clearHeadViewHeight;
//}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    CGPoint offict = scrollView.contentOffset;
    //    NSLog(@"偏移量：%f",offict.y );
    
    
    //    if ( offict.y >  -414 && offict.y < -138   ) {
    //
    //        if (offict.y >  - 138 * 2 && offict.y < -138) {
    //            [UIView animateWithDuration:0.5 animations:^{
    //                _homeLoadView.bgImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH );
    //                _tableView.contentInset = UIEdgeInsetsMake(kSCREEN_WIDTH , 0, 0, 0);
    //            }];
    //             NSLog(@"1111111111");
    //            return;
    //        }
    ////       NSLog(@"偏移量：%f",offict.y);
    //        [UIView animateWithDuration:0.5 animations:^{
    //            _homeLoadView.bgImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH / 3);
    //            _tableView.contentInset = UIEdgeInsetsMake(kSCREEN_WIDTH / 3 , 0, 0, 0);
    //        }];
    //
    //         NSLog(@"22222222222");
    
    
    //        CGPoint point =  _tableView.contentOffset;
    //        point.y = point.y - offict.y + 1;
    //        _tableView.contentOffset = point;
    //        [UIView animateWithDuration:0.5 animations:^{
    //            _tableView.contentInset = UIEdgeInsetsMake(kSCREEN_WIDTH / 3, 0, 0, 0);
    //        }];
    //
    //        if (offict.y < -kSCREEN_WIDTH / 3 - 10 * kAUTOLAYOUTSCALE) {
    ////            [UIView animateWithDuration:0.5 animations:^{
    //               _tableView.contentInset = UIEdgeInsetsMake(kSCREEN_WIDTH, 0, 0, 0);
    ////            }];
    //             NSLog(@"222222222");
    //        }
    //        else
    //        {
    //
    //
    //            CGPoint point =  _tableView.contentOffset;
    //            point.y = point.y - offict.y;
    //            _tableView.contentOffset = point;
    //        }
    
    //        return;
    //    }else  if ( offict.y <  -414   ) {
    //        NSLog(@"3333333333");
    //        [UIView animateWithDuration:0.5 animations:^{
    //            _homeLoadView.bgImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH );
    //            _tableView.contentInset = UIEdgeInsetsMake(kSCREEN_WIDTH , 0, 0, 0);
    //        }];
    
    //        [UIView animateWithDuration:0.5 animations:^{
    //            _clearHeadViewHeight = kSCREEN_WIDTH ;
    //            [_tableView reloadData];
    //        }];
    
    //        [UIView  animateWithDuration:0.5 animations:^{
    //            _tableView.contentInset = UIEdgeInsetsMake(kSCREEN_WIDTH, 0, 0, 0);
    ////            _tableView.frame = CGRectMake(0, kSCREEN_WIDTH, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    //        }];
    //    }
}
-(void )SwipeGestureRecognizerAction : (UISwipeGestureRecognizer *) sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
        
        if (_tableView.contentOffset.y < 0) {
            return;
        }
        //        _tableView.contentOffset = CGPointMake(0, 0);
        _homeLoadView.nowWeatherWindLabel.alpha = 0;
        _homeLoadView.updateTimeLabel.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            //            _homeLoadView.bgImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH / 3 + kNavbarAndStatusHieght);
            
            [_homeLoadView.cityLabel setTop:_homeLoadView.top + kNavbarAndStatusHieght + 5 * kAUTOLAYOUTSCALE ];
            [_homeLoadView.nowWeatherLabel setTop:_homeLoadView.cityLabel.bottom + 8 * kAUTOLAYOUTSCALE ];
            //            CGRect isORect = _homeLoadView.isOLabel.frame ;
            //            isORect.origin.y = isORect.origin.y - kNavbarAndStatusHieght* 2;
            //            _homeLoadView.isOLabel.frame = isORect;
            
            //            _homeLoadView.nowWeatherLabel.alpha = 0;
            _homeLoadView.nowWeatherTMPLabel.alpha = 0;
            _homeLoadView.isOLabel.alpha = 0;
            _homeLoadView.nowWeatherAirLabel.alpha = 0;
            _homeLoadView.nowWeatherWindLabel.alpha = 0;
            _homeLoadView.updateTimeLabel.alpha = 0;
            
            _tableView.frame = CGRectMake(0, kSCREEN_WIDTH / 3 + kNavbarAndStatusHieght, kSCREEN_WIDTH, kSCREEN_HEIGHT - kSCREEN_WIDTH / 3 - kNavbarAndStatusHieght + 1 * kAUTOLAYOUTSCALE);
            //             _tableView.contentOffset = CGPointMake(0, -kSCREEN_WIDTH / 3);
        }];
        //        _tableView.scrollEnabled = YES;

    }else
    {
        
        if (_tableView.contentOffset.y > 0 ) {
            return;
        }
        //        _tableView.contentOffset = CGPointMake(0, 0);
        [UIView animateWithDuration:0.5 animations:^{
            //            _homeLoadView.bgImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH + kNavbarAndStatusHieght );
            //            _tableView.contentInset = UIEdgeInsetsMake(kSCREEN_WIDTH , 0, 0, 0);
            _tableView.frame = CGRectMake(0, kSCREEN_WIDTH + kNavbarAndStatusHieght, kSCREEN_WIDTH, kSCREEN_HEIGHT - kNavbarAndStatusHieght - kSCREEN_WIDTH);
            //            _tableView.contentOffset = CGPointMake(0, -kSCREEN_WIDTH);
            [_homeLoadView.cityLabel setTop:_homeLoadView.top + 103 * kAUTOLAYOUTSCALE ];
            [_homeLoadView.nowWeatherLabel setTop:_homeLoadView.cityLabel.bottom + 8 * kAUTOLAYOUTSCALE ];
            _homeLoadView.nowWeatherTMPLabel.alpha = 1;
            _homeLoadView.isOLabel.alpha = 1;
            //            _homeLoadView.nowWeatherLabel.alpha = 1;
            _homeLoadView.nowWeatherAirLabel.alpha = 1;
            _homeLoadView.nowWeatherWindLabel.alpha = 1;
            _homeLoadView.updateTimeLabel.alpha = 1;
        }];
        //         _tableView.scrollEnabled = NO;
    }
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(void) tapActionRemove:(UITapGestureRecognizer *) sender
{
    [UIView animateWithDuration:0.4 animations:^{
        _lifeView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    } completion:^(BOOL finished) {
        _bgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        _bgView.hidden = YES;
        _lifeView.hidden = YES;
    }];
}
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:kFrame];
        _bgView.backgroundColor = kColorBlack;
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _bgView.hidden = YES;
        // 添加点触事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionRemove:)];
        [_bgView addGestureRecognizer:tap];
        [_homeLoadView addSubview:_bgView];
        
    }
    return _bgView;
}
-(LifeInformationView *)lifeView
{
    if (!_lifeView) {
        _lifeView = [LifeInformationView viewFromXibName:@"LifeInformationView"];
        _lifeView.hidden = YES;
        _lifeView.userInteractionEnabled = NO;
        [_lifeView setCenter:_homeLoadView.center];
        [_homeLoadView addSubview:_lifeView];
    }
    return _lifeView;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSCREEN_WIDTH + kNavbarAndStatusHieght, kSCREEN_WIDTH, kSCREEN_HEIGHT - kSCREEN_WIDTH) style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:KNowWeatherTableViewCellID bundle:nil] forCellReuseIdentifier:KNowWeatherTableViewCellID];
        [_tableView registerNib:[UINib nibWithNibName:KManyWeatherTableViewCellID bundle:nil] forCellReuseIdentifier:KManyWeatherTableViewCellID];
        [_tableView registerNib:[UINib nibWithNibName:KAirQualityTableViewCellID bundle:nil] forCellReuseIdentifier:KAirQualityTableViewCellID];
        [_tableView registerNib:[UINib nibWithNibName:KOtherNewsTableViewCellID bundle:nil] forCellReuseIdentifier:KOtherNewsTableViewCellID];
        [_tableView registerNib:[UINib nibWithNibName:KLifeInformationTableViewCellID bundle:nil] forCellReuseIdentifier:KLifeInformationTableViewCellID];
        _tableView.backgroundColor = kColorClear;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentOffset = CGPointMake(0, 0);
        //        _tableView.contentInset = UIEdgeInsetsMake(kSCREEN_WIDTH, 0, 0, 0);
        _tableView.bounces = NO;
        //         _tableView.scrollEnabled = NO;
        //        _tableView.pagingEnabled = YES;
        [self.homeLoadView addSubview:_tableView ];
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
