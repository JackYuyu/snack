//
//  KWSOrderDetailViewController.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSOrderDetailViewController.h"

#import "KWSOrderHeadView.h"
#import "KWSOrderDetailCell.h"
#import "KWSOrderDetailSendInfoCell.h"

#import "KWSGoodsDetailViewController.h"
@interface KWSOrderDetailViewController ()

<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end
@implementation KWSOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.titleLabel.text = @"订单详情";
    self.navigationView.lineView.hidden = YES;
    [self setTableView];
}

- (void)setTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
    }];
    [self.tableView registerClass:[KWSOrderHeadView class] forHeaderFooterViewReuseIdentifier:@"KWSOrderHeadView"];
    [self.tableView registerClass:[KWSOrderDetailCell class] forCellReuseIdentifier:@"KWSOrderDetailCell"];
    [self.tableView registerClass:[KWSOrderDetailSendInfoCell class] forCellReuseIdentifier:@"KWSOrderDetailSendInfoCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 120;
    }
    return 400;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        KWSOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KWSOrderDetailCell"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.smallPic]];
        [cell.iconV sd_setImageWithURL:url];
        cell.nameLab.text = self.model.name;
        cell.priceLab.text = [NSString stringWithFormat:@"%.2f", self.model.memberPrice.doubleValue ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        KWSOrderDetailSendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KWSOrderDetailSendInfoCell"];
        NSString *address = [Userdefaults valueForKey:@"address"];
        cell.addressLab.text = [NSString stringWithFormat:@"地址: %@",address];
        NSString *phone = [Userdefaults valueForKey:@"phone"];
        cell.phoneLab.text = [NSString stringWithFormat:@"%@",phone];
        NSString *name = [Userdefaults valueForKey:@"name"];
        cell.nameLab.text = [NSString stringWithFormat:@"%@",name];
//        cell.priceLab.text = [NSString stringWithFormat:@"%@%.2f",NSLocalizedString(@"RMB", nil),self.model.memberPrice.doubleValue *([NSLocalizedString(@"rate", nil) doubleValue])];
//        cell.countLab.text = [NSString stringWithFormat:@"%@ %.2f",NSLocalizedString(@"RMB", nil),self.model.memberPrice.doubleValue * self.count.integerValue * ([NSLocalizedString(@"rate", nil) doubleValue])];
        cell.timeLab.text = self.createTime;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KWSOrderHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"KWSOrderHeadView"];
    [view.btn addTarget:self action:@selector(agion:) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 1)];
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        KWSGoodsDetailViewController *vc= [KWSGoodsDetailViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.model =self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)agion:(UIButton *)btn {
    KWSGoodsDetailViewController *vc= [KWSGoodsDetailViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model =self.model;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
