//
//  FPLoginViewController.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPLoginViewController.h"
#import <Masonry/Masonry.h>
#import "UIView+FPLoading.h"
#import "FPLoginView.h"
#import "FPLoginRequest.h"
#import "FPLoginManager.h"
#import "FPAppInteractor.h"

@interface FPLoginViewController () <FPLoginViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) FPLoginView *loginView;

@end

@implementation FPLoginViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航栏（如需）
    self.navigationController.navigationBar.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // 点击空白处收起键盘
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - public methods

#pragma mark - private methods

- (void)setupUI {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.loginView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
    }];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 内容容器的4个边缘与ScrollView的4个边缘对齐（宽度与ScrollView一致）
        make.edges.mas_equalTo(self.scrollView);
        // 强制内容容器的宽度与ScrollView宽度一致（避免水平滚动，若需水平滚动可删除此句）
        make.width.equalTo(self.scrollView);
        // 注意：内容容器的高度无需设置！会由内部子控件的约束自动撑开，从而决定ScrollView的contentSize.height
    }];
}

#pragma mark - FPLoginViewDelegate

- (void)loginView:(FPLoginView *)loginView loginWithAccount:(NSString *)account pwd:(NSString *)pwd isRememberPwd:(BOOL)isRememberPwd isAutoLogin:(BOOL)isAutoLogin {
    // 1. 简单校验
    if (account.length == 0 || pwd.length == 0) {
        [self.view fp_postMessage:@"账号或密码不能为空"];
        
        return;
    }
    
    // 2. 显示加载框
//    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    loading.center = self.loginBtn.center;
//    [loading startAnimating];
//    [self addSubview:loading];
    self.loginView.loginBtn.enabled = NO;
    
    // 3. 模拟登录请求（替换为实际的YTKRequest/AFNetworking请求）
    [self.view fp_postLoading];
    
    FPLoginRequest *request = [[FPLoginRequest alloc] initWithUserName:account password:pwd];
    [request reqWithSuccess:^(FPRequest * _Nonnull request, NSDictionary * _Nullable resDic) {
        [self.view fp_hideLoading];
        self.loginView.loginBtn.enabled = YES;
        
        NSDictionary *dataDic = [resDic tm_dictionaryForKey:@"data"];
        FPLogin *login = [FPLogin mj_objectWithKeyValues:dataDic];
        [[FPLoginManager sharedInstance] saveCurrentLoginModel:login];
        
        
        // 保存记住密码/自动登录
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:isRememberPwd forKey:@"isRememberPwd"];
        [defaults setBool:isAutoLogin forKey:@"isAutoLogin"];
        if (isRememberPwd) {
            [defaults setObject:account forKey:@"loginAccount"];
            [defaults setObject:pwd forKey:@"loginPwd"]; // 注意：真实环境密码需加密存储
        } else {
            [defaults removeObjectForKey:@"loginAccount"];
            [defaults removeObjectForKey:@"loginPwd"];
        }
        [defaults synchronize];
        
        [self.view fp_postMessage:@"登录成功"];
        // 跳转到首页
        [[FPAppInteractor sharedInstance] startMain];
        
    } failure:^(FPRequest * _Nonnull request, NSInteger resultCode, NSString * _Nullable errorMsg) {
        [self.view fp_hideLoading];
        [self.view fp_postMessage:errorMsg];
    }];
}

#pragma mark - getter && setter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (FPLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[FPLoginView alloc] init];
        _loginView.delegate = self;
    }
    return _loginView;
}

@end
