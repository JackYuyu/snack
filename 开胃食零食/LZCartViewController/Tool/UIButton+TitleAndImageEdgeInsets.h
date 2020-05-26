//
//  UIButton+TitleAndImageEdgeInsets.h
//  XinLe
//
//  Created by qq on 2019/5/28.
//  Copyright © 2019 liming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TitleAndImageEdgeInsets)

/**
 设置按钮图片在上，标题在下，和中间的间隔offset

 @param offset 图片和文字的之间的间隔
 */
- (void)titleLabBottomImageViewTopWith:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
