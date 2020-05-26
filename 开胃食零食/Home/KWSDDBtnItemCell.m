//
//  KWSDDBtnItemCell.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSDDBtnItemCell.h"

@implementation KWSDDBtnItemCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    CGFloat width = self.frame.size.width;
    self.iconV = [UIImageView new];
    self.iconV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconV];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(width-20);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(15);
    }];
    self.iconV.layer.masksToBounds = YES;
    self.iconV.layer.cornerRadius = 10;
    
    self.nameLab = [UILabel new];
    self.nameLab.font = DYFont(15);
    self.nameLab.numberOfLines = 2;
    self.nameLab.textColor = [UIColor darkGrayColor];
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.iconV.mas_bottom).offset(3);
        make.left.mas_equalTo(self).offset(3);
        make.right.mas_equalTo(self).offset(-3);
        make.bottom.mas_equalTo(self).offset(-3);
    }];
    
    
}
@end
