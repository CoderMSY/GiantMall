//
//  PFFileManager.h
//  ZJMOA
//
//  Created by Simon Miao on 2023/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FPFileManager : NSObject

+ (FPFileManager *)shareInstance;

/// 获取本地环境路径
- (NSString *)getEnvLocalPath;
/// 获取用户默认地址
- (NSString *)getUserLocalPath;

/// @param userId 当前用户id
- (NSString *)getUserLocalPathWithUserId:(NSString * _Nullable)userId;

@end

NS_ASSUME_NONNULL_END
