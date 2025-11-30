//
//  FPLoginManager.h
//  PocketBook
//
//  Created by Simon Miao on 2023/12/10.
//  Copyright © 2023 FancyPower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPLogin.h"

NS_ASSUME_NONNULL_BEGIN

@interface FPLoginManager : NSObject

+ (FPLoginManager *)sharedInstance;

- (void)saveCurrentLoginModel:(FPLogin * _Nullable)loginModel;
- (void)removeCurrentLoginModel;
- (FPLogin *)getCurrentLoginModel;

@end

NS_ASSUME_NONNULL_END
