
//
//  KWSClearCacheViewController.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSClearCacheViewController.h"

@interface KWSClearCacheViewController ()
@property (nonatomic, strong) UILabel *countLab;

@end

@implementation KWSClearCacheViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.countLab.text = [ClearCacheTool getCacheSizeWithFilePath:@""];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.titleLabel.text = @"清除缓存";
    self.view.backgroundColor = DYWhite;
    
    UILabel *infoLab = [UILabel new];
    infoLab.textColor = [UIColor darkGrayColor];
    infoLab.font = DYFont(14);
    infoLab.text = @"已用空间";
    [self.view addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
    self.countLab = [UILabel new];
    self.countLab.textColor = [UIColor darkTextColor];
    self.countLab.font = [UIFont systemFontOfSize:20 weight:1];
    self.countLab.text = @"0.0";
    [self.view addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(infoLab.mas_bottom).offset(30);
    }];
    
    
    UIButton *clearBtn = [UIButton new];
    [clearBtn setTitle:@"清除缓存" forState:UIControlStateNormal];
    [clearBtn setTitleColor:DYWhite forState:UIControlStateNormal];

    clearBtn.backgroundColor = [UIColor greenColor];
    [clearBtn addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.countLab.mas_bottom).offset(60);
    }];
    clearBtn.layer.masksToBounds = YES;
    clearBtn.layer.cornerRadius = 8;
}


- (void)clearAction{
    
    [ClearCacheTool clearCacheWithFilePath:@""];
    self.countLab.text = [ClearCacheTool getCacheSizeWithFilePath:@""];

}

@end
