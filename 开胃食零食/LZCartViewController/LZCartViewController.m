//
//  LZCartViewController.m
//  LZCartViewController
//
//  Created by LQQ on 16/5/18.
//  Copyright © 2016年 LQQ. All rights reserved.
//  https://github.com/LQQZYY/CartDemo
//  http://blog.csdn.net/lqq200912408
//  QQ交流: 302934443

#import "LZCartViewController.h"
#import "LZConfigFile.h"
#import "LZCartTableViewCell.h"
#import "LZCartModel.h"
#import "KWSAddressViewController.h"
#import "KWSOrderViewController.h"

@interface LZCartViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isHiddenNavigationBarWhenDisappear;//记录当页面消失时是否需要隐藏系统导航
    BOOL _isHasTabBarController;//是否含有tabbar
    BOOL _isHasNavitationController;//是否含有导航
}

@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableArray *selectedArray;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)UIButton *allSellectedButton;
@property (strong,nonatomic)UILabel *totlePriceLabel;
//
@property(nonatomic,strong) NSMutableArray *objsArr;


@end

@implementation LZCartViewController

#pragma mark - viewController life cicle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSNumber *ID = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    if (ID.integerValue <=0) {
        
        RegistLoginViewController *vc = [RegistLoginViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    self.tabBarController.tabBar.hidden = NO;
    [self creatData];
    //当进入购物车的时候判断是否有已选择的商品,有就清空
    //主要是Submit Order后再返回到购物车,如果不清空,还会显示
    if (self.selectedArray.count > 0) {
        for (LZCartModel *model in self.selectedArray) {
            model.select = NO;
        }
        [self.selectedArray removeAllObjects];
    }
    
    //初始化显示状态
    _allSellectedButton.selected = NO;
    _totlePriceLabel.attributedText = [self LZSetString:@"￥0.00"];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (_isHiddenNavigationBarWhenDisappear == YES) {
        self.navigationController.navigationBarHidden = NO;
    }
}


-(void)creatData {
   

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSNumber *ID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    if (ID.integerValue <= 0 ) {
        return;
    }
    [dic setValue:ID forKey:@"memberId"];
    
    [dic setValue:@"true" forKey:@"noPage"];
    [dic setValue:@"0" forKey:@"page"];
    [dic setValue:@"10" forKey:@"pageSize"];
    [dic setValue:ShopKey forKey:@"shopKey"];

    [NetHttpTool Post:CartList paramets:dic Succeed:^(NSDictionary * _Nonnull returnData) {
        NSDictionary *data = returnData[@"data"];
        NSArray *carts = data[@"carts"];
        self.dataArray = [LZCartModel mj_objectArrayWithKeyValuesArray:carts];
        if (self.dataArray.count >0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setupCartView];
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setupCartEmptyView];
            });
            
        }
    } Failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"No product data yet"];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray  array];
    self.selectedArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    _isHasTabBarController = YES;

    [self changeView];

}


/**
 *
 *  计算已选中商品金额
 */
-(void)countPrice {
    double totlePrice = 0.0;
    
    for (LZCartModel *model in self.selectedArray) {
        
        double price = [model.price doubleValue];
        
        totlePrice += price*model.count;
    }
NSString *string = [NSString stringWithFormat:@" %.2f",totlePrice ];    self.totlePriceLabel.attributedText = [self LZSetString:string];
}




#pragma mark -- 自定义底部视图 
- (void)setupCustomBottomView {
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = LZColorFromRGB(245, 245, 245);
    backgroundView.tag = TAG_CartEmptyView + 1;
    
    for (UIView *view in self.view.subviews) {
        if (view.tag == TAG_CartEmptyView+1) {
            [view removeFromSuperview];
        }
    }
    [self.view addSubview:backgroundView];

    backgroundView.frame = CGRectMake(0, LZSCREEN_HEIGHT -  TABBARHEIGHT-LZTabBarHeight, LZSCREEN_WIDTH, LZTabBarHeight);

    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, 0, LZSCREEN_WIDTH, 1);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [backgroundView addSubview:lineView];
    
    //全选按钮
    UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:16];
    selectAll.frame = CGRectMake(10, 5, 80, LZTabBarHeight - 10);
    [selectAll setTitle:@"总计:" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:lz_Bottom_UnSelectButtonString] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:lz_Bottom_SelectButtonString] forState:UIControlStateSelected];
    [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:selectAll];
    self.allSellectedButton = selectAll;
    
    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = BASECOLOR_RED;
    btn.frame = CGRectMake(LZSCREEN_WIDTH - 100, 0, 100, LZTabBarHeight);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];
    
    //合计
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor redColor];
    [backgroundView addSubview:label];
    
    label.attributedText = [self LZSetString:@"$0.00"];
    CGFloat maxWidth = LZSCREEN_WIDTH - selectAll.bounds.size.width - btn.bounds.size.width - 30;
//    CGSize size = [label sizeThatFits:CGSizeMake(maxWidth, LZTabBarHeight)];
    label.frame = CGRectMake(selectAll.bounds.size.width + 20, 0, maxWidth - 10, LZTabBarHeight);
    self.totlePriceLabel = label;
}

- (NSMutableAttributedString*)LZSetString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"Count:%@",string];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"Count:"];
    [LZString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return LZString;
}
#pragma mark -- 购物车为空时的默认视图
- (void)changeView {
    
    if (self.dataArray.count > 0) {
        UIView *view = [self.view viewWithTag:TAG_CartEmptyView];
        if (view != nil) {
            [view removeFromSuperview];
        }
        
        [self setupCartView];
    } else {
        
        UIView *bottomView = [self.view viewWithTag:TAG_CartEmptyView + 1];
        [bottomView removeFromSuperview];
        
        [self.myTableView removeFromSuperview];
        self.myTableView = nil;
        [self setupCartEmptyView];
    }
}

- (void)setupCartEmptyView {
    //默认视图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.frame.size.height, LZSCREEN_WIDTH, LZSCREEN_HEIGHT - LZNaigationBarHeight)];
    backgroundView.tag = TAG_CartEmptyView;
    for (UIView *view in self.view.subviews) {
        if (view.tag == TAG_CartEmptyView) {
            [view removeFromSuperview];
        }
    }
    [self.view addSubview:backgroundView];
    backgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:lz_CartEmptyString]];
    img.center = CGPointMake(LZSCREEN_WIDTH/2.0, LZSCREEN_HEIGHT/2.0 - 120);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];
    
    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(LZSCREEN_WIDTH/2.0, LZSCREEN_HEIGHT/2.0 - 10);
    warnLabel.bounds = CGRectMake(0, 0, LZSCREEN_WIDTH, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"空购物车!";
    warnLabel.font = [UIFont systemFontOfSize:15];
    warnLabel.textColor = LZColorFromHex(0x706F6F);
    [backgroundView addSubview:warnLabel];
}
#pragma mark -- 购物车有商品时的视图
- (void)setupCartView {
    //创建底部视图
    if ([self.view.subviews containsObject:self.myTableView]) {
        [self.myTableView removeFromSuperview];
    }
    [self setupCustomBottomView];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    table.delegate = self;
    table.dataSource = self;
    
    table.rowHeight = lz_CartRowHeight;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = LZColorFromRGB(245, 246, 248);
    [self.view addSubview:table];
    self.myTableView = table;
    
    if (_isHasTabBarController) {
        table.frame = CGRectMake(0, CGRectGetMaxY(self.navigationView.frame ), LZSCREEN_WIDTH, LZSCREEN_HEIGHT - CGRectGetMaxY(self.navigationView.frame ) - LZTabBarHeight-TABBARHEIGHT);
    } else {
        table.frame = CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), LZSCREEN_WIDTH, LZSCREEN_HEIGHT - CGRectGetMaxY(self.navigationView.frame) - LZTabBarHeight);
    }
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCartReusableCell"];
    if (cell == nil) {
        cell = [[LZCartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LZCartReusableCell"];
    }
    
    LZCartModel *model = self.dataArray[indexPath.row];
    
    __block typeof(cell)wsCell = cell;
     weakSelf(self)
    [cell numberAddWithBlock:^(NSInteger number) {
        wsCell.lzNumber = number;
        model.count = number;
        
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        if ([weakself.selectedArray containsObject:model]) {
            [weakself.selectedArray removeObject:model];
            [weakself.selectedArray addObject:model];
            [weakself countPrice];
        }
    }];
    
    [cell numberCutWithBlock:^(NSInteger number) {
        
        wsCell.lzNumber = number;
        model.count = number;
        
        [weakself.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        
        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([weakself.selectedArray containsObject:model]) {
            [weakself.selectedArray removeObject:model];
            [weakself.selectedArray addObject:model];
            [weakself countPrice];
        }
    }];
   
    [cell cellSelectedWithBlock:^(BOOL select) {
        
        model.select = select;
        if (select) {
            [weakself.selectedArray addObject:model];
        } else {
            [weakself.selectedArray removeObject:model];
        }
        
        if (weakself.selectedArray.count == weakself.dataArray.count) {
            weakself.allSellectedButton.selected = YES;
        } else {
            weakself.allSellectedButton.selected = NO;
        }
        
        [self countPrice];
    }];
    
    [cell reloadDataWithModel:model];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            LZCartModel *model = [self.dataArray objectAtIndex:indexPath.row];
            

            NSString *url = [NSString stringWithFormat:@"/api/pub/cart/delete/%@",model.ID];
            [NetHttpTool GET:url parametsBody:nil Succeed:^(NSDictionary * _Nonnull returnData) {
//                [MBProgressHUD showSuccess:@"删除成功"];
                [self.dataArray removeObjectAtIndex:indexPath.row];
                //    删除
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                if (self.dataArray.count == 0) {
                    [self changeView];
                }
            } Failure:^(NSError * _Nonnull error) {
                [MBProgressHUD showError:NSLocalizedString(@"netError", nil)];
            }];
            
            //判断删除的商品是否已选择
            if ([self.selectedArray containsObject:model]) {
                //从已选中删除,重新计算价格
                [self.selectedArray removeObject:model];
                [self countPrice];
            }
            
            if (self.selectedArray.count == self.dataArray.count && self.dataArray.count != 0) {
                self.allSellectedButton.selected = YES;
            } else {
                self.allSellectedButton.selected = NO;
            }
            
            
            
            //如果删除的时候数据紊乱,可延迟0.5s刷新一下
            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }

}
- (void)reloadTable {
    [self.myTableView reloadData];
}
#pragma mark -- 页面按钮点击事件
#pragma mark --- 返回按钮点击事件
- (void)backButtonClick:(UIButton*)button {
    if (_isHasNavitationController == NO) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark --- 全选按钮点击事件
- (void)selectAllBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    
    //点击全选时,把之前已选择的全部删除
    for (LZCartModel *model in self.selectedArray) {
        model.select = NO;
    }
    
    [self.selectedArray removeAllObjects];
    
    if (button.selected) {
        
        for (LZCartModel *model in self.dataArray) {
            model.select = YES;
            [self.selectedArray addObject:model];
        }
    }
    
    [self.myTableView reloadData];
    [self countPrice];
}
#pragma mark --- 确认选择,Submit Order按钮点击事件
- (void)goToPayButtonClick:(UIButton*)button {
   
    
    if (self.selectedArray.count > 0) {

        NSString *address = [[NSUserDefaults standardUserDefaults]valueForKey:@"address"];
        
        if (address.length <= 0) {
            
            [self showAlert];
            
        }else{
            for (LZCartModel *model in self.selectedArray) {
                NSLog(@"选择的商品>>%@>>>%ld",model,(long)model.count);
                

                [self goPayUrl:@"1230"];
            }

        }
        
    } else {
        
        [MBProgressHUD showMessage:@"No product data yet"];
    }
    
}

- (void)goPayUrl:(NSString *)price{
    [MBProgressHUD showMessage:@"Sucess"];
    [self udpdte];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlert{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"No address info" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        KWSAddressViewController *vc = [KWSAddressViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:ok];
    [alertVc addAction:cancle];
    [self.navigationController presentViewController:alertVc animated:YES completion:nil];
}
- (void)udpdte {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *upsw = [Userdefaults valueForKey:@"upsw"];
    NSString *acc = [Userdefaults valueForKey:@"acc"];
    
    [dic setValue:upsw forKey:@"upsw"];
    [dic setValue:acc forKey:@"acc"];
    [dic setValue:ShopKey forKey:@"shopKey"];
    [MBProgressHUD showMessage:@"Successful purchase, this product is Cash on delivery"];
    [NetHttpTool Post:UserLogin bodyParamets:dic Succeed:^(NSDictionary * _Nonnull returnData) {
        
        NSDictionary *data= returnData[@"data"];
        NSDictionary *member = data[@"member"];
        
        [Userdefaults setObject:member[@"id"] forKey:@"id"];
        
        
        KWSOrderViewController *vc = [KWSOrderViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } Failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
