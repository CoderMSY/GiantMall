//
//  FPKeyedArchiver.h
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FPKeyedArchiver : NSObject

/// 归档文件
/// - Parameters:
///   - object: 传入可转成json的对象
///   - filePath: 存储路径
+ (BOOL)archivedDataWithRootObject:(id)object
                          filePath:(NSString *)filePath;

/// 解档数据，返回json对象
/// - Parameter filePath: 归档文件路径
+ (nullable id)unarchivedObjectWithFilePath:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
