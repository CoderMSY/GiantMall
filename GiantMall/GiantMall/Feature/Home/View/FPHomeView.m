//
//  FPHomeView.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPHomeView.h"
#import <Masonry/Masonry.h>
#import "FPColorConfig.h"
#import "FPHomeBannerCell.h"
#import "FPHomeIconCell.h"
#import "FPHomeGoodCell.h"
#import "FPTheme.h"
#import "FPHomeCellModel.h"
#import "FPGood.h"

@interface FPHomeView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation FPHomeView

#pragma mark - lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

#pragma mark - public methods

- (void)setHomeList:(NSArray *)homeList {
    _homeList = homeList;
    
    [self.collectionView reloadData];
}

#pragma mark - private methods

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.homeList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FPHomeCellModel *cellModel = self.homeList[indexPath.row];
    
    if ([cellModel.item isKindOfClass:[NSArray class]]) {
        NSArray *dataList = (NSArray *)cellModel.item;
        
        if ([dataList.firstObject isKindOfClass:[FPThemeIndex_banner class]] || [dataList.firstObject isKindOfClass:[FPThemeIndex_poster class]]) {
            FPHomeBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FPHomeBannerCell cellReuseId] forIndexPath:indexPath];
            
            cell.itemList = dataList;
            
            return cell;
        }
    }
    
    if ([cellModel.item isKindOfClass:[FPThemeIndex_iconenter class]]) {
        FPHomeIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FPHomeIconCell cellReuseId] forIndexPath:indexPath];
        cell.itemModel = cellModel.item;
        
        return cell;
    } else if ([cellModel.item isKindOfClass:[FPGood class]]) {
        FPHomeGoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FPHomeGoodCell cellReuseId] forIndexPath:indexPath];
        cell.itemModel = cellModel.item;
        
        return cell;
    }
    
    FPBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FPBaseCollectionViewCell cellReuseId] forIndexPath:indexPath];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    FPHomeCellModel *cellModel = self.homeList[indexPath.row];
   
    return cellModel.itemSize;
}

#pragma mark - getter && setter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumLineSpacing = 10; // 单元格上下间距
//        layout.minimumInteritemSpacing = 10; // 单元格左右间距
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
//        layout.itemSize = CGSizeMake(50, 50);
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [FPColorConfig backgroundColor];
        
        [_collectionView registerClass:[FPBaseCollectionViewCell class] forCellWithReuseIdentifier:[FPBaseCollectionViewCell cellReuseId]];
        [_collectionView registerClass:[FPHomeBannerCell class] forCellWithReuseIdentifier:[FPHomeBannerCell cellReuseId]];
        [_collectionView registerClass:[FPHomeIconCell class] forCellWithReuseIdentifier:[FPHomeIconCell cellReuseId]];
        [_collectionView registerClass:[FPHomeGoodCell class] forCellWithReuseIdentifier:[FPHomeGoodCell cellReuseId]];   
    }
    return _collectionView;
}

@end
