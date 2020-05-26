//
//  KWSGoodsInfoScrollHeadView.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSGoodsInfoScrollHeadView.h"

@implementation KWSGoodsInfoScrollHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    
    self.contentView.backgroundColor = DYWhite;
    
    self.scrollView = [[SDCycleScrollView alloc]init];
    self.scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(250);
    }];
    
    self.nameLab = [UILabel new];
    //    self.nameLab.textColor = DYWhite;
    self.nameLab.font = DYFont(17);
    self.nameLab.numberOfLines =2;
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.scrollView.mas_bottom).offset(15);
    }];
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 60)];
    bgview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SW, 60));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-50);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    bgview.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    bgview.layer.shadowOffset = CGSizeMake(SW, 10);
    bgview.layer.shadowOpacity = 0.7;
    bgview.layer.shadowRadius = 15;
    
    
    self.priceLab =  [UILabel new];
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.font = [UIFont systemFontOfSize:18 weight:1];
    [bgview addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgview.mas_left).offset(20);
        make.top.mas_equalTo(bgview.mas_top).offset(10);
    }];
    self.oldPrice =  [UILabel new];
    self.oldPrice.font = DYFont(15);
    self.oldPrice.textColor = [UIColor darkGrayColor];
    [bgview addSubview:self.oldPrice];
    [self.oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLab);
        make.top.mas_equalTo(self.priceLab.mas_bottom);
    }];
    UILabel *lab = [UILabel new];
    lab.text = @"货到付款";
    lab.textColor = [UIColor darkGrayColor];
    lab.font =DYFont(15);
    [bgview addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLab.mas_right).offset(10);
        make.centerY.mas_equalTo(self.priceLab);
        
    }];
    self.countLab =  [UILabel new];
    self.countLab.textColor = [UIColor darkGrayColor];;
    self.countLab.font = DYFont(16);
    [bgview addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgview.mas_right).offset(-20);
        make.centerY.mas_equalTo(bgview.mas_centerY);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(-40);
    }];
    
    
    
}

- (void)setModel:(KWSGoodsModel *)model {
    _model = model;
    
    NSString *pic1 = [NSString stringWithFormat:@"%@%@",@"",model.pic1];
    NSString *pic2 = [NSString stringWithFormat:@"%@%@",@"",model.pic2];
    NSString *pic3 = [NSString stringWithFormat:@"%@%@",@"",model.pic3];
    NSString *pic4 = [NSString stringWithFormat:@"%@%@",@"",model.pic4];
    NSString *paramPic = [NSString stringWithFormat:@"%@%@",@"",model.smallPic];
    NSMutableArray *imgsArr = [NSMutableArray array];
    
    for (int i=0; i<model.imgs.count; i++) {
        NSDictionary* t=[model.imgs objectAtIndex:i];
        [imgsArr addObject:[t objectForKey:@"url"]];
    }
    
//    if (paramPic.length > (@"".length + 6)) {
//        [imgsArr addObject:paramPic];
//        
//    }
//    if (pic1.length > (@"".length + 6)) {
//        [imgsArr addObject:pic1];
//        
//    }
//    if (pic2.length > (@"".length + 6)) {
//        [imgsArr addObject:pic2];
//        
//    }
//    if (pic3.length > (@"".length + 6)) {
//        [imgsArr addObject:pic3];
//        
//    }
//    if (pic4.length > (@"".length + 6)) {
//        [imgsArr addObject:pic4];
//        
//    }
    
    
    self.scrollView.imageURLStringsGroup = imgsArr;
    
    self.nameLab.text = model.name;
    self.priceLab.text = [NSString stringWithFormat:@"心动价:¥%.f",model.memberPrice.doubleValue];
    self.oldPrice.text = [NSString stringWithFormat:@"会员价: %.f",model.originalPrice.doubleValue];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.oldPrice.text attributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
    self.oldPrice.attributedText =str;
    self.countLab.text = [NSString stringWithFormat:@"库存: %.f",model.inventory.doubleValue];
}

@end
