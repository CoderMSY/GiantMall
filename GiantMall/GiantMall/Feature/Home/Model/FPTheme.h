//
//  FPTheme.h
//
//
//  Created by JSONConverter on 2025/11/30.
//  Copyright © 2025年 JSONConverter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

@class FPThemeIndex_iconenter_4;
@class FPThemeIndex_poster;
@class FPThemeIndex_iconenter_5;
@class FPThemeIndex_iconenter;
@class FPThemeHeader_bgsrc;
@class FPThemeHeader_bgsrcBackground_color;
@class FPThemeIndex_banner;
@class FPThemeIndex_textenter;

@interface FPTheme: NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *coupon_num;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *header_bgcolor;
@property (nonatomic, strong) FPThemeHeader_bgsrc *header_bgsrc;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSArray<FPThemeIndex_banner *> *index_banner;
@property (nonatomic, strong) NSArray<NSString *> *index_banner_2;
@property (nonatomic, strong) NSArray<NSString *> *index_banner_3;
@property (nonatomic, strong) NSArray<NSString *> *index_banner_4;
@property (nonatomic, strong) NSArray<NSString *> *index_banner_5;
@property (nonatomic, strong) NSArray<FPThemeIndex_iconenter *> *index_iconenter;
@property (nonatomic, strong) NSArray<NSString *> *index_iconenter_2;
@property (nonatomic, strong) NSArray<NSString *> *index_iconenter_3;
@property (nonatomic, strong) NSArray<FPThemeIndex_iconenter_4 *> *index_iconenter_4;
@property (nonatomic, strong) NSArray<FPThemeIndex_iconenter_5 *> *index_iconenter_5;
@property (nonatomic, strong) NSArray<FPThemeIndex_poster *> *index_poster;
@property (nonatomic, strong) NSArray<FPThemeIndex_poster *> *index_poster_2;
@property (nonatomic, strong) NSArray<FPThemeIndex_poster *> *index_poster_3;
@property (nonatomic, strong) NSArray<FPThemeIndex_poster *> *index_poster_4;
@property (nonatomic, strong) NSArray<FPThemeIndex_poster *> *index_poster_5;
@property (nonatomic, strong) NSArray<FPThemeIndex_textenter *> *index_textenter;
@property (nonatomic, strong) NSArray<NSString *> *index_textenter_2;
@property (nonatomic, strong) NSArray<NSString *> *index_textenter_3;
@property (nonatomic, copy) NSString *keywords_preset;
@property (nonatomic, copy) NSString *title;
@end

@interface FPThemeIndex_iconenter_4: NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *open_type;
@property (nonatomic, copy) NSString *text;
@end

@interface FPThemeIndex_poster: NSObject
@property (nonatomic, copy) NSString *huawei;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *open_type;
@property (nonatomic, copy) NSString *src;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *video;
@end

@interface FPThemeIndex_iconenter_5: NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *open_type;
@property (nonatomic, copy) NSString *text;
@end

@interface FPThemeIndex_iconenter: NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *open_type;
@property (nonatomic, copy) NSString *text;
@end

@interface FPThemeHeader_bgsrc: NSObject
@property (nonatomic, strong) FPThemeHeader_bgsrcBackground_color *background_color;
@property (nonatomic, copy) NSString *background_img;
@property (nonatomic, copy) NSString *type;
@end

@interface FPThemeHeader_bgsrcBackground_color: NSObject
@property (nonatomic, copy) NSString *thmem_color_deg;
@property (nonatomic, copy) NSString *thmem_color_first;
@property (nonatomic, copy) NSString *thmem_color_last;
@end

@interface FPThemeIndex_banner: NSObject
@property (nonatomic, copy) NSString *huawei;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *open_type;
@property (nonatomic, copy) NSString *skip_url;
@end

@interface FPThemeIndex_textenter: NSObject
@property (nonatomic, copy) NSString *open_type;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *url;
@end
