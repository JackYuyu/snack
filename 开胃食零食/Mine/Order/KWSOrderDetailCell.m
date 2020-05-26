
//
//  KWSOrderDetailCell.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSOrderDetailCell.h"

@implementation KWSOrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor  = DYWhite;
        [self setUI];
    }
    return self;
}


- (void)setUI {
    
    self.iconV = [UIImageView new];
    [self.contentView addSubview:self.iconV];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(10);
    }];
    
    self.nameLab = [UILabel new];
    self.nameLab.numberOfLines = 2;
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconV.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.iconV);
    }];
    
    self.priceLab = [UILabel new];
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.font = DYFont(15);
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconV.mas_right).offset(10);
        make.bottom.mas_equalTo(self.iconV);
    }];
    
    UIButton *applyBtn = [UIButton new];
    [applyBtn setTitle:@"售后服务" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:applyBtn];
    [applyBtn addTarget:self action:@selector(applyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.iconV);
        make.width.mas_equalTo(100);
    }];
}

- (void)applyBtn:(UIButton *)btn {
    
    NSString *str=[NSString stringWithFormat:@"telprompt://%@",@"9510211"];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

   
    
}


@end
