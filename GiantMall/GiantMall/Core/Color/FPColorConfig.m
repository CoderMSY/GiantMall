//
//  FPColorConfig.m
//  FPAccount
//
//  Created by Simon Miao on 2025/11/2.
//

#import "FPColorConfig.h"
#import "UIColor+FPAdd.h"

@implementation FPColorConfig

+ (UIColor *)backgroundColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
                   [UIColor blackColor] : [UIColor fp_colorWithHex:0xF0EFF4];
        }];
    }
    return [UIColor systemBackgroundColor];
}

+ (UIColor *)cardBackgroundColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
                   [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] : [UIColor whiteColor];
        }];
    }
    return [UIColor whiteColor];
}

+ (UIColor *)buttonBackgroundColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
                   [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] : [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        }];
    }
    return [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
}

+ (UIColor *)buttonTintColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
                   [UIColor whiteColor] : [UIColor blackColor];
        }];
    }
    return [UIColor blackColor];
}

+ (UIColor *)textPrimaryColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
                   [UIColor whiteColor] : [UIColor blackColor];
        }];
    }
    return [UIColor blackColor];
}

+ (UIColor *)textSecondaryColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
                   [UIColor lightGrayColor] : [UIColor darkGrayColor];
        }];
    }
    return [UIColor darkGrayColor];
}

+ (UIColor *)tagBackgroundColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
                   [UIColor blackColor] : [UIColor whiteColor];
        }];
    }
    return [UIColor whiteColor];
}

@end
