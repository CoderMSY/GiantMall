//
//  FPPopupMenuView.h
//  FPAccount
//
//  Created by Simon Miao on 2025/10/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MenuSelectBlock)(NSInteger index); // 选中回调（返回选项索引）

@interface FPPopupMenuView : UIView

// 初始化菜单（标题数组+图标数组）
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles icons:(NSArray<NSString *> *)icons;

// 显示菜单
- (void)show;
- (void)showFromAnchorPoint:(CGPoint)anchorPoint;
// 隐藏菜单
- (void)dismiss;

// 选中回调
@property (nonatomic, copy) MenuSelectBlock selectBlock;

@end

NS_ASSUME_NONNULL_END
