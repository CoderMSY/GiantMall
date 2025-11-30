//
//  FPThemeRequest.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/29.
//

#import "FPThemeRequest.h"
//#import <AFNetworking/AFNetworking.h>

@implementation FPThemeRequest

- (NSString *)requestUrl {
    return @"index.php/goods/index_theme";
}

//- (AFConstructingBlock)constructingBodyBlock {
//    return ^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%.f", self.timestamp] dataUsingEncoding:NSUTF8StringEncoding]
//                                        name:@"current_time"];
//    };
//}

- (id)requestArgument {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    param[@"current_time"] = [NSNumber numberWithInteger:self.timestamp];
    
    return param;
}

@end
