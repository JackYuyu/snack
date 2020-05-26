//
//  KWSDDSearchCell.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSDDSearchCell.h"

@implementation KWSDDSearchCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {

//    self.contentView.layer.borderWidth = 2;
//    self.contentView.layer.borderColor = DYStyleColor.CGColor;
    self.iconV = [UIImageView new];
    self.iconV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconV];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(5);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 120));
    }];
    
        self.iconV.layer.masksToBounds = YES;
        self.iconV.layer.cornerRadius =8;
    self.soldLab = [UILabel new];
    self.soldLab.font = DYFont(15);
    self.soldLab.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.soldLab];
    [self.soldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconV.mas_right).offset(5);
        make.bottom.mas_equalTo(self.iconV.mas_bottom).offset(-0);
        
    }];
    UIView *line = [UIView new];
    line.backgroundColor =[UIColor darkGrayColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.soldLab);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(self.soldLab);
        make.left.mas_equalTo(self.soldLab);
    }];
   
    UILabel *yuanLab = [UILabel new];
    yuanLab.text= @"¥";
    yuanLab.font = DYFont(19);
    yuanLab.textColor = [UIColor redColor];
    yuanLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:yuanLab];
    [yuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconV.mas_right).offset(5);
        make.bottom.mas_equalTo(self.bottom).offset(-30);
        
    }];
    
    self.priceLab = [UILabel new];
    self.priceLab.font = DYFont(20);
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yuanLab.mas_right).offset(5);
        make.bottom.mas_equalTo(self.bottom).offset(-30);
        
    }];
    
    self.nameLab = [UILabel new];
//    self.nameLab.font = DYFont(15);
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    self.nameLab.numberOfLines = 3;
    
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconV).offset(5);
        make.right.mas_equalTo(-5);
        make.left.mas_equalTo(self.iconV.mas_right).offset(5);
    }];
    
    UIImageView *cartIconV = [UIImageView new];
    cartIconV.image = [UIImage imageNamed:@"gouwuche"];
    [self.contentView addSubview:cartIconV];
    [cartIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.bottom.mas_equalTo(self.iconV.mas_bottom);
        make.right.mas_equalTo(-18);
    }];
    
    self.oneLab = [UILabel new];
    self.oneLab.textColor = [UIColor darkGrayColor];;
    self.oneLab.font = DYFont(15);
    [self.contentView addSubview:self.oneLab];
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.soldLab);
        make.left.mas_equalTo(self.soldLab.mas_right).offset(10);
    }];
    
    self.twoLab = [UILabel new];
    self.twoLab.text = @"  独特设计  ";
    self.twoLab.textColor = [UIColor whiteColor];
    self.twoLab.font = DYFont(15);
    [self.contentView addSubview:self.twoLab];
//    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self);
//        make.left.mas_equalTo(self.oneLab.mas_right).offset(10);
//        make.height.mas_equalTo(20);
//
//    }];
   self.twoLab.backgroundColor = DYStyleColor;

}
@end
