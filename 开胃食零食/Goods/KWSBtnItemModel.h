//
//  KWSBtnItemModel.h
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWSBtnItemModel : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *goodsIds;
@property(nonatomic,copy) NSString *icon;
@property(nonatomic,copy) NSArray *goods;
@end

NS_ASSUME_NONNULL_END
