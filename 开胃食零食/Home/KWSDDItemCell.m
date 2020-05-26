//
//  KWSDDItemCell.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSDDItemCell.h"

@implementation KWSDDItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    
    return self;
}


- (void)setUI {
    self.iconV = [UIImageView new];
    [self.contentView addSubview:self.iconV];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).offset(5);
        make.right.mas_equalTo(self).mas_offset(-5);
        make.height.mas_equalTo(self.iconV.mas_width);
    }];
    self.iconV.layer.masksToBounds = YES;
    self.iconV.layer.cornerRadius = 8;
    
    UIView *bgV = [UIView new];
//    bgV.backgroundColor = DYColor(121, 57, 13);
    [self.contentView addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.mas_equalTo(self);
        make.top.mas_equalTo(self.iconV.mas_bottom).offset(5);
    }];
    
    self.nameLab = [UILabel new];
    self.nameLab.numberOfLines = 3;
    self.nameLab.font = DYFont(16);
//    self.nameLab.textColor = DYWhite;
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconV.mas_bottom).offset(8);
        make.left.mas_equalTo(self).offset(5);
        make.right.mas_equalTo(self).offset(-5);
        
    }];
    UILabel *yuanLab = [UILabel new];
    yuanLab.textColor = [UIColor redColor];
    yuanLab.text = @"¥";
    [self.contentView addSubview:yuanLab];
    [yuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
    
    self.merPriceLab = [UILabel new];
    self.merPriceLab.font = DYFont(18);
    ;    self.merPriceLab.textColor = [UIColor redColor];
    [self.contentView addSubview:self.merPriceLab];
    [self.merPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yuanLab.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
    
//    self.soldLab = [UILabel new];
//    self.soldLab.font = DYFont(15);
//    self.soldLab.textColor = [UIColor redColor];;
//    self.soldLab.backgroundColor = DYWhite;
//    self.soldLab.textAlignment = NSTextAlignmentCenter;
//    self.soldLab.text = @"立即抢购";
//    [self.contentView addSubview:self.soldLab];
//    [self.soldLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.mas_right).offset(-10);
//        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(25);
//    }];
//    self.soldLab.layer.masksToBounds = YES;
//    self.soldLab.layer.cornerRadius = 8;
//    self.soldLab.layer.borderWidth= 0.5;
//    self.soldLab.layer.borderColor = [UIColor redColor].CGColor;
    
    UIImageView *gouwV = [UIImageView new];
    gouwV.image = [UIImage imageNamed:@"gouwuche"];
    [self.contentView addSubview:gouwV];
    [gouwV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.bottom.mas_equalTo(self.merPriceLab.mas_bottom);
        make.right.mas_equalTo(self.iconV);
    }];
}
@end
