//
//  KWSGoodsInfoScrollHeadView.h
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KWSGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KWSGoodsInfoScrollHeadView : UITableViewHeaderFooterView
@property(nonatomic,strong) SDCycleScrollView *scrollView;
//
@property(nonatomic,strong) UILabel *priceLab;
//
@property(nonatomic,strong) UILabel *oldPrice;
//
@property(nonatomic,strong) UILabel *nameLab;
//
@property(nonatomic,strong) UILabel *countLab;
//
@property(nonatomic,strong) KWSGoodsModel *model;
@end

NS_ASSUME_NONNULL_END
