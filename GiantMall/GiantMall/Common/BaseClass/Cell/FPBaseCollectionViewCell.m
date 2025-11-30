//
//  FPBaseCollectionViewCell.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPBaseCollectionViewCell.h"

@implementation FPBaseCollectionViewCell

+ (NSString *)cellReuseId {
    NSLog(@"%s %@", __func__, NSStringFromClass([self class]));
    return NSStringFromClass([self class]);
}

@end
