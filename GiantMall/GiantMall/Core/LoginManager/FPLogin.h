//
//  FPLogin.h
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface FPLogin : NSObject
//<NSCoding>

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *dealer_dealerCode;
@property (nonatomic, copy) NSString *dealer_dealername;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *ordering_store;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *role_code;
@property (nonatomic, copy) NSString *role_name;
@property (nonatomic, copy) NSString *role_type;
@property (nonatomic, copy) NSString *sbuCode;
@property (nonatomic, copy) NSString *service_shopno;
@property (nonatomic, copy) NSString *store_shopno;
@property (nonatomic, copy) NSString *store_storename;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) NSArray<NSString *> *usertype;

@end

NS_ASSUME_NONNULL_END
