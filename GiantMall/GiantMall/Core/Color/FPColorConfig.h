//
//  FPColorConfig.h
//  FPAccount
//
//  Created by Simon Miao on 2025/11/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FPColorConfig : NSObject
/// 页面背景颜色
+ (UIColor *)backgroundColor;
+ (UIColor *)cardBackgroundColor;
+ (UIColor *)buttonBackgroundColor;
+ (UIColor *)buttonTintColor;
+ (UIColor *)textPrimaryColor;
+ (UIColor *)textSecondaryColor;
+ (UIColor *)tagBackgroundColor;

@end

NS_ASSUME_NONNULL_END
