//
//  KWSGoodsModel.h
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWSGoodsModel : NSObject
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *name;//商品名称
@property(nonatomic,copy) NSString *originalPrice;//原价 ,
@property(nonatomic,copy) NSString *memberPrice;//会员价
@property(nonatomic,copy) NSString *salesVolume;
@property(nonatomic,copy) NSString *inventory;//库存
@property(nonatomic,copy) NSString *pic1;//详情图1
@property(nonatomic,copy) NSString *pic2;//详情图2
@property(nonatomic,copy) NSString *pic3;//详情图3
@property(nonatomic,copy) NSString *pic4;//详情图4
@property(nonatomic,copy) NSString *spec;//规格 ,
@property(nonatomic,copy) NSString *specValue;//规格值 ,
@property(nonatomic,copy) NSString *smallPic;//缩略图 ,
@property(nonatomic,copy) NSString *paramPic;// 参数明细
@property(nonatomic,copy) NSString *goodsCircles;//商品轮播图表
@property(nonatomic,copy) NSString *salePic;//售后服务
@property(nonatomic,copy) NSArray* imgs;//轮播图
@property(nonatomic,copy) NSArray* pics;//详情图

@end

NS_ASSUME_NONNULL_END
