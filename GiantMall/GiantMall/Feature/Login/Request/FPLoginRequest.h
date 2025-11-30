//
//  FPLoginRequest.h
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface FPLoginRequest : FPRequest

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
