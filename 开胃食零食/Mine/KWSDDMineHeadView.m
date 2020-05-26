//
//  KWSDDMineHeadView.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSDDMineHeadView.h"

@implementation KWSDDMineHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self= [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
   
    UIImageView *bgV = [UIImageView new];
    [self.contentView addSubview:bgV];
    bgV.image = [UIImage imageNamed:@"mater"];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.right.mas_equalTo(self);
    }];
    self.iconV = [UIButton new];
    [self.iconV setBackgroundImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.iconV];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(80);
    }];
    self.iconV.layer.cornerRadius = 40;
    self.iconV.layer.masksToBounds = YES;
    self.nameLab = [UILabel new];
    self.nameLab.textColor= [UIColor blackColor];
    self.nameLab.text = @"Kai";
    //    self.nameLab.textColor = DYWhite;
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconV.mas_right).offset(10);
        make.centerY.mas_equalTo(self.iconV);
    }];
    
}


@end
