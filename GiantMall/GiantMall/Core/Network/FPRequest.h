//
//  FPRequest.h
//  GiantMall
//
//  Created by Simon Miao on 2025/11/29.
//

#import "YTKBaseRequest.h"
#import <TMUtils/NSDictionary+TMSafeUtils.h>
#import "FPRequestBlockDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface FPRequest : YTKBaseRequest

- (void)reqWithSuccess:(FPRequestSuccess _Nullable)success
               failure:(FPRequestFailure _Nullable)failure;

@end

NS_ASSUME_NONNULL_END
