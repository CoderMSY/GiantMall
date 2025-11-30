//
//  FPRequestBlockDefine.h
//  PocketBook
//
//  Created by Simon Miao on 2023/12/10.
//  Copyright © 2023 FancyPower. All rights reserved.
//

#ifndef FPRequestBlockDefine_h
#define FPRequestBlockDefine_h

@class FPRequest;
///设置para为NSDictionary减少后期判断，个别回调数据不是NSDictionary，请调用父类startWithCompletionBlockWithSuccess请求 (resDic数据结构:{"code":10000,"success":true,"data": "","msg":"操作成功","requestId":""})
typedef void(^FPRequestSuccess)(FPRequest * _Nonnull request, NSDictionary *_Nullable resDic);
typedef void(^FPRequestFailure)(FPRequest * _Nonnull request, NSInteger resultCode, NSString * _Nullable errorMsg);


#endif /* FPRequestBlockDefine_h */
