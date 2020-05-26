//
//  KWSGoodsInfoImageCell.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSGoodsInfoImageCell.h"

@implementation KWSGoodsInfoImageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setUI {
    self.iconV = [UIImageView new];
    [self.contentView addSubview:self.iconV];
    self.iconV.contentMode = UIViewContentModeScaleAspectFill;
    self.iconV.clipsToBounds = YES;
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(2);
        make.right.bottom.mas_equalTo(-2);
    }];
    
}


@end
