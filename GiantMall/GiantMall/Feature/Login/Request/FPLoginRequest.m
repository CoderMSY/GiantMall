//
//  FPLoginRequest.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPLoginRequest.h"

@interface FPLoginRequest()
{
    NSString *_userName;
    NSString *_password;
}

@end

@implementation FPLoginRequest

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password
{
    self = [super init];
    if (self) {
        _userName = userName;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/index.php/login/login";
}

- (id)requestArgument {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    param[@"username"] = _userName;
    param[@"password"] = _password;
    
    return param;
}

@end
