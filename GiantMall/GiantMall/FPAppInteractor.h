//
//  FPAppInteractor.h
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FPAppInteractor : NSObject

@property (nonatomic, strong) UIWindow *keyWindow;

+ (instancetype)sharedInstance;

- (void)startPageFlow;
- (void)startLogin;
- (void)startMain;

@end

NS_ASSUME_NONNULL_END
