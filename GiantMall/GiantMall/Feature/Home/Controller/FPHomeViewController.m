//
//  FPHomeViewController.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/29.
//

#import "FPHomeViewController.h"
#import <Masonry/Masonry.h>
#import <TMUtils/TMUtils.h>
#import "FPColorConfig.h"
#import "FPKeyedArchiver.h"
#import "FPFileManager.h"
#import "FPThemeRequest.h"
#import "FPGoodListRequest.h"
#import "FPTheme.h"
#import "FPGood.h"
#import "FPHomeCellModel.h"
#import "FPHomeView.h"

@interface FPHomeViewController ()

@property (nonatomic, strong) FPHomeView *homeView;

@end

@implementation FPHomeViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [FPColorConfig backgroundColor];
    
    [self setupUI];
    [self loadThemeData];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)setupUI {
    [self.view addSubview:self.homeView];
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
    }];
}

- (void)loadThemeData {
    NSDictionary *dataDic = [FPKeyedArchiver unarchivedObjectWithFilePath:[self getThemeCacheFullPath]];
    NSArray *goodList = [FPKeyedArchiver unarchivedObjectWithFilePath:[self getHomeGoodListFullPath]];
    
    if (!dataDic || !goodList) {
        [self reqHomeData];
        return;
    }
    
    FPTheme *theme = [FPTheme mj_objectWithKeyValues:dataDic];
    NSArray *goodModels = [FPGood mj_objectArrayWithKeyValuesArray:goodList];
    [self reloadDataSourceWithTheme:theme goodModels:goodModels];
}

- (void)reqHomeData {
    // 1. 创建调度组
    dispatch_group_t group = dispatch_group_create();
    
    // 2. 请求1：账单列表（加入调度组）
    dispatch_group_enter(group);
    __block FPTheme *themeModel;
    [self reqThemeWithSuccess:^(FPTheme *theme) {
        themeModel = theme;
        // 离开组（必须调用，与enter成对）
        dispatch_group_leave(group);
    } failure:^(NSString *errorMsg) {
        // 离开组（必须调用，与enter成对）
        dispatch_group_leave(group);
    }];
    
    // 3. 请求2：分类列表（加入调度组）
    dispatch_group_enter(group);
    __block NSArray *goodList;
    [self reqGoodListWithSuccess:^(NSArray *dataList) {
        goodList = dataList;
        // 离开组（必须调用，与enter成对）
        dispatch_group_leave(group);
    } failure:^(NSString *errorMsg) {
        // 离开组（必须调用，与enter成对）
        dispatch_group_leave(group);
    }];
    
    // 4. 监听所有请求完成（在主线程刷新页面）
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"所有接口请求完成，开始刷新页面");
        NSArray *goodModels = [FPGood mj_objectArrayWithKeyValuesArray:goodList];
        [self reloadDataSourceWithTheme:themeModel goodModels:goodModels];
    });
}

- (void)reqThemeWithSuccess:(void(^)(FPTheme *theme))success
                    failure:(void(^)(NSString *errorMsg))failure {
    FPThemeRequest *req = [[FPThemeRequest alloc] init];
    req.timestamp = [[NSDate date] timeIntervalSince1970];
    [req reqWithSuccess:^(FPRequest * _Nonnull request, NSDictionary * _Nullable resDic) {
        NSLog(@"%@", resDic);
        
        NSDictionary *dataDic = [resDic tm_dictionaryForKey:@"data"];
        
        FPTheme *theme = [FPTheme mj_objectWithKeyValues:dataDic];
        NSLog(@"%s:%@", __func__, theme.content);
        
        [self reloadDataSourceWithTheme:theme goodModels:nil];
        
        
        [FPKeyedArchiver archivedDataWithRootObject:dataDic filePath:[self getThemeCacheFullPath]];
        
        if (success) {
            success(theme);
        }
    } failure:^(FPRequest * _Nonnull request, NSInteger resultCode, NSString * _Nullable errorMsg) {
        if (failure) {
            failure(errorMsg);
        }
    }];
}

- (void)reqGoodListWithSuccess:(void(^)(NSArray *dataList))success
                       failure:(void(^)(NSString *errorMsg))failure {
    FPGoodListRequest *request = [[FPGoodListRequest alloc] initWithPageIndex:1 keyword:@""];
    [request reqWithSuccess:^(FPRequest * _Nonnull request, NSDictionary * _Nullable resDic) {
        NSLog(@"%s:%@", __func__, resDic);
        NSArray *dataList = [resDic tm_arrayForKey:@"data"];
        
        [FPKeyedArchiver archivedDataWithRootObject:dataList filePath:[self getHomeGoodListFullPath]];
        
        if (success) {
            success(dataList);
        }
    } failure:^(FPRequest * _Nonnull request, NSInteger resultCode, NSString * _Nullable errorMsg) {
        if (failure) {
            failure(errorMsg);
        }
    }];
}

- (void)reloadDataSourceWithTheme:(FPTheme *)theme goodModels:(NSArray <FPGood *>*)goodModels {
    CGFloat leftMargin = 15;
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:0];
    if (theme.index_banner.count > 0) {
        FPHomeCellModel *cellModel = [[FPHomeCellModel alloc] init];
        cellModel.item = theme.index_banner;
        CGFloat bannerWidth = self.view.frame.size.width - leftMargin * 2;
        CGFloat bannerHeight = bannerWidth * 175 / 350;
        
        cellModel.itemSize = CGSizeMake(bannerWidth, bannerHeight);
        [dataSource tm_safeAddObject:cellModel];
    }
    
    if (theme.index_iconenter.count > 0) {
        for (FPThemeIndex_iconenter *item in theme.index_iconenter) {
            FPHomeCellModel *cellModel = [[FPHomeCellModel alloc] init];
            cellModel.item = item;
            CGFloat cellWidth = (self.view.frame.size.width - leftMargin * 6) / 5;
            cellModel.itemSize = CGSizeMake(cellWidth, cellWidth);
            [dataSource tm_safeAddObject:cellModel];
        }
    }
    
    if (theme.index_poster.count > 0) {
        FPHomeCellModel *cellModel = [[FPHomeCellModel alloc] init];
        cellModel.item = theme.index_poster;
        
        CGFloat bannerWidth = self.view.frame.size.width - leftMargin * 2;
        CGFloat bannerHeight = bannerWidth * 97.4 / 349;
        cellModel.itemSize = CGSizeMake(bannerWidth, bannerHeight);
        [dataSource tm_safeAddObject:cellModel];
    }
    
    if (goodModels && goodModels.count > 0) {
        for (FPGood *good in goodModels) {
            FPHomeCellModel *cellModel = [[FPHomeCellModel alloc] init];
            cellModel.item = good;
            
            CGFloat itemWidth = (self.view.frame.size.width - leftMargin * 3) / 2;
            CGFloat itemHeight = itemWidth * 298.5 / 172;
            cellModel.itemSize = CGSizeMake(itemWidth, itemHeight);
            [dataSource tm_safeAddObject:cellModel];
        }
    }
    
    if (theme.index_poster_2.count > 0) {
        FPHomeCellModel *cellModel = [[FPHomeCellModel alloc] init];
        cellModel.item = theme.index_poster_2;
        CGFloat bannerWidth = self.view.frame.size.width - leftMargin * 2;
        CGFloat bannerHeight = bannerWidth * 97.4 / 349;
        
        cellModel.itemSize = CGSizeMake(bannerWidth, bannerHeight);
        [dataSource tm_safeAddObject:cellModel];
    }
    
    if (theme.index_poster_3.count > 0) {
        FPHomeCellModel *cellModel = [[FPHomeCellModel alloc] init];
        cellModel.item = theme.index_poster_3;
        CGFloat bannerWidth = self.view.frame.size.width - leftMargin * 2;
        CGFloat bannerHeight = bannerWidth * 72.79 / 349;
        
        cellModel.itemSize = CGSizeMake(bannerWidth, bannerHeight);
        [dataSource tm_safeAddObject:cellModel];
    }
    
    if (theme.index_poster_4.count > 0) {
        FPHomeCellModel *cellModel = [[FPHomeCellModel alloc] init];
        cellModel.item = theme.index_poster_4;
        CGFloat bannerWidth = self.view.frame.size.width - leftMargin * 2;
        CGFloat bannerHeight = bannerWidth * 173.66 / 349;
        
        cellModel.itemSize = CGSizeMake(bannerWidth, bannerHeight);
        [dataSource tm_safeAddObject:cellModel];
    }
    
    if (theme.index_poster_5.count > 0) {
        FPHomeCellModel *cellModel = [[FPHomeCellModel alloc] init];
        cellModel.item = theme.index_poster_5;
        CGFloat bannerWidth = self.view.frame.size.width - leftMargin * 2;
        CGFloat bannerHeight = bannerWidth * 52.34 / 349;
        
        cellModel.itemSize = CGSizeMake(bannerWidth, bannerHeight);
        [dataSource tm_safeAddObject:cellModel];
    }
    
    
    self.homeView.homeList = dataSource;
}

- (NSString *)getThemeCacheFullPath {
    NSString *localPath = [[FPFileManager shareInstance] getUserLocalPath];
    localPath = [localPath stringByAppendingPathComponent:@"theme.data"];
    
    return localPath;
}

- (NSString *)getHomeGoodListFullPath {
    NSString *localPath = [[FPFileManager shareInstance] getUserLocalPath];
    localPath = [localPath stringByAppendingPathComponent:@"homeGoodList.data"];
    
    return localPath;
}

#pragma mark - getter && setter

- (FPHomeView *)homeView {
    if (!_homeView) {
        _homeView = [[FPHomeView alloc] init];
    }
    return _homeView;
}

@end
