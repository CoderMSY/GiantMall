//
//  FPKeyedArchiver.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPKeyedArchiver.h"

@implementation FPKeyedArchiver

+ (BOOL)archivedDataWithRootObject:(id)object
                          filePath:(NSString *)filePath {
    if (!object || !filePath) {
        return NO;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
                        
    NSError *error;
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:jsonData requiringSecureCoding:NO error:&error];
    if (error) {
        NSLog(@"归档失败：%@", error.localizedDescription);
        return NO;
    }
    
    BOOL isSuccess = [archiveData writeToFile:filePath atomically:YES];
    
    if (isSuccess) {
        NSLog(@"数据归档成功");
    }
    return isSuccess;
}

+ (nullable id)unarchivedObjectWithFilePath:(NSString *)filePath {
    if (!filePath) {
        return nil;
    }
    
    NSData *archiveData = [NSData dataWithContentsOfFile:filePath];
    if (0 == archiveData.length) {
        return nil;
    }

    NSError *error;
    NSData *jsonData = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSData class] fromData:archiveData error:&error];
    if (error) {
        NSLog(@"解档失败：%@", error.localizedDescription);
        return nil;
    }
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    return jsonObj;
}

@end
