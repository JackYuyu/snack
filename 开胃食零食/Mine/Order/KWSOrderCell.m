//
//  KWSOrderCell.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSOrderCell.h"

@implementation KWSOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor =[UIColor groupTableViewBackgroundColor];
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = DYWhite;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
    }];
    
    
    UILabel *titleLab =[UILabel new];
    titleLab.text = @"旗舰店";
    titleLab.font = [UIFont systemFontOfSize:18 weight:1];
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).offset(15);
        make.top.mas_equalTo(bgView.mas_top).offset(10);
        
    }];
    
    UILabel *chukuLab =[UILabel new];
    chukuLab.text = @"正在出库";
    chukuLab.textColor = [UIColor redColor];
    [bgView addSubview:chukuLab];
    [chukuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgView.mas_right).offset(-15);
        make.top.mas_equalTo(bgView.mas_top).offset(10);
        
    }];
    
    UILabel *tipLab = [UILabel new];
    tipLab.text = @"温馨提示：您的订单预计三个工作日送达";
    tipLab.font = [UIFont systemFontOfSize:16 weight:1];
    [bgView addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgView.mas_right).offset(-15);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(20);
        make.left.mas_equalTo(bgView.mas_left).offset(15);
    }];
    
    self.iconV = [UIImageView new];
    [bgView addSubview:self.iconV];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).offset(15);
        make.bottom.mas_equalTo(bgView.mas_bottom).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    self.nameLab = [UILabel new];
    self.nameLab.numberOfLines =2;
    [bgView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgView.mas_right).offset(-15);
        make.top.mas_equalTo(self.iconV);
        make.left.mas_equalTo(self.iconV.mas_right).offset(10);
    }];
    
    self.priceLab = [UILabel new];
    self.priceLab.textColor = [UIColor redColor];
    [bgView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.iconV);
        make.left.mas_equalTo(self.iconV.mas_right).offset(10);
    }];
    
}

@end
