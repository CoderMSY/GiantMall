//
//  FPRequest.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/29.
//

#import "FPRequest.h"
#import <MJExtension/MJExtension.h>

@implementation FPRequest

#pragma mark - public methods

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP; // 必须使用 HTTP 才能 multipart
}

- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeHTTP;
}

// ❗❗ 关键：设置 form-urlencoded
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return @{
        @"Content-Type": @"application/x-www-form-urlencoded"
    };
}

/// 默认post请求
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)baseUrl {
    NSString *baseUrl = @"https://e-gw.giant.com.cn";
    
    return baseUrl;
}

- (void)reqWithSuccess:(FPRequestSuccess _Nullable)success
               failure:(FPRequestFailure _Nullable)failure {
    
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self requestFinished:request success:success failure:failure];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString *logStr = [NSString stringWithFormat:@"👻👻👻:request failure:%@, \n statusCode:%ld error:%@", request.description, request.responseStatusCode, request.error.description];
        NSLog(@"%@", logStr);
        
        if (failure) {
            failure(self, request.responseStatusCode, @"网络请求失败，请稍后再试");
        }
    }];
}



#pragma mark - private methods

- (void)requestFinished:(YTKBaseRequest *)request success:(FPRequestSuccess)success failure:(FPRequestFailure)failure {
    id responseObj = [request.responseString mj_JSONObject];
    
    if (![responseObj isKindOfClass:[NSDictionary class]]) {
        NSLog(@"request success data error:%@", @"回调数据有误，不是字典，请单独解析或让后台统一格式(推荐)");
        if (failure) {
            failure(self, self.responseStatusCode, @"回调数据有误");
        }
        
        return;
    }
    NSDictionary *resultDic = (NSDictionary *)responseObj;
    
    NSInteger resultCode;
    NSNumber *code = [resultDic objectForKey:@"status"];
    if (code) {
        resultCode = code.integerValue;
    }
    else {
        resultCode = -10000;
    }
    
    if (1 == resultCode) {
//        id data = [resultDic tm_safeObjectForKey:@"data"];
        if (success) {
            success(self, resultDic);
        }
        return;
    }
    else {
        NSString *errorMsg = [resultDic objectForKey:@"msg"];
        if (failure) {
            failure(self, resultCode, errorMsg);
        }
    }
}


@end
