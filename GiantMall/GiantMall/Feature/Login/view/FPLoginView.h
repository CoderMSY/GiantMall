//
//  FPLoginView.h
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FPLoginView;
@protocol FPLoginViewDelegate <NSObject>

- (void)loginView:(FPLoginView *)loginView loginWithAccount:(NSString *)account pwd:(NSString *)pwd isRememberPwd:(BOOL)isRememberPwd isAutoLogin:(BOOL)isAutoLogin; 

@end

@interface FPLoginView : UIView

@property (nonatomic, weak) id <FPLoginViewDelegate>delegate;
@property (nonatomic, strong, readonly) UIButton *loginBtn;

@end

NS_ASSUME_NONNULL_END
