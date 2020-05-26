//
//  KWSDDImageCell.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSDDImageCell.h"

@implementation KWSDDImageCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        
    }
    return self;
}

- (void)setUI {
//    self.backgroundColor = DYColor(247, 247, 247);
    self.iconV = [UIImageView new];
    [self.contentView addSubview:self.iconV];
    self.iconV.contentMode = UIViewContentModeScaleAspectFit;
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.iconV.mas_height);
        
    }];
    self.iconV.layer.masksToBounds=YES;
    self.iconV.layer.cornerRadius= 8;
    
    self.nameLab = [UILabel new];
    self.nameLab.textColor = DYColor(104, 156, 135);
    self.nameLab.font = [UIFont systemFontOfSize:20 weight:1];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self).offset(20);
//        make.right.mas_equalTo(self.mas_right).offset(-5);
    }];
    
    UILabel *oneLab = [UILabel new];
    oneLab.textAlignment = NSTextAlignmentCenter;
    oneLab.font = DYFont(17);
    [self.contentView addSubview:oneLab];
    [oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(5);
    }];
    
    self.iconV1 = [UIImageView new];
    [self.contentView addSubview:self.iconV1];
    [self.iconV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneLab.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
    self.iconV1.layer.masksToBounds=YES;
       self.iconV1.layer.cornerRadius= 8;
    UILabel *twoLab = [UILabel new];
    twoLab.textColor = [UIColor yellowColor];;
    twoLab.textAlignment = NSTextAlignmentCenter;
    twoLab.font = DYFont(14);
    twoLab.backgroundColor= [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.contentView addSubview:twoLab];
    [twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.iconV1);
    }];
    
    self.iconV2 = [UIImageView new];
    [self.contentView addSubview:self.iconV2];
    [self.iconV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneLab.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.right.mas_equalTo(self.iconV1.mas_left).offset(-10);
    }];
    self.iconV2.layer.masksToBounds=YES;
       self.iconV2.layer.cornerRadius= 8;
    UILabel *threeLab = [UILabel new];
    threeLab.textColor = [UIColor yellowColor];
    threeLab.textAlignment = NSTextAlignmentCenter;
    threeLab.font = DYFont(14);
    [self.contentView addSubview:threeLab];
    threeLab.backgroundColor= [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];

    [threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.left.right.mas_equalTo(self.iconV2);
    }];
//
//    UILabel *yuanLab = [UILabel new];
//    yuanLab.textColor = [UIColor redColor];
//    yuanLab.text = @"¥";
//    [self.contentView addSubview:yuanLab];
//    [yuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.iconV.mas_right).offset(20);
//        make.bottom.mas_equalTo(self).offset(-5);
//    }];
//    self.priceLab = [UILabel new];
//    self.priceLab.textColor = [UIColor redColor];
//    self.priceLab.font = DYFont(20);
//    [self.contentView addSubview:self.priceLab];
//    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(yuanLab.mas_right);
//        make.bottom.mas_equalTo(self).offset(-5);
//    }];
    
//    UIImageView *gouV = [UIImageView new];
//    gouV.image = [UIImage imageNamed:@"gouwuche"];
//    [self.contentView addSubview:gouV];
//    [gouV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(26, 26));
//        make.right.mas_equalTo(self.mas_right).offset(-10);
//        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
//    }];
    
    self.infoLab = oneLab;
    self.twoLab = twoLab;
    self.threeLab = threeLab;
}
@end
