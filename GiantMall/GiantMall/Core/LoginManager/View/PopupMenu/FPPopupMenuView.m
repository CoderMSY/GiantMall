//
//  FPPopupMenuView.m
//  FPAccount
//
//  Created by Simon Miao on 2025/10/23.
//

#import "FPPopupMenuView.h"
#import <Masonry/Masonry.h>
#import "FPColorConfig.h"
//#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//#define kMenuItemHeight 54 // 每个选项高度
//#define kMenuWidth kScreenWidth * 0.8 // 菜单宽度（80%屏幕宽）

#define kMenuItemHeight 44
#define kMenuWidth 160 // 菜单宽度
#define kArrowHeight 8 // 箭头高度

UIWindow *FPGetKeyWindow(void) {
    UIWindow *keyWindow = nil;
    if (@available(iOS 13.0, *)) {
        // iOS 13+：从场景中获取活跃窗口
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        keyWindow = window;
                        break;
                    }
                }
                if (keyWindow) break;
            }
        }
    } else {
        // iOS 12 及以下：直接使用 keyWindow
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    return keyWindow;
}

@interface FPPopupMenuView ()

@property (nonatomic, strong) UIView *currentMaskView; // 遮罩层
@property (nonatomic, strong) UIView *menuContainer; // 菜单容器
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<UIImage *> *icons;

@property (nonatomic, strong) UIView *arrowView; // 指向按钮的箭头

@end

@implementation FPPopupMenuView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles icons:(NSArray<UIImage *> *)icons {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _titles = titles.copy;
        _icons = icons;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    // 1. 遮罩层（半透明黑色，点击关闭）
    self.currentMaskView = [[UIView alloc] initWithFrame:self.bounds];
    self.currentMaskView.backgroundColor = [UIColor blackColor];
    self.currentMaskView.alpha = 0;
    [self addSubview:self.currentMaskView];
    
    UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.currentMaskView addGestureRecognizer:maskTap];
    
    // 2. 箭头视图（三角形）
    self.arrowView = [[UIView alloc] init];
    self.arrowView.backgroundColor = [UIColor whiteColor];
    self.arrowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.arrowView.layer.shadowOpacity = 0.1;
    self.arrowView.layer.shadowRadius = 4;
    self.arrowView.hidden = YES;
    [self addSubview:self.arrowView];
    
    // 2. 菜单容器（白色背景，圆角）
    CGFloat menuHeight = _titles.count * kMenuItemHeight;
    self.menuContainer = [[UIView alloc] init];
    self.menuContainer.backgroundColor = [UIColor systemBackgroundColor]; //_FPAppColors.background;
    self.menuContainer.layer.cornerRadius = 12;
//    self.menuContainer.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.menuContainer.layer.shadowOpacity = 0.1;
//    self.menuContainer.layer.shadowRadius = 4;
    self.menuContainer.layer.borderWidth = 1;
    self.menuContainer.layer.borderColor = [UIColor systemGrayColor].CGColor;
    
    self.menuContainer.clipsToBounds = NO; // 允许阴影超出边界
//    self.menuContainer.clipsToBounds = YES;
    [self addSubview:self.menuContainer];
    
    // 菜单初始位置（屏幕底部外面）
    [self.menuContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(menuHeight); // 初始隐藏在底部
        make.width.mas_equalTo(kMenuWidth);
        make.height.mas_equalTo(menuHeight);
    }];
    
    // 3. 添加菜单项
    for (NSInteger i = 0; i < _titles.count; i++) {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.tag = i;
        [itemBtn setTitle:_titles[i] forState:UIControlStateNormal];
        [itemBtn setTitleColor:[FPColorConfig textPrimaryColor] forState:UIControlStateNormal];
        [itemBtn setImage:self.icons[i] forState:UIControlStateNormal]; // 本地图标
    
        itemBtn.tintColor = [FPColorConfig buttonTintColor];
//        itemBtn.tintColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
//            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ? [UIColor whiteColor] : [UIColor blackColor];
//        }];
        
        itemBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        // 调整图标和文字间距
        if (@available(iOS 15.0, *)) {
            // iOS 15+ 使用 configuration
            UIButtonConfiguration *config = itemBtn.configuration ?: [UIButtonConfiguration plainButtonConfiguration];
            config.image = itemBtn.currentImage;
            config.title = itemBtn.currentTitle;
            config.imagePadding = 10; // 图文间距
            config.contentInsets = NSDirectionalEdgeInsetsMake(8, 16, 8, 16);
            itemBtn.configuration = config;
        } else {
            // iOS 14 及以下使用旧属性
            itemBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0); // 文字在图标右侧，间距10
            itemBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 16, 8, 16);
        }
        
        [itemBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuContainer addSubview:itemBtn];
        
        [itemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.menuContainer);
            make.top.mas_equalTo(i * kMenuItemHeight);
            make.height.mas_equalTo(kMenuItemHeight);
        }];
        
        // 添加分割线（除了最后一个）
        if (i != _titles.count - 1) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = [UIColor lightGrayColor];
            line.alpha = 0.2;
            [self.menuContainer addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.menuContainer).inset(15);
                make.top.mas_equalTo(itemBtn.mas_bottom);
                make.height.mas_equalTo(0.5);
            }];
        }
    }
}

// 菜单项点击
- (void)itemClick:(UIButton *)btn {
    if (self.selectBlock) {
        self.selectBlock(btn.tag);
    }
    [self dismiss];
}

// 显示菜单（带动画）
- (void)show {
    // 添加到窗口
    UIWindow *window = FPGetKeyWindow();
    [window addSubview:self];
    
    // 动画：遮罩变半透明，菜单上移
    [UIView animateWithDuration:0.3 animations:^{
        self.currentMaskView.alpha = 0.5;
        [self.menuContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-20); // 显示在底部，距底部20
        }];
        [self.menuContainer layoutIfNeeded];
    }];
}

// 关键：从锚点坐标显示弹窗
- (void)showFromAnchorPoint:(CGPoint)anchorPoint {
    NSLog(@"anchorPoint: %@", NSStringFromCGPoint(anchorPoint));
    // 添加到窗口
    UIWindow *window = FPGetKeyWindow();
    self.frame = window.bounds;
    [window addSubview:self];
    self.currentMaskView.frame = self.bounds;
    
    // 计算菜单位置（按钮下方，左对齐）
    CGFloat menuY = anchorPoint.y + kArrowHeight; // 按钮Y + 箭头高度
    CGFloat menuX = anchorPoint.x; // 与按钮左对齐（可根据需要调整）
    
    CGFloat margin_right = 15.0;
    
    // 调整菜单X，避免超出屏幕右侧
    if (menuX + kMenuWidth + margin_right > self.bounds.size.width) {
        menuX = self.bounds.size.width - kMenuWidth - margin_right; // 右对齐屏幕边缘
    }
    
    // 菜单容器约束
    [self.menuContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(menuX);
        make.top.mas_equalTo(menuY);
        make.width.mas_equalTo(kMenuWidth);
        make.height.mas_equalTo(_titles.count * kMenuItemHeight);
    }];
    
    // 箭头位置（指向按钮底部中间）
    //CGFloat arrowX = anchorPoint.x - menuX + (self.navigationItem.rightBarButtonItem.width ?: 30)/2; // 按钮宽度默认30
    CGFloat arrowX = 30;
    [self.arrowView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(arrowX - kArrowHeight/2); // 箭头中心点对齐按钮中心
        make.bottom.mas_equalTo(self.menuContainer.mas_top);
        make.width.mas_equalTo(kArrowHeight);
        make.height.mas_equalTo(kArrowHeight);
    }];
    // 绘制箭头（旋转45度的正方形，形成三角形）
    self.arrowView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    // 动画显示
    self.menuContainer.alpha = 0;
    self.menuContainer.transform = CGAffineTransformMakeTranslation(0, -10); // 上移10pt隐藏
    [UIView animateWithDuration:0.25 animations:^{
        self.currentMaskView.alpha = 0.3;
        self.menuContainer.alpha = 1;
        self.menuContainer.transform = CGAffineTransformIdentity;
    }];
}

// 隐藏菜单（带动画）
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.currentMaskView.alpha = 0;
        self.menuContainer.alpha = 0;
        self.menuContainer.transform = CGAffineTransformMakeTranslation(0, -10);
//        [self.menuContainer mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self.mas_bottom).offset(self.menuContainer.bounds.size.height);
//        }];
//        [self.menuContainer layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
