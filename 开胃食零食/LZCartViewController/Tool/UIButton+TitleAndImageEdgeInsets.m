//
//  UIButton+TitleAndImageEdgeInsets.m
//  XinLe
//
//  Created by qq on 2019/5/28.
//  Copyright © 2019 liming. All rights reserved.
//

#import "UIButton+TitleAndImageEdgeInsets.h"

@implementation UIButton (TitleAndImageEdgeInsets)
- (void)titleLabBottomImageViewTopWith:(CGFloat)offset {
    CGSize imageViewSize = self.imageView.frame.size;
    //ios 8 使用 intrinsicContentSize 获取titleLabelSize;
    CGSize titleLabelSize = self.titleLabel.intrinsicContentSize;
    //ios 9 后使用 titleLabel.frame.size;
    if (@available(iOS 9.0,*)) {
        titleLabelSize = self.titleLabel.frame.size;
    }
    
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
//    当文字实际宽度比标题大时
    if (titleLabelSize.width + 0.5 < frameSize.width) {
        titleLabelSize.width = frameSize.width;
    }
//        当offset大于（button的高度减去标题和图片的高度）时，文字和图片会超出button的范围。当button没有设置宽高，是不能设置offset，否则会抛异常;
   
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageViewSize.width, -imageViewSize.height-offset, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(-titleLabelSize.height-offset, 0, 0, -titleLabelSize.width);
}
@end
