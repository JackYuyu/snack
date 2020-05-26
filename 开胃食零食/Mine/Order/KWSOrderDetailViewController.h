//
//  KWSOrderDetailViewController.h
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KWSGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KWSOrderDetailViewController : UIViewController
@property (nonatomic,strong) KWSGoodsModel *model;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *createTime;
@end

NS_ASSUME_NONNULL_END
