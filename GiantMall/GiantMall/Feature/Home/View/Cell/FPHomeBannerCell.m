//
//  FPHomeBannerCell.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPHomeBannerCell.h"
#import <Masonry/Masonry.h>
#import <TMUtils/TMUtils.h>
#import "FPTheme.h"

@interface FPHomeBannerCell () <SDCycleScrollViewDelegate>

@end

@implementation FPHomeBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.bannerView];
        [self initConstraints];
    }
    return self;
}

- (void)initConstraints {
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);//.inset(10);
        make.left.right.mas_equalTo(self.contentView);//.inset(15);
//        make.height.mas_equalTo(self.bannerView.mas_width).multipliedBy(0.5);
    }];
}

#pragma mark - public methods

- (void)setItemList:(NSArray<FPThemeIndex_banner *> *)itemList {
    _itemList = itemList;
    
    NSMutableArray *urlList = [NSMutableArray arrayWithCapacity:0];
    for (FPThemeIndex_banner *item in itemList) {
        if ([item isKindOfClass:[FPThemeIndex_banner class]]) {
            FPThemeIndex_banner *banner = (FPThemeIndex_banner *)item;
            [urlList tm_safeAddObject:banner.img_url];
        } else if ([item isKindOfClass:[FPThemeIndex_poster class]]) {
            FPThemeIndex_poster *poster = (FPThemeIndex_poster *)item;
            [urlList tm_safeAddObject:poster.src];
        }
    }
    
    self.bannerView.imageURLStringsGroup = urlList;
}

#pragma mark - SDCycleScrollViewDelegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

- (SDCycleScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];;
        //        _bannerView.pageControl.pageIndicatorTintColor = [UIColor av_bgGrayColor];
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _bannerView.showPageControl = YES;
        _bannerView.autoScroll = NO;
        _bannerView.autoScrollTimeInterval = 3.0;
//        _bannerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        _bannerView.layer.cornerRadius = 15;
        _bannerView.clipsToBounds = YES;
    }
    return _bannerView;
}

@end
