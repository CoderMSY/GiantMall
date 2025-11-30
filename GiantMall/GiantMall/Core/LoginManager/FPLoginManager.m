//
//  FPLoginManager.m
//  PocketBook
//
//  Created by Simon Miao on 2023/12/10.
//  Copyright © 2023 FancyPower. All rights reserved.
//

#import "FPLoginManager.h"
#import "FPFileManager.h"
#import "FPKeyedArchiver.h"
@interface FPLoginManager ()

@property (nonatomic, strong, nullable) FPLogin *loginModel;

@end

@implementation FPLoginManager

#pragma mark - lifecycle methods

+ (FPLoginManager *)sharedInstance {
    static FPLoginManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - public methods
- (void)saveCurrentLoginModel:(FPLogin * _Nullable)loginModel {
    if (loginModel) {
        self.loginModel = loginModel;

        [[NSUserDefaults standardUserDefaults] setObject:loginModel.userId forKey:@"UDKey_currentUserId"];
        
        NSDictionary *jsonDic = loginModel.mj_JSONObject;
//        NSString *encryptStr = [jsonStr zjm_encryptAES128WithMD5Key:kZJMOA_md5Key];
//        NSDictionary *encryptDic = @{
//            kUserInfo_key : encryptStr ? : @""
//        };
        
        NSString *fullPath = [self getUserCacheFullPath];
        [FPKeyedArchiver archivedDataWithRootObject:jsonDic filePath:fullPath];
        
//        NSData *userData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
//                            
//        NSError *error;
//        NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:userData requiringSecureCoding:NO error:&error];
//        if (error) {
//            NSLog(@"归档失败：%@", error.localizedDescription);
//            return;
//        }
//        
//        BOOL isSuccess = [archiveData writeToFile:fullPath atomically:YES];
//        
//        if (isSuccess) {
//            NSLog(@"用户数据存储成功");
//        }
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UDKey_currentUserId"];
        
        NSString *fullPath = [self getUserCacheFullPath];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
            NSError *error;
            [[NSFileManager defaultManager] removeItemAtPath:fullPath error:&error];
            if (error) {
                NSLog(@"%@", error.description);
            }
        }
        
        self.loginModel = nil;
    }
}

- (void)removeCurrentLoginModel {
    [self saveCurrentLoginModel:nil];
}

- (FPLogin *)getCurrentLoginModel {
    if (self.loginModel) {
        return self.loginModel;
    }
    
    NSString *fullPath = [self getUserCacheFullPath];
    NSDictionary *jsonDic = [FPKeyedArchiver unarchivedObjectWithFilePath:fullPath];
    if (!jsonDic) {
        return nil;
    }
    
//    NSData *archiveData = [NSData dataWithContentsOfFile:fullPath];
//    if (0 == archiveData.length) {
//        return nil;
//    }
//
//    NSError *error;
//    NSData *loginData = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSData class] fromData:archiveData error:&error];
//    if (error) {
//        NSLog(@"解档失败：%@", error.localizedDescription);
//        return nil;
//    }
//    
//    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:loginData options:0 error:nil];
    
    self.loginModel = [FPLogin mj_objectWithKeyValues:jsonDic];
    
    return self.loginModel;
}

#pragma mark - private methods

- (NSString *)getUserCacheFullPath {
    NSString *localPath = [[FPFileManager shareInstance] getUserLocalPath];
    localPath = [localPath stringByAppendingPathComponent:@"userInfo.data"];
    
    return localPath;
}

#pragma mark - getter && setter

@end
