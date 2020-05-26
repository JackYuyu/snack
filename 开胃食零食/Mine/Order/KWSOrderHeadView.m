//
//  KWSOrderHeadView.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSOrderHeadView.h"

@implementation KWSOrderHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setUI];
        
    }
    return self;
}


- (void)setUI {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 200)];
    
    bgView.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:bgView];
    
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"再次购买" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(100, 38));
    }];
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius =19;
    self.btn = btn;
    
}


@end
