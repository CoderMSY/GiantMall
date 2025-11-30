//
//  FPHomeBannerCell.h
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPBaseCollectionViewCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

NS_ASSUME_NONNULL_BEGIN
//@class FPThemeIndex_banner;
@interface FPHomeBannerCell : FPBaseCollectionViewCell

@property (nonatomic, copy) NSArray *itemList;
@property (nonatomic, strong) SDCycleScrollView *bannerView;

@end

NS_ASSUME_NONNULL_END
