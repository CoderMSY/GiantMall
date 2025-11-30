//
//  UIColor+FPAdd.m
//  FPAppStore
//
//  Created by Simon Miao on 2025/10/19.
//

#import "UIColor+FPAdd.h"

@implementation UIColor (FPAdd)

+ (UIColor *)fp_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor *)fp_colorWithHex:(NSInteger)hexValue {
    return [UIColor fp_colorWithHex:hexValue alpha:1];
}

@end
