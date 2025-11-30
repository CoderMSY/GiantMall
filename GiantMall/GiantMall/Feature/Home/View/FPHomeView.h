//
//  FPHomeView.h
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FPHomeCellModel;
@interface FPHomeView : UIView

@property (nonatomic, copy) NSArray <FPHomeCellModel *>*homeList;

@end

NS_ASSUME_NONNULL_END
