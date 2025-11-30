//
//  FPGoodListRequest.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPGoodListRequest.h"

@interface FPGoodListRequest ()
{
    NSInteger _pageIndex;
    NSString *_keyword;
}

@end

@implementation FPGoodListRequest

- (instancetype)initWithPageIndex:(NSInteger)pageIndex
                          keyword:(NSString *)keyword
{
    self = [super init];
    if (self) {
        _pageIndex = pageIndex;
        _keyword = keyword;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"index.php/api/goods_list";
}

- (id)requestArgument {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    param[@"per_page"] = @(10);
    param[@"page"] = [NSNumber numberWithInteger:_pageIndex];
    param[@"keyword"] = _keyword;
    param[@"sort_type"] = @(1);
    param[@"category_id"] = @(0); //商品分类id（搜索时传0）
//    param[@"min_price"] = @(0);
//    param[@"max_price"] = @(0);
    
    return param;
}

@end
