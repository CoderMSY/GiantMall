//
//  FPAppInteractor.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPAppInteractor.h"
#import "FPLoginViewController.h"
#import "FPTabbarConfig.h"
#import "FPLoginManager.h"

@interface FPAppInteractor ()

@property (nonatomic, strong) FPLoginViewController *loginVC;
@property (nonatomic, strong) FPTabbarConfig *tabbarConfig;

@end

@implementation FPAppInteractor

#pragma mark - lifecycle methods

+ (instancetype)sharedInstance {
    static FPAppInteractor *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FPAppInteractor alloc] init];
    });
    
    return instance;
}

#pragma mark - public methods

- (void)startPageFlow {
//    [self startLogin];
//    return;
    
    FPLogin *login = [[FPLoginManager sharedInstance] getCurrentLoginModel];
    if (login) {
        [self startMain];
    }
    else {
        [self startLogin];
    }
}

- (void)startLogin {
    if (_tabbarConfig) {
        _tabbarConfig = nil;
    }

    self.loginVC = [[FPLoginViewController alloc] init];
    
    UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:self.loginVC];
    self.keyWindow.rootViewController = navCtr;
}

- (void)startMain {
    if (_loginVC) {
        _loginVC = nil;
    }
    
    self.tabbarConfig = [[FPTabbarConfig alloc] init];
    
    self.keyWindow.rootViewController = self.tabbarConfig.tabBarCtr;
}
 
#pragma mark - private methods

#pragma mark - getter && setter

@end
