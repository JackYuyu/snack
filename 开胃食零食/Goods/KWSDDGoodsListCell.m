//
//  KWSDDGoodsListCell.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSDDGoodsListCell.h"

@implementation KWSDDGoodsListCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius =8;
    self.contentView.layer.borderColor = DYStyleColor.CGColor;
    self.contentView.layer.borderWidth = 2;
    self.iconV = [UIImageView new];
    [self.contentView addSubview:self.iconV];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.width.mas_equalTo(self.iconV.mas_height);
    }];
        self.iconV.layer.masksToBounds = YES;
        self.iconV.layer.cornerRadius =8;
    
    
    self.nameLab = [UILabel new];
    self.nameLab.numberOfLines = 3;
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.top.mas_equalTo(self.iconV.mas_bottom).offset(8);
        make.right.mas_equalTo(self.mas_right).offset(-5);
    }];
    
    
    
    UIView *bgV = [UIView new];
    bgV.backgroundColor = DYStyleColor;
    
    [self.contentView addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-5);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(26);
    }];
    bgV.layer.masksToBounds = YES;
    bgV.layer.cornerRadius = 10;
    self.priceLab = [UILabel new];
    self.priceLab.textAlignment = NSTextAlignmentCenter;
    self.priceLab.textColor= [UIColor whiteColor];
    self.priceLab.font = [UIFont systemFontOfSize:18 weight:1];
    [bgV addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(bgV);
        make.width.mas_equalTo((self.frame.size.width-40)/2);
        
    }];
    self.sendStyleLab = [UILabel new];
    self.sendStyleLab.text = @" 立即抢购 ";
    self.sendStyleLab.textColor = [UIColor whiteColor];
    self.sendStyleLab.font =DYFont(15);
    
    self.sendStyleLab.textAlignment = NSTextAlignmentCenter;
    self.sendStyleLab.backgroundColor = DYColor(251, 144, 37);
    [bgV addSubview:self.sendStyleLab];
    [self.sendStyleLab mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.top.bottom.mas_equalTo(bgV);
        make.width.mas_equalTo(self.priceLab.mas_width);
    }];
//    self.sendStyleLab.layer.masksToBounds = YES;
//    self.sendStyleLab.layer.cornerRadius= 8;
//    self.goodLab = [UILabel new];
//    self.goodLab.textColor = [UIColor lightGrayColor];
//    self.goodLab.font =DYFont(14);
//    [self.contentView addSubview:self.goodLab];
//    [self.goodLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.sendStyleLab.mas_right).offset(10);
//        make.bottom.mas_equalTo(self.iconV.mas_bottom);
//    }];
    
//    self.cartIconV = [UIImageView new];
//    self.cartIconV.image = [UIImage imageNamed:@"gouwuche"];
//    [self.contentView addSubview:self.cartIconV];
//    [self.cartIconV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(25, 25));
//        make.bottom.mas_equalTo(self.iconV.mas_bottom);
//        make.right.mas_equalTo(-18);
//    }];
}

@end
