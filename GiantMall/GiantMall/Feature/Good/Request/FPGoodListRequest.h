//
//  FPGoodListRequest.h
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface FPGoodListRequest : FPRequest

- (instancetype)initWithPageIndex:(NSInteger)pageIndex
                          keyword:(NSString *)keyword;

@end

NS_ASSUME_NONNULL_END
