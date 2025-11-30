//
//  UIButton+FPAdd.m
//  FPAccount
//
//  Created by Simon Miao on 2025/11/1.
//

#import "UIButton+FPAdd.h"

@implementation UIButton (FPAdd)

+ (instancetype)fp_buttonWithTitle:(NSString *)title
                             image:(UIImage *)image
                             style:(FPButtonStyle)style
                      imagePadding:(CGFloat)imagePadding {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 适配 iOS 15+（使用 UIButton.Configuration）
    if (@available(iOS 15.0, *)) {
        [self configureButton:button
                        title:title
                        image:image
                        style:style
                  imagePadding:imagePadding];
    }
    // 适配 iOS 15 以下（使用传统方法）
    else {
        [self configureLegacyButton:button
                              title:title
                              image:image
                              style:style
                        imagePadding:imagePadding];
    }
    
    return button;
}

#pragma mark - iOS 15+ 配置（UIButton.Configuration）
+ (void)configureButton:(UIButton *)button
                  title:(NSString *)title
                  image:(UIImage *)image
                  style:(FPButtonStyle)style
            imagePadding:(CGFloat)imagePadding API_AVAILABLE(ios(15.0)) {
    // 1. 基础配置
    UIButtonConfiguration *config;
    switch (style) {
        case FPButtonStyleFilled:
            config = [UIButtonConfiguration filledButtonConfiguration];
            break;
        case FPButtonStyleTinted:
            config = [UIButtonConfiguration tintedButtonConfiguration];
            break;
        case FPButtonStylePlain:
        default:
            config = [UIButtonConfiguration plainButtonConfiguration];
            break;
    }
    
    // 2. 设置文字和图片
    if (title) {
        config.title = title;
    }
    
    if (image) {
        config.image = image;
        config.imagePadding = imagePadding; // 图片与文字间距
    }
    
    // 3. 样式调整
//    config.baseForegroundColor = [UIColor whiteColor]; // 文字/图片颜色
//    config.baseBackgroundColor = [UIColor systemBlueColor]; // 背景色
    config.cornerStyle = UIButtonConfigurationCornerStyleMedium; // 圆角
//    config.contentInsets = NSDirectionalEdgeInsetsMake(10, 20, 10, 20); // 内边距
    
    // 4. 应用配置
    button.configuration = config;
}

#pragma mark - iOS 15 以下配置（传统方法）
+ (void)configureLegacyButton:(UIButton *)button
                        title:(NSString *)title
                        image:(UIImage *)image
                        style:(FPButtonStyle)style
                  imagePadding:(CGFloat)imagePadding {
    // 1. 设置文字
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    // 2. 设置图片
    if (image) {
        // 调整图片渲染模式（确保与文字颜色一致）
        UIImage *renderImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [button setImage:renderImage forState:UIControlStateNormal];
        button.tintColor = [UIColor whiteColor];
    }
    
    // 3. 调整图片与文字间距
    if (image && title) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imagePadding);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, imagePadding, 0, 0);
    }
    
    // 4. 样式调整
    button.backgroundColor = (style == FPButtonStyleFilled) ? [UIColor systemBlueColor] : [UIColor clearColor];
    button.layer.cornerRadius = 8;
//    button.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
}


@end
