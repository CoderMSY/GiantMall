//
//  FPLoginView.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPLoginView.h"
#import <Masonry/Masonry.h>

@interface FPLoginView () <UITextFieldDelegate>
// 输入框
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
// 开关
@property (nonatomic, strong) UISwitch *rememberPwdSwitch;
@property (nonatomic, strong) UISwitch *autoLoginSwitch;
// 按钮
@property (nonatomic, strong) UIButton *loginBtn;
// 辅助标签
@property (nonatomic, strong) UILabel *forgetPwdLabel;
@property (nonatomic, strong) UILabel *registerLabel;
@end

@implementation FPLoginView

#pragma mark - 生命周期

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupEvent];
        
        // 自动填充记住的密码（模拟本地缓存）
        [self loadRememberedAccount];
    }
    return self;
}

#pragma mark - UI初始化
- (void)setupUI {    
    // ========== 1. 标题 ==========
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"账号登录";
    titleLabel.font = [UIFont boldSystemFontOfSize:28];
    titleLabel.textColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
    [self addSubview:titleLabel];
    
    // ========== 2. 账号输入框 ==========
    self.accountTextField = [[UITextField alloc] init];
    self.accountTextField.placeholder = @"请输入手机号/邮箱";
    self.accountTextField.font = [UIFont systemFontOfSize:16];
    self.accountTextField.textColor = [UIColor blackColor];
    self.accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing; // 清除按钮
    self.accountTextField.returnKeyType = UIReturnKeyNext; // 下一步
    self.accountTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.accountTextField.delegate = self;
    // 左侧图标（带边距）：
    UIEdgeInsets accountPadding = UIEdgeInsetsMake(0, 15, 0, 5); // 上0、左15、下0、右5
    UIView *accountLeftView = [self customLeftViewWithImage:[UIImage systemImageNamed:@"person.circle.fill"] padding:accountPadding];
    
    self.accountTextField.leftView = accountLeftView;
    self.accountTextField.leftViewMode = UITextFieldViewModeAlways;
    // 输入框样式
    self.accountTextField.layer.cornerRadius = 8;
    self.accountTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.accountTextField.layer.borderWidth = 0.5;
    self.accountTextField.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.accountTextField];
    
    // ========== 3. 密码输入框 ==========
    self.pwdTextField = [[UITextField alloc] init];
    self.pwdTextField.placeholder = @"请输入密码";
    self.pwdTextField.font = [UIFont systemFontOfSize:16];
    self.pwdTextField.textColor = [UIColor blackColor];
    self.pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdTextField.returnKeyType = UIReturnKeyDone; // 完成
    self.pwdTextField.secureTextEntry = YES; // 密码隐藏
    self.pwdTextField.delegate = self;
    // 左侧图标（带边距）：
    UIEdgeInsets pwdPadding = UIEdgeInsetsMake(0, 15, 0, 5); // 与账号框一致的边距
    UIView *pwdLeftView = [self customLeftViewWithImage:[UIImage systemImageNamed:@"lock.circle.fill"] padding:pwdPadding];
    
    self.pwdTextField.leftView = pwdLeftView;
    self.pwdTextField.leftViewMode = UITextFieldViewModeAlways;
    // 输入框样式
    self.pwdTextField.layer.cornerRadius = 8;
    self.pwdTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.pwdTextField.layer.borderWidth = 0.5;
    self.pwdTextField.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pwdTextField];
    
    // ========== 4. 记住密码开关 ==========
    UILabel *rememberLabel = [[UILabel alloc] init];
    rememberLabel.text = @"记住密码";
    rememberLabel.font = [UIFont systemFontOfSize:14];
    rememberLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:rememberLabel];
    
    self.rememberPwdSwitch = [[UISwitch alloc] init];
    self.rememberPwdSwitch.onTintColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview:self.rememberPwdSwitch];
    
    // ========== 5. 自动登录开关 ==========
    UILabel *autoLoginLabel = [[UILabel alloc] init];
    autoLoginLabel.text = @"自动登录";
    autoLoginLabel.font = [UIFont systemFontOfSize:14];
    autoLoginLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:autoLoginLabel];
    
    self.autoLoginSwitch = [[UISwitch alloc] init];
    self.autoLoginSwitch.onTintColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview:self.autoLoginSwitch];
    
    // ========== 6. 登录按钮 ==========
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:0.5]]; // 默认置灰
    self.loginBtn.layer.cornerRadius = 8;
    self.loginBtn.enabled = NO; // 默认不可点击
    [self addSubview:self.loginBtn];
    
    // ========== 7. 忘记密码/注册 ==========
    self.forgetPwdLabel = [[UILabel alloc] init];
    self.forgetPwdLabel.text = @"忘记密码？";
    self.forgetPwdLabel.font = [UIFont systemFontOfSize:14];
    self.forgetPwdLabel.textColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    self.forgetPwdLabel.userInteractionEnabled = YES; // 可点击
    [self addSubview:self.forgetPwdLabel];
    
    self.registerLabel = [[UILabel alloc] init];
    self.registerLabel.text = @"注册账号";
    self.registerLabel.font = [UIFont systemFontOfSize:14];
    self.registerLabel.textColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    self.registerLabel.userInteractionEnabled = YES;
    [self addSubview:self.registerLabel];
    
    // 约束（Masonry）
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(100);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(40);
        make.left.equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right).offset(-30);
        make.height.equalTo(@50);
    }];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountTextField.mas_bottom).offset(20);
        make.left.right.height.equalTo(self.accountTextField);
    }];
    
    [rememberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(20);
        make.left.equalTo(self.accountTextField.mas_left);
        make.centerY.equalTo(self.rememberPwdSwitch.mas_centerY);
    }];
    
    [self.rememberPwdSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rememberLabel.mas_right).offset(10);
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(20);
    }];
    
    [autoLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.rememberPwdSwitch.mas_right).offset(10);
        make.right.equalTo(self.autoLoginSwitch.mas_left).offset(-10);
        make.centerY.equalTo(self.autoLoginSwitch.mas_centerY);
    }];
    
    [self.autoLoginSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rememberPwdSwitch.mas_top);
        make.right.equalTo(self.accountTextField.mas_right);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rememberPwdSwitch.mas_bottom).offset(40);
        make.left.right.height.equalTo(self.accountTextField);
    }];
    
    [self.forgetPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(30);
        make.right.equalTo(self.mas_centerX).offset(-20);
        make.bottom.equalTo(self).offset(-20);
    }];
    
    [self.registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgetPwdLabel.mas_top);
        make.left.equalTo(self.mas_centerX).offset(20);
        make.bottom.equalTo(self).offset(-20);
    }];
}

#pragma mark - 工具方法：创建带边距的TextField LeftView
- (UIView *)customLeftViewWithImage:(UIImage *)image padding:(UIEdgeInsets)padding {
    // 1. 创建图标ImageView
    UIImageView *iconView = [[UIImageView alloc] initWithImage:image];
    iconView.tintColor = [UIColor grayColor];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    // 2. 计算图标尺寸（固定22x22）
    CGFloat iconSize = 30;
    iconView.frame = CGRectMake(padding.left, padding.top, iconSize, iconSize);
    
    // 3. 创建容器视图（承载图标，通过容器控制边距）
    CGFloat containerWidth = padding.left + iconSize + padding.right;
    CGFloat containerHeight = padding.top + iconSize + padding.bottom;
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerWidth, containerHeight)];
    [containerView addSubview:iconView];
    
    return containerView;
}

#pragma mark - 事件绑定
- (void)setupEvent {
    // 输入框文字变化监听
    [self.accountTextField addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTextField addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    
    // 登录按钮点击
    [self.loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 忘记密码点击
    UITapGestureRecognizer *forgetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPwdClicked:)];
    [self.forgetPwdLabel addGestureRecognizer:forgetTap];
    
    // 注册点击
    UITapGestureRecognizer *registerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerClicked:)];
    [self.registerLabel addGestureRecognizer:registerTap];
}

#pragma mark - 输入框事件
- (void)textFieldTextChanged:(UITextField *)textField {
    // 检查账号和密码是否都有内容，更新登录按钮状态
    BOOL accountHasText = self.accountTextField.text.length > 0;
    BOOL pwdHasText = self.pwdTextField.text.length > 0;
    
    self.loginBtn.enabled = (accountHasText && pwdHasText);
    self.loginBtn.backgroundColor = self.loginBtn.enabled ?
        [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] :
        [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:0.5];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.accountTextField) {
        [self.pwdTextField becomeFirstResponder]; // 账号框回车，聚焦密码框
    } else {
        [self endEditing:YES]; // 密码框回车，收起键盘
    }
    return YES;
}

#pragma mark - 业务逻辑
/// 加载本地记住的账号密码
- (void)loadRememberedAccount {
    // 模拟从NSUserDefaults读取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isRemember = [defaults boolForKey:@"isRememberPwd"];
    if (isRemember) {
        self.accountTextField.text = [defaults stringForKey:@"loginAccount"];
        self.pwdTextField.text = [defaults stringForKey:@"loginPwd"];
        self.rememberPwdSwitch.on = YES;
        
        self.loginBtn.enabled = (self.accountTextField.text && self.pwdTextField.text);
        
        // 自动登录
        BOOL isAutoLogin = [defaults boolForKey:@"isAutoLogin"];
        self.autoLoginSwitch.on = isAutoLogin;
        if (isAutoLogin) {
            [self loginBtnClicked:nil]; // 自动登录
        }
    }
}

/// 登录按钮点击
- (void)loginBtnClicked:(UIButton *)sender {
    [self endEditing:YES];
    NSString *account = self.accountTextField.text;
    NSString *pwd = self.pwdTextField.text;
    
    if ([self.delegate respondsToSelector:@selector(loginView:loginWithAccount:pwd:isRememberPwd:isAutoLogin:)]) {
        [self.delegate loginView:self loginWithAccount:account pwd:pwd isRememberPwd:self.rememberPwdSwitch.on isAutoLogin:self.autoLoginSwitch.on];
    }
}

/// 忘记密码点击
- (void)forgetPwdClicked:(UITapGestureRecognizer *)tap {
    [self showToast:@"跳转到忘记密码页面"];
    // 实际开发中跳转忘记密码VC
    // [self.navigationController pushViewController:[[ForgetPwdViewController alloc] init] animated:YES];
}

/// 注册点击
- (void)registerClicked:(UITapGestureRecognizer *)tap {
    [self showToast:@"跳转到注册页面"];
    // 实际开发中跳转注册VC
    // [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}

/// 提示框（简易版）
- (void)showToast:(NSString *)msg {
    UILabel *toast = [[UILabel alloc] init];
    toast.text = msg;
    toast.font = [UIFont systemFontOfSize:14];
    toast.textColor = [UIColor whiteColor];
    toast.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    toast.textAlignment = NSTextAlignmentCenter;
    toast.layer.cornerRadius = 15;
    toast.clipsToBounds = YES;
    [self addSubview:toast];
    
    [toast mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.greaterThanOrEqualTo(@200);
        make.height.equalTo(@30);
        make.left.greaterThanOrEqualTo(self.mas_left).offset(30);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-30);
    }];
    
    // 2秒后消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            toast.alpha = 0;
        } completion:^(BOOL finished) {
            [toast removeFromSuperview];
        }];
    });
}


@end
