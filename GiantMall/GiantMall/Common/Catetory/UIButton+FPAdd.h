//
//  UIButton+FPAdd.h
//  FPAccount
//
//  Created by Simon Miao on 2025/11/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FPButtonStyle) {
    FPButtonStyleFilled,      // 填充样式（有背景色）
    FPButtonStyleTinted,      //  tint 样式（背景色透明，图片文字带 tint 色）
    FPButtonStylePlain        // 纯文本样式（无背景）
};

@interface UIButton (FPAdd)

/// 创建兼容 iOS 15+ 和以下系统的按钮
/// @param title 按钮文字
/// @param image 按钮图片（可为 nil）
/// @param style 按钮样式
/// @param imagePadding 图片与文字的间距（iOS 15+ 有效）
+ (instancetype)fp_buttonWithTitle:(nullable NSString *)title
                             image:(UIImage *)image
                             style:(FPButtonStyle)style
                      imagePadding:(CGFloat)imagePadding;

@end

NS_ASSUME_NONNULL_END
