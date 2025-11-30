//
//  FPNavigationController.m
//  FPAccount
//
//  Created by Simon Miao on 2025/10/26.
//

#import "FPNavigationController.h"

@interface FPNavigationController ()

@end

@implementation FPNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
