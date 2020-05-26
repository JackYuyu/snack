//
//  CALayer+XibLayerColor.h
//  WeiYuZhuanJia
//
//  Created by qq on 2019/9/3.
//  Copyright © 2019 weiyu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (XibLayerColor)
@property(nonatomic, assign) UIColor *borderUIColor;
@property(nonatomic, assign) UIColor *shadowUIColor;

@end

NS_ASSUME_NONNULL_END
