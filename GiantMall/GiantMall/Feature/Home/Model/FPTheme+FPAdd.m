//
//  FPTheme+FPAdd.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPTheme+FPAdd.h"
#import <objc/runtime.h>

@implementation FPTheme (FPAdd)

- (void)setFp_itemSize:(NSValue *)fp_itemSize {
    objc_setAssociatedObject(self, @selector(fp_itemSize), fp_itemSize, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSValue *)fp_itemSize {
    NSValue *value = objc_getAssociatedObject(self, @selector(fp_itemSize));
    return value;
}

@end
