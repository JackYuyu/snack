//
//  KWSOrderViewController.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSOrderViewController.h"
#import "KWSGoodsModel.h"
#import "LZCartModel.h"
#import "KWSOrderDetailViewController.h"

#import "KWSOrderCell.h"
@interface KWSOrderViewController ()
<UITableViewDelegate,UITableViewDataSource>
//
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation KWSOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.titleLabel.text = @"未完成订单";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
    }];
    
    
    [self.tableView registerClass:[KWSOrderCell class] forCellReuseIdentifier:@"KWSOrderCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.index == 0) {
        NSString *address = [Userdefaults valueForKey:@"address"];
        if (address.length >0 ) {
            
            [self Http];
        }else {
            [MBProgressHUD showMessage:@"暂无数据"];
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KWSOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KWSOrderCell"];
    LZCartModel *model = self.dataArr[indexPath.row];
    KWSGoodsModel *goods = model.goods;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",goods.smallPic]];
    [cell.iconV sd_setImageWithURL:url];
    cell.nameLab.text = goods.name;
    cell.priceLab.text = [NSString stringWithFormat:@"¥ %.2f",goods.memberPrice.doubleValue];
    cell.addressLab.text = model.createTime;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 230;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 0)];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KWSOrderDetailViewController *vc = [KWSOrderDetailViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    LZCartModel *model = self.dataArr[indexPath.row];
    KWSGoodsModel *goods = model.goods;
    vc.model = goods;
    vc.count = [NSString stringWithFormat:@"%ld",model.count];
    vc.createTime = model.createTime;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)Http {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSNumber *ID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    [dic setValue:ID forKey:@"memberId"];
    [dic setValue:@"true" forKey:@"noPage"];
    [dic setValue:@"0" forKey:@"page"];
    [dic setValue:@"10" forKey:@"pageSize"];
    [dic setValue:ShopKey forKey:@"shopKey"];
    
    [NetHttpTool Post:CartList paramets:dic Succeed:^(NSDictionary * _Nonnull returnData) {
        NSDictionary *data = returnData[@"data"];
        NSArray *carts = data[@"carts"];
        self.dataArr = [LZCartModel mj_objectArrayWithKeyValuesArray:carts];
        [self.tableView reloadData];
    } Failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
    
}

@end
