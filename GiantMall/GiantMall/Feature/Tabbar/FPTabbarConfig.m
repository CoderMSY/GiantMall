//
//  FPTabbarConfig.m
//  FPAppStore
//
//  Created by Simon Miao on 2025/10/18.
//

#import "FPTabbarConfig.h"
#import "FPNavigationController.h"
#import "FPHomeViewController.h"
//#import "FPBillChartViewController.h"
//#import "FPMyViewController.h"
//#import "FPSearchViewController.h"

@interface FPTabbarConfig () <UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) UITabBarController *tabBarCtr;

@end

@implementation FPTabbarConfig

#pragma mark - lifecycle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadDataSource];
    }
    return self;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)loadDataSource {
    // 1. 创建两个视图控制器
    FPHomeViewController *homeVC = [[FPHomeViewController alloc] init];
    homeVC.title = @"home";
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"home"
                                                           image:[UIImage systemImageNamed:@"music.note.list"]
                                                   selectedImage:nil];

    UIViewController *chartVC = [[UIViewController alloc] init];
    chartVC.title = @"搜索";
    chartVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"搜索"
                                                    image:[UIImage systemImageNamed:@"person.crop.circle"]
                                             selectedImage:nil];
    
    UIViewController *myVC = [[UIViewController alloc] init];
    myVC.title = @"我的";
    myVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                    image:[UIImage systemImageNamed:@"person.crop.circle"]
                                             selectedImage:nil];
    
    // 2. 创建导航控制器（可选，但推荐）
    FPNavigationController *recommendNav = [[FPNavigationController alloc] initWithRootViewController:homeVC];
    FPNavigationController *chartNav = [[FPNavigationController alloc] initWithRootViewController:chartVC];
    FPNavigationController *myNav = [[FPNavigationController alloc] initWithRootViewController:myVC];
    
    // 3. 创建标签栏控制器
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[recommendNav, chartNav, myNav];
    
    self.tabBarCtr = tabBarController;
    self.tabBarCtr.delegate = self;
    
    NSInteger selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"UDTabBarSelectedIndex"];
    tabBarController.selectedIndex = selectedIndex;
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"selectedIndex:%ld", tabBarController.selectedIndex);
    
    [[NSUserDefaults standardUserDefaults] setInteger:tabBarController.selectedIndex forKey:@"UDTabBarSelectedIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - getter && setter

@end
