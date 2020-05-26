//
//  NetHttpTool.h
//  CiQi
//
//  Created by qq on 2019/6/14.
//  Copyright © 2019 qi. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ShopCircle @"/api/pub/shopCircle/search"
#define CategoaryInfo @"/api/pub/type/detail"
#define CategoaryList @"/api/pub/type/search"
#define UserAdd @"/api/pub/member/add"
#define UserLogin @"/api/pub/member/login"
#define AddCart @"/api/pub/cart/add"
#define CartList @"/api/pub/cart/search"
#define AddAddress @"/api/pub/address/add"
#define AddressList @"/api/pub/address/search"
#define EditAddress @"/api/pub/address/update"
#define BaseURL @"http://shop.v1.guolegebao.cn/lingshi"

NS_ASSUME_NONNULL_BEGIN
typedef __strong void(^Succeed)(NSDictionary *returnData);
typedef void(^Failure)(NSError *error);
@interface NetHttpTool : NSObject
+ (void)Post:(NSString *)url paramets:(NSDictionary *)paramts Succeed:(Succeed )succeed Failure:(Failure)failure;
+ (void)Post:(NSString *)url bodyParamets:(NSDictionary *)paramts Succeed:(Succeed )succeed Failure:(Failure)failure;
+ (void)GET:(NSString *)url paramets:(NSDictionary *)paramets Succeed:(Succeed)succeed Failure:(Failure)failure;
+ (void)GET:(NSString *)url parametsBody:(NSDictionary *)paramets Succeed:(Succeed)succeed Failure:(Failure)failure;
@end

NS_ASSUME_NONNULL_END
