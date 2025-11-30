//
//  FPHomeGoodCell.h
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class FPGood;
@interface FPHomeGoodCell : FPBaseCollectionViewCell

@property (nonatomic, strong) FPGood *itemModel;

@end

NS_ASSUME_NONNULL_END
