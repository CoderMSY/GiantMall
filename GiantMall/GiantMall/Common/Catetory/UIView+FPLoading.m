//
//  UIView+FPLoading.m
//  ZJCLifeSDK
//
//  Created by Simon Miao on 2023/3/15.
//

#import "UIView+FPLoading.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <objc/runtime.h>

static const CGFloat KTipLoadingOverTime = 60;
static const CGFloat KTipNormalOverTime = 2;

@interface UIView (FPLoadingView) <MBProgressHUDDelegate>

@property (nonatomic,strong) MBProgressHUD * progressHud;

@end

@implementation UIView (FPLoadingView)

- (MBProgressHUD *)progressHud {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProgressHud:(MBProgressHUD *)progressHud {
    return objc_setAssociatedObject(self, @selector(progressHud), progressHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIView (FPLoading)

#pragma mark - postLoading



- (void)fp_postLoading
{
    [self fp_postLoadingWithTitle:nil];
}

- (void)fp_postLoadingWithTitle:(NSString *)title {
    [self fp_postLoadingWithTitle:title
                            detail:nil];
}

- (void)fp_postLoadingWithTitle:(NSString *)title
                          detail:(NSString *)detail {
    [self fp_postLoadingWithTitle:title
                            detail:detail
                          duration:KTipLoadingOverTime];
}

- (void)fp_postLoadingWithTitle:(NSString *)title
                          detail:(NSString *)detail
                        duration:(NSTimeInterval)duration {
    [self fp_postLoadingWithTitle:title
                            detail:detail
                        titleColor:nil
                       detailColor:nil
                        bezelColor:nil
                   backgroundColor:nil
                          duration:duration];
}

- (void)fp_postLoadingWithTitle:(NSString *)title
                          detail:(NSString *)detail
                      titleColor:(UIColor *)titleColor
                     detailColor:(UIColor *)detailColor
                      bezelColor:(UIColor *)bezelColor
                 backgroundColor:(UIColor *)backgroundColor
                        duration:(NSTimeInterval)duration {
    [self fp_checkCreateHudLoading];
    
    [self fp_setTitle:title];
    [self fp_setDetailText:detail];
    
    if (titleColor) {
        self.progressHud.label.textColor = titleColor;
    }
    
    if (detailColor) {
        self.progressHud.detailsLabel.textColor = detailColor;
    }
    
    if (bezelColor) {
        self.progressHud.bezelView.backgroundColor = bezelColor;
    }
    
    if (backgroundColor) {
        self.progressHud.backgroundView.backgroundColor = backgroundColor;
    }
    
    [self fp_hideLoadingWithAfterDelay:duration];
}

#pragma mark - postMessage

- (void)fp_postMessage:(NSString *)message {
    [self fp_postMessage:message
                 duration:KTipNormalOverTime];
}

- (void)fp_postMessage:(NSString *)message
               duration:(NSTimeInterval)duration {
    [self fp_postMessageWithTitle:message
                            detail:nil
                          duration:duration];
}

- (void)fp_postDetailMessage:(NSString *)message {
    [self fp_postDetailMessage:message duration:KTipNormalOverTime];
}

- (void)fp_postDetailMessage:(NSString *)message
                     duration:(NSTimeInterval)duration {
    [self fp_postMessageWithTitle:nil
                            detail:message
                          duration:duration];
}

- (void)fp_postMessageWithTitle:(NSString *)title
                          detail:(NSString *)detail
                        duration:(NSTimeInterval)duration {
    [self fp_postMessageWithTitle:title
                            detail:detail
                        titleColor:nil
                       detailColor:nil
                        bezelColor:nil
                   backgroundColor:nil
                          duration:duration];
}

- (void)fp_postMessageWithTitle:(NSString *)title
                          detail:(NSString *)detail
                      titleColor:(UIColor *)titleColor
                     detailColor:(UIColor *)detailColor
                      bezelColor:(UIColor *)bezelColor
                 backgroundColor:(UIColor *)backgroundColor
                        duration:(NSTimeInterval)duration {
    [self fp_checkCreateHudLoading];
    self.progressHud.mode = MBProgressHUDModeText;
    
    [self fp_setTitle:title];
    [self fp_setDetailText:detail];

    if (titleColor) {
        self.progressHud.label.textColor = titleColor;
    }
    
    if (detailColor) {
        self.progressHud.detailsLabel.textColor = detailColor;
    }
    
    if (bezelColor) {
        self.progressHud.bezelView.backgroundColor = bezelColor;
    }
    
    if (backgroundColor) {
        self.progressHud.backgroundView.backgroundColor = backgroundColor;
    }
    [self fp_hideLoadingWithAfterDelay:duration];
}

- (void)fp_hideLoading {
    if (self.progressHud) {
        [self.progressHud hideAnimated:YES];
        [self.progressHud removeFromSuperview];
        self.progressHud.delegate = nil;
        self.progressHud = nil;
    }
}

- (void)fp_hideLoadingWithAfterDelay:(CGFloat)afterDelay {
    if (self.progressHud) {
        [self.progressHud hideAnimated:YES afterDelay:afterDelay];
    }
}

#pragma mark - private method

- (void)fp_checkCreateHudLoading
{
    if (!self.progressHud) {
        self.progressHud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        self.progressHud.detailsLabel.textColor = [UIColor whiteColor];
//        self.progressHud.mode = MBProgressHUDModeCustomView;
//        ZJMHudGifImageView *imageView = [[ZJMHudGifImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"jiazhai" ofType:@"gif"];
//        [imageView sd_setImageWithURL:[NSURL fileURLWithPath:path]];
//        self.progressHud.customView = imageView;
//        self.progressHud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//        self.progressHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//        self.progressHud.contentColor = [UIColor whiteColor];
        self.progressHud.tintColor = [UIColor whiteColor];
//        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
//        self.progressHud.detailsLabelColor = [UIColor whiteColor];
        self.progressHud.delegate = self;
    }
}

- (void)fp_setTitle:(NSString *)title {
    if ([title isKindOfClass:[NSNull class]]) {
        return;
    }
    if ([title isKindOfClass:[NSString class]] || !title) {
        self.progressHud.label.text = title;
    }
}

- (void)fp_setDetailText:(NSString *)detailText {
    if ([detailText isKindOfClass:[NSNull class]]) {
        return;
    }
    if ([detailText isKindOfClass:[NSString class]] || !detailText) {
        self.progressHud.detailsLabel.text = detailText;
    }
}


- (void)overTimerCallback{
    [self fp_hideLoading];
}
    
#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (self.progressHud) {
        [self.progressHud removeFromSuperview];
        self.progressHud.delegate = nil;
        self.progressHud = nil;
    }
}

@end
