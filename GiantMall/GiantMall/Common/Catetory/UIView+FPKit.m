//
//  UIView+FPKit.m
//  ZJCLifeSDK
//
//  Created by Simon Miao on 2023/3/28.
//

#import "UIView+FPKit.h"

@implementation UIView (FPKit)

- (CGFloat)fp_left {
    return self.frame.origin.x;
}

///
- (void)setFp_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

///
- (CGFloat)fp_top {
    return self.frame.origin.y;
}

///
- (void)setFp_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

///
- (CGFloat)fp_right {
    return self.frame.origin.x + self.frame.size.width;
}

///
- (void)setFp_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

///
- (CGFloat)fp_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

///
- (void)setFp_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

///
- (CGFloat)fp_centerX {
    return self.center.x;
}

///
- (void)setFp_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

///
- (CGFloat)fp_centerY {
    return self.center.y;
}


///
- (void)setFp_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///
- (CGFloat)fp_width {
    return self.frame.size.width;
}


///
- (void)setFp_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///
- (CGFloat)fp_height {
    return self.frame.size.height;
}


///
- (void)setFp_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
///
- (CGPoint)fp_origin {
    return self.frame.origin;
}


///
- (void)setFp_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGSize)fp_size {
    return self.frame.size;
}

- (void)setFp_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (UIViewController *)fp_viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (UITableViewCell *)fp_tableViewCell {
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell*)nextResponder;
        }
    }
    return nil;
}

@end
