//
//  KWSGoodsDetailViewController.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSGoodsDetailViewController.h"
#import "KWSAddCartView.h"
#import "KWSGoodsInfoScrollHeadView.h"
#import "KWSGoodsInfoImageCell.h"
@interface KWSGoodsDetailViewController ()
<UITableViewDelegate,UITableViewDataSource>
//
@property(nonatomic,strong) UITableView *tableView;
//
@property(nonatomic,strong) NSMutableArray *imgsArr;
//
@property(nonatomic,strong) NSMutableArray *heightArr;
//
@property(nonatomic,strong) UIView *bottomView;
//
@property(nonatomic,strong) UIView *addCartView;
//
@property(nonatomic,strong) KWSAddCartView *showView;
@end

@implementation KWSGoodsDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.heightArr = [NSMutableArray array];
    
    self.navigationView.titleLabel.text = @"商品详情";
    [MBProgressHUD showMessage:@"loading"];
    [self setUI];
    [self showView];
}

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[KWSGoodsInfoScrollHeadView class] forHeaderFooterViewReuseIdentifier:@"KWSGoodsInfoScrollHeadView"];
    
    [self.tableView registerClass:[KWSGoodsInfoImageCell class] forCellReuseIdentifier:@"KWSGoodsInfoImageCell"];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPONE_X) {
            make.size.mas_equalTo(CGSizeMake(SW, 70));
            
        }else{
            
            make.size.mas_equalTo(CGSizeMake(SW, 50));
        }
        make.bottom.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imgsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KWSGoodsInfoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KWSGoodsInfoImageCell"];
    [cell.iconV sd_setImageWithURL:[NSURL URLWithString:self.imgsArr[indexPath.row]]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.heightArr.count>0) {
        CGFloat height = [self.heightArr[indexPath.row] doubleValue];
        
        return height;
    }
    return SW;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 430;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KWSGoodsInfoScrollHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"KWSGoodsInfoScrollHeadView"];
    view.model = self.model;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)setModel:(KWSGoodsModel *)model {
    _model = model;
    NSString *pic1 = [NSString stringWithFormat:@"%@%@",@"",model.pic1];
    NSString *pic2 = [NSString stringWithFormat:@"%@%@",@"",model.pic2];
    NSString *pic3 = [NSString stringWithFormat:@"%@%@",@"",model.pic3];
    NSString *pic4 = [NSString stringWithFormat:@"%@%@",@"",model.pic4];
    NSString *paramPic = [NSString stringWithFormat:@"%@%@",@"",model.smallPic];
    self.imgsArr = [NSMutableArray array];
    
    for (int i=0; i<model.pics.count; i++) {
                NSDictionary* t=[model.pics objectAtIndex:i];
        [self.imgsArr addObject:[t objectForKey:@"url"]];
    }
//    [self.imgsArr addObjectsFromArray:model.pic1];
//    [self.imgsArr addObject:pic1];
//    [self.imgsArr addObject:pic2];
//    [self.imgsArr addObject:pic3];
//    [self.imgsArr addObject:pic4];
    
    [self.imgsArr addObject:paramPic];
    
    [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:self.imgsArr progress:^(NSUInteger noOfFinishedUrls, NSUInteger noOfTotalUrls) {
        
    } completed:^(NSUInteger noOfFinishedUrls, NSUInteger noOfSkippedUrls) {
        for (NSString *url in self.imgsArr) {
            NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:url]];
            UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
            [self.heightArr addObject:@(image.size.height)];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    }];
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 50)];
        _bottomView.backgroundColor = DYWhite;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [_bottomView addSubview:line];
        UIButton *collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        collectionBtn.tag = 1240;
        [collectionBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
//        [collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
        collectionBtn.titleLabel.font = DYFont(11);
        [collectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [collectionBtn titleLabBottomImageViewTopWith:5];
        [_bottomView addSubview:collectionBtn];
        [collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(8);
        }];
        [collectionBtn addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cartBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        cartBtn.tag = 1241;
        [cartBtn setImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
//        [cartBtn setTitle:@"购物车" forState:UIControlStateNormal];
        cartBtn.titleLabel.font = DYFont(11);
        [cartBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cartBtn titleLabBottomImageViewTopWith:5];
        [_bottomView addSubview:cartBtn];
        [cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(collectionBtn.mas_right).offset(20);
            make.top.mas_equalTo(5);
        }];
        [cartBtn addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *numLab = [[UILabel alloc]init];
        numLab.text = @"0";
        numLab.textColor = DYWhite;
        numLab.font = DYFont(11);
        numLab.backgroundColor = [UIColor redColor];
        numLab.textAlignment = NSTextAlignmentCenter;
        [_bottomView addSubview:numLab];
        [numLab sizeToFit];
        CGSize titleSize = [numLab.text sizeWithAttributes:@{NSFontAttributeName:DYFont(11)}];
        [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cartBtn.mas_top).offset(-2);
            make.left.mas_equalTo(cartBtn.mas_right).offset(-5);
            make.width.mas_equalTo(titleSize.width+5);
        }];
        numLab.layer.masksToBounds = YES;
        numLab.layer.cornerRadius = titleSize.height/2;
        numLab.tag = 1810;
        UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        [addBtn setTitleColor:DYWhite forState:UIControlStateNormal];
        [addBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
        addBtn.backgroundColor = [UIColor redColor];
        addBtn.layer.masksToBounds = YES;
        addBtn.layer.cornerRadius = 20;
        [_bottomView addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(6);
            make.right.mas_equalTo(-140);
            make.size.mas_equalTo(CGSizeMake(110, 38));
        }];
        UIButton *ljBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        [ljBtn setTitleColor:DYWhite forState:UIControlStateNormal];
        [ljBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        ljBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
        ljBtn.backgroundColor = [UIColor orangeColor];
        ljBtn.layer.masksToBounds = YES;
        ljBtn.layer.cornerRadius = 20;
        [_bottomView addSubview:ljBtn];
        [ljBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(6);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(110, 38));
        }];
        [ljBtn addTarget:self action:@selector(showAddCart:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn addTarget:self action:@selector(showAddCart:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _bottomView;
}



- (KWSAddCartView *)showView {
    if (!_showView) {
        _showView = [[KWSAddCartView alloc]initWithFrame:CGRectMake(0,SH, SW, 400)];
        [self.view addSubview:_showView];
        
        [_showView.okBtn addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
        [_showView.closeBtn addTarget:self action:@selector(hiddenCartView) forControlEvents:UIControlEventTouchUpInside];
        NSString *iconURL = [NSString stringWithFormat:@"%@%@",@"",_model.smallPic];
        [_showView.iconV sd_setImageWithURL:[NSURL URLWithString:iconURL]];
        _showView.nameLab.text = _model.name;
        _showView.priceLab.text = [NSString stringWithFormat:@"%.f",_model.memberPrice.doubleValue];
        _showView.countLab.text = [NSString stringWithFormat:@"库存:%.f",_model.inventory.doubleValue];
        _showView.numLab.text = [NSString stringWithFormat:@"%.f",_showView.stepper.value];
        _showView.stepper.maximumValue =_model.inventory.doubleValue;
    }
    return _showView;
}

- (void)bottomAction:(UIButton *)btn {
    if (btn.tag == 1240) {
        [btn setImage:[UIImage imageNamed:@"shoucng_sel"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else {
        self.tabBarController.selectedIndex = 2;
    }
}

- (void)showAddCart:(UIButton *)btn {
    //
    [UIView animateWithDuration:0.3 animations:^{
        self.showView.frame = CGRectMake(0, SH -400, SW, 400);
    }];
    
    
    
    
}
- (void)hiddenCartView{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.showView.frame = CGRectMake(0, SH, SW, 400);
    }];
}

- (void)okBtn {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.showView.frame = CGRectMake(0, SH, SW, 400);
    }];
    UILabel *numLab = [self.view viewWithTag: 1810];
    numLab.text = self.showView.numLab.text;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSNumber *ID = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    if (ID.integerValue <=0) {
        [MBProgressHUD showMessage:@"请先注册登录"];
        RegistLoginViewController *vc = [RegistLoginViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [dic setValue:_model.memberPrice forKey:@"price"];
    [dic setValue:_showView.numLab.text forKey:@"count"];
    [dic setValue:_model.ID forKey:@"goodsId"];
    [dic setValue:ID forKey:@"memberId"];
    [dic setValue:ShopKey forKey:@"shopKey"];
    
    [NetHttpTool Post:AddCart paramets:dic Succeed:^(NSDictionary * _Nonnull returnData) {
        [MBProgressHUD showSuccess:@"添加成功"];
        [self.tabBarController setSelectedIndex:2];
    } Failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"添加失败"];
    }];
}

@end

