//
//  UIColor+FPAdd.h
//  FPAppStore
//
//  Created by Simon Miao on 2025/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FPAdd)

+ (UIColor *)fp_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor *)fp_colorWithHex:(NSInteger)hexValue;

@end

NS_ASSUME_NONNULL_END
