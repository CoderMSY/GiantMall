//
//  FPTheme.m
//
//
//  Created by JSONConverter on 2025/11/30.
//  Copyright © 2025年 JSONConverter. All rights reserved.
//

#import "FPTheme.h"

@implementation FPTheme 
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"index_banner": [FPThemeIndex_banner class],
             @"index_iconenter": [FPThemeIndex_iconenter class],
             @"index_iconenter_4": [FPThemeIndex_iconenter_4 class],
             @"index_iconenter_5": [FPThemeIndex_iconenter_5 class],
             @"index_poster": [FPThemeIndex_poster class],
             @"index_poster_2": [FPThemeIndex_poster class],
             @"index_poster_3": [FPThemeIndex_poster class],
             @"index_poster_4": [FPThemeIndex_poster class],
             @"index_poster_5": [FPThemeIndex_poster class],
             @"index_textenter": [FPThemeIndex_textenter class]};
}

@end

@implementation FPThemeIndex_iconenter_4 
@end

@implementation FPThemeIndex_poster 
@end

@implementation FPThemeIndex_iconenter_5 
@end

@implementation FPThemeIndex_iconenter 
@end

@implementation FPThemeHeader_bgsrc 
@end

@implementation FPThemeHeader_bgsrcBackground_color 
@end

@implementation FPThemeIndex_banner 
@end

@implementation FPThemeIndex_textenter 
@end
