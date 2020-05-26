//
//  KWSDDCycleCell.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSDDCycleCell.h"

@implementation KWSDDCycleCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.cycleView1 = [[SDCycleScrollView alloc]initWithFrame:CGRectZero];
    self.cycleView1.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.cycleView1];
    [self.cycleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
    }];
}
@end
