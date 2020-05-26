
//
//  KWSSettingCell.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSSettingCell.h"

@implementation KWSSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = DYWhite;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.nameLab = [UILabel new];
    self.nameLab.font = DYFont(16);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(20);
    }];
    UIView *line = [UIView new];
    [self.contentView addSubview:line];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self).offset(20);
    }];
    
    UIImageView * iconV = [UIImageView new];
    iconV.image = [UIImage imageNamed:@"y"];
    [self.contentView addSubview:iconV];
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.mas_equalTo(self).offset(20);
    }];
}

@end
