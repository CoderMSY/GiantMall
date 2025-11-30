//
//  UIView+FPKit.h
//  ZJCLifeSDK
//
//  Created by Simon Miao on 2023/3/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FPKit)

@property (nonatomic) CGFloat fp_left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat fp_top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat fp_right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat fp_bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat fp_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat fp_height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat fp_centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat fp_centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint fp_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize fp_size;

/** 找到自己的vc */
- (UIViewController *)fp_viewController;

/**
 获取父视图tableViewCell

 @return 父视图tableViewCell
 */
- (UITableViewCell *)fp_tableViewCell;

@end

NS_ASSUME_NONNULL_END
