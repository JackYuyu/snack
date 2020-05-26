//
//  KWSGoodsDetailViewController.h
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KWSGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KWSGoodsDetailViewController : UIViewController
@property(nonatomic,strong) KWSGoodsModel *model;
@property (nonatomic, strong) NSArray *dataArr;
@end

NS_ASSUME_NONNULL_END
