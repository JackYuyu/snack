//
//  KWSSettingViewController.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSSettingViewController.h"
#import "KWSSettingCell.h"
#import "KWSResetAccountViewController.h"
#import "KWSClearCacheViewController.h"
@interface KWSSettingViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation KWSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.titleLabel.text = @"设置";
    self.navigationView.lineView.hidden = YES;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerClass:[KWSSettingCell class] forCellReuseIdentifier:@"KWSSettingCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(0);
    }];
    self.tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0);
    self.dataArr = @[@"帐户和安全",@"内存管理",@"退出"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KWSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KWSSettingCell"];
    cell.nameLab.text = self.dataArr[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 1)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 0.1;
    }
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 10)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            KWSResetAccountViewController *vc = [KWSResetAccountViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            KWSClearCacheViewController *vc = [KWSClearCacheViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            [self quit];
        }
            break;
            
        default:
            break;
    }
}
- (void)quit {
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"id"];
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
