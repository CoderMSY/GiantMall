//
//  FPGood.h
//
//
//  Created by JSONConverter on 2025/11/30.
//  Copyright © 2025年 JSONConverter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>


@interface FPGood: NSObject
@property (nonatomic, assign) NSInteger brand_id;
@property (nonatomic, copy) NSString *deduction_max_points;
@property (nonatomic, assign) NSInteger deduction_max_price;
@property (nonatomic, assign) NSInteger deduction_proportion;
@property (nonatomic, copy) NSString *goods_attr;
@property (nonatomic, copy) NSString *goods_no;
@property (nonatomic, copy) NSString *goods_type;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price_max;
@property (nonatomic, copy) NSString *price_min;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) NSInteger total_sales;
@property (nonatomic, copy) NSString *virtual_store;
@property (nonatomic, assign) NSInteger visit;
@end
