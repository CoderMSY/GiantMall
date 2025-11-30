//
//  FPLogin.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPLogin.h"

@implementation FPLogin

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"userId" : @"id"
    };
}

#pragma mark - NSCoding 协议（核心：指定归档/解档字段）
// 解档：从二进制解码为对象属性

//- (instancetype)initWithCoder:(NSCoder *)decoder {
//    self = [super init];
//        if (self) {
//            self.avatar = [decoder decodeObjectForKey:@"avatar"];
//            self.dealer_dealerCode = [decoder decodeObjectForKey:@"dealer_dealerCode"];
//            self.dealer_dealername = [decoder decodeObjectForKey:@"dealer_dealername"];
//            self.userId = [decoder decodeObjectForKey:@"userId"];
//            self.nickname = [decoder decodeObjectForKey:@"nickname"];
//            self.ordering_store = [decoder decodeObjectForKey:@"ordering_store"];
//            self.realname = [decoder decodeObjectForKey:@"remark"];
//            self.role_code = [decoder decodeObjectForKey:@"remark"];
//            self.role_name = [decoder decodeObjectForKey:@"remark"];
//            self.role_type = [decoder decodeObjectForKey:@"remark"];
//            self.sbuCode = [decoder decodeObjectForKey:@"remark"];
//            self.service_shopno = [decoder decodeObjectForKey:@"service_shopno"];
//            self.store_shopno = [decoder decodeObjectForKey:@"store_shopno"];
//            self.store_storename = [decoder decodeObjectForKey:@"store_storename"];
//            self.token = [decoder decodeObjectForKey:@"token"];
//            self.user_name = [decoder decodeObjectForKey:@"user_name"];
//            self.username = [decoder decodeObjectForKey:@"username"];
//            self.usertype = [decoder decodeObjectForKey:@"usertype"];
//        }
//        return self;
//}

// 归档：将对象属性编码为二进制
//- (void)encodeWithCoder:(NSCoder *)coder {
//    // 按key存储属性（key需与解档时一致）
//    [coder encodeObject:self.avatar forKey:@"avatar"];
//    [coder encodeObject:self.dealer_dealerCode forKey:@"dealer_dealerCode"]; // CGFloat用encodeDouble
//    [coder encodeObject:self.dealer_dealername forKey:@"dealer_dealername"];
//    [coder encodeObject:self.userId forKey:@"userId"];
//    [coder encodeObject:self.nickname forKey:@"nickname"];
//    [coder encodeObject:self.ordering_store forKey:@"ordering_store"];
//    [coder encodeObject:self.realname forKey:@"realname"];
//    [coder encodeObject:self.role_code forKey:@"role_code"];
//    [coder encodeObject:self.role_name forKey:@"role_name"];
//    [coder encodeObject:self.role_type forKey:@"role_type"];
//    [coder encodeObject:self.sbuCode forKey:@"sbuCode"];
//    [coder encodeObject:self.service_shopno forKey:@"service_shopno"];
//    [coder encodeObject:self.store_shopno forKey:@"store_shopno"];
//    [coder encodeObject:self.store_storename forKey:@"store_storename"];
//    [coder encodeObject:self.token forKey:@"token"];
//    [coder encodeObject:self.user_name forKey:@"user_name"];
//    [coder encodeObject:self.username forKey:@"username"];
//    [coder encodeObject:self.usertype forKey:@"usertype"];
//}



@end
