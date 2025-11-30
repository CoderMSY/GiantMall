//
//  PFFileManager.m
//  ZJMOA
//
//  Created by Simon Miao on 2023/9/6.
//

#import "FPFileManager.h"

@interface FPFileManager ()

@property (nonatomic, copy) NSString *currentEnvPath;

@end

@implementation FPFileManager

#pragma mark - lifecycle methods

+ (FPFileManager *)shareInstance {
    static FPFileManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FPFileManager new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentEnvPath = @"A_PocketBook";
        
        NSString *fullPath = [self getCurrentLocalEnvPath];
        
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
        if (!isExist) {
            //创建环境文件夹
            [[NSFileManager defaultManager] createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return self;
}

#pragma mark - public methods

- (NSString *)getEnvLocalPath {
    NSString *localEnvPath = [self getCurrentLocalEnvPath];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:localEnvPath];
    if (!isExist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:localEnvPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return localEnvPath;
}

- (NSString *)getUserLocalPath {
    NSString *userId = [[NSUserDefaults standardUserDefaults] stringForKey:@"UDKey_currentUserId"];
    NSString *fullPath = [self getUserLocalPathWithUserId:userId];
    
    return fullPath;
}

- (NSString *)getUserLocalPathWithUserId:(NSString *)userId {
    NSString *localEnvPath = [self getCurrentLocalEnvPath];
    
    NSString *componentUser = userId ? : @"defaultUser";
    NSString *fullPath = [localEnvPath stringByAppendingPathComponent:componentUser];
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    if (!isExist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return fullPath;
}

#pragma mark - private methods

- (NSString *)getCurrentLocalEnvPath {
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fullPath = [cacheDir stringByAppendingPathComponent:self.currentEnvPath];
    
    return fullPath;
}

#pragma mark - getter && setter

@end
