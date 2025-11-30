//
//  UIView+FPLoading.h
//  ZJCLifeSDK
//
//  Created by Simon Miao on 2023/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FPLoading)

//- (void)fp_postLottieLoading;
//- (void)fp_postGifLoading;
/// 无标题缓冲视图
- (void)fp_postLoading;
- (void)fp_postLoadingWithTitle:(nullable NSString *)title;
- (void)fp_postLoadingWithTitle:(nullable NSString *)title
                          detail:(nullable NSString *)detail;
- (void)fp_postLoadingWithTitle:(nullable NSString *)title
                          detail:(nullable NSString *)detail
                        duration:(NSTimeInterval)duration;

/// post loading
/// - Parameters:
///   - title: 标题
///   - detail: 详情
///   - titleColor: 标题颜色
///   - detailColor: 详情页面
///   - bezelColor: loadin背景页面
///   - backgroundColor: 背景颜色
///   - duration: 隐藏时间
- (void)fp_postLoadingWithTitle:(nullable NSString *)title
                          detail:(nullable NSString *)detail
                      titleColor:(nullable UIColor *)titleColor
                     detailColor:(nullable UIColor *)detailColor
                      bezelColor:(nullable UIColor *)bezelColor
                 backgroundColor:(nullable UIColor *)backgroundColor
                        duration:(NSTimeInterval)duration;

/// post title 默认时间为2秒
/// - Parameter message: title
- (void)fp_postMessage:(nullable NSString *)message;
- (void)fp_postMessage:(nullable NSString *)message
               duration:(NSTimeInterval)duration;
/// post detail 默认时间为2秒
/// - Parameters:
///   - message: detail
- (void)fp_postDetailMessage:(nullable NSString *)message;
/// post detail
/// - Parameters:
///   - message: detail
///   - duration: 隐藏时间
- (void)fp_postDetailMessage:(nullable NSString *)message
                     duration:(NSTimeInterval)duration;

- (void)fp_postMessageWithTitle:(nullable NSString *)title
                          detail:(nullable NSString *)detail
                        duration:(NSTimeInterval)duration;
/// post message
/// - Parameters:
///   - title: 标题
///   - detail: 详情
///   - titleColor: 标题颜色
///   - detailColor: 详情页面
///   - bezelColor: loadin背景页面
///   - backgroundColor: 背景颜色
///   - duration: 隐藏时间
- (void)fp_postMessageWithTitle:(nullable NSString *)title
                          detail:(nullable NSString *)detail
                      titleColor:(nullable UIColor *)titleColor
                     detailColor:(nullable UIColor *)detailColor
                      bezelColor:(nullable UIColor *)bezelColor
                 backgroundColor:(nullable UIColor *)backgroundColor
                        duration:(NSTimeInterval)duration;

///隐藏loading视图
- (void)fp_hideLoading;
- (void)fp_hideLoadingWithAfterDelay:(CGFloat)afterDelay;

@end

NS_ASSUME_NONNULL_END
