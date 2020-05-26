//
//  KWSAddCartView.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSAddCartView.h"

@implementation KWSAddCartView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}


- (void)setUI {
    self.iconV = [UIImageView new];
    [self addSubview:self.iconV];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.top.left.mas_equalTo(30);
    }];
    
    self.closeBtn = [UIButton new];
    [self.closeBtn setTitle:@"X" forState:UIControlStateNormal];
    [self.closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.closeBtn.backgroundColor = [UIColor lightTextColor];
    self.closeBtn.titleLabel.font = DYFont(15);
    [self addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    self.priceLab = [UILabel new];
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.font = DYFont(16);
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconV.mas_right).offset(10);
        make.centerY.mas_equalTo(self.iconV);
    }];
    
    self.countLab = [UILabel new];
    self.countLab.font = DYFont(16);
    [self addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconV.mas_right).offset(10);
        make.top.mas_equalTo(self.priceLab.mas_bottom).offset(10);
    }];
    
    self.nameLab =[UILabel new];
    self.nameLab.font = DYFont(18);
    self.nameLab.numberOfLines = 3;
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconV.mas_left).offset(5);
        make.top.mas_equalTo(self.iconV.mas_bottom).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-30);
    }];
    
    UILabel *countLab = [UILabel new];
    countLab.text = @"库存:";
    [self addSubview: countLab];
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(15);
    }];
    
    self.stepper = [[UIStepper alloc]init];
    self.stepper.stepValue = 1;
    self.stepper.minimumValue = 1;
    self.stepper.maximumValue = 100;
    [self addSubview:self.stepper];
    [self.stepper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(countLab.mas_centerY);
    }];
    [self.stepper addTarget:self action:@selector(updateNumLab:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%.f",self.stepper.value);
    self.numLab = [UILabel new];
//    self.numLab.text = [NSString stringWithFormat:@"%.f",self.stepper.value];
    [self addSubview: self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.stepper.mas_left).offset(-30);
        make.centerY.mas_equalTo(countLab.mas_centerY);
    }];
    
    UILabel *tipLab = [UILabel new];
    tipLab.numberOfLines = 0;
    tipLab.textColor = [UIColor lightGrayColor];
    tipLab.font = DYFont(15);
    tipLab.text = @"当前商品只支持货到付款，暂不支持其它付款方式";
    [self addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(countLab.mas_bottom).offset(10);
        make.right.mas_equalTo(-30);
    }];
    
    self.okBtn = [UIButton new];
    [self.okBtn setTitle:@"OK" forState:UIControlStateNormal];
    [self.okBtn setTitleColor:DYWhite forState:UIControlStateNormal];
    self.okBtn.backgroundColor = [UIColor redColor];
    [self addSubview:self.okBtn];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(40);
    }];
}

- (void)updateNumLab:(UIStepper *)stepper {
    self.numLab.text = [NSString stringWithFormat:@"%.f",stepper.value];
}
@end
