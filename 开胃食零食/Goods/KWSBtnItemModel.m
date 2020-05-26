//
//  KWSBtnItemModel.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSBtnItemModel.h"

@implementation KWSBtnItemModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goods":@"KWSGoodsModel"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}
@end
