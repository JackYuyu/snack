
//
//  KWSOrderDetailSendInfoCell.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSOrderDetailSendInfoCell.h"

@implementation KWSOrderDetailSendInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = DYWhite;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 10)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    UILabel *orderTimeLab = [UILabel new];
    orderTimeLab.text = @"下单时间:";
    [self.contentView addSubview:orderTimeLab];
    orderTimeLab.font =DYFont(15);
    orderTimeLab.textColor = [UIColor darkGrayColor];
    [orderTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.top.mas_equalTo(line.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
    }];
    
    self.timeLab = [UILabel new];
    [self.contentView addSubview:self.timeLab];
    self.timeLab.font =DYFont(15);
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderTimeLab.mas_right).offset(10);
        make.centerY.mas_equalTo(orderTimeLab.mas_centerY);
    }];
    
    
    UILabel *payLab = [UILabel new];
    [self.contentView addSubview:payLab];
    payLab.text = @"付款方式:";
    payLab.font =DYFont(15);
    payLab.textColor = [UIColor darkGrayColor];
    [payLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(orderTimeLab.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
    }];
    
    UILabel *huodaoLab = [UILabel new];
    huodaoLab.text = @"货到付款";
    [self.contentView addSubview:huodaoLab];
    huodaoLab.font = DYFont(15);
    [huodaoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderTimeLab.mas_right).offset(10);
        make.centerY.mas_equalTo(payLab.mas_centerY);
    }];
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SW, 1));
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(payLab.mas_bottom).offset(20);
    }];
    
    UILabel *shouhuoLab = [UILabel new];
    [self.contentView addSubview:shouhuoLab];
    shouhuoLab.text = @"收货地址:";
    shouhuoLab.font =DYFont(15);
    shouhuoLab.textColor = [UIColor darkGrayColor];
    [shouhuoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(line1.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
    }];
    
    self.nameLab = [UILabel new];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(shouhuoLab.mas_bottom).offset(20);
    }];
    self.phoneLab = [UILabel new];
    [self.contentView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(20);
    }];
    self.addressLab = [UILabel new];
    self.addressLab.numberOfLines = 0;
    [self.contentView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.phoneLab.mas_bottom).offset(20);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(40);
    }];
    
}

@end
