//
//  KWSHomeViewController.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSHomeViewController.h"
#import "KWSHeadReusableView.h"
#import "KWSDDItemCell.h"
#import "KWSDDImageCell.h"
#import "KWSDDSingleImageCell.h"
#import "KWSDDCycleCell.h"
#import "KWSDDBtnItemCell.h"

#import "KWSGoodsDetailViewController.h"
#import "KWSGoodsListViewController.h"
#import "KWSBtnItemModel.h"
#import "KWSGoodsModel.h"
@interface KWSHomeViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
//
@property(nonatomic,strong) NSMutableArray *dataArr;
//
@property(nonatomic,strong) NSMutableArray *cricleArr;
//
@property(nonatomic,strong) NSMutableArray *itemModel;
@end

@implementation KWSHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self http];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr   = [NSMutableArray array];
    self.cricleArr = [NSMutableArray array];
    self.itemModel = [NSMutableArray array];
  
    self.navigationView.lineView.hidden = YES;
   
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = DYWhite;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];

    [self registCell];
    
    
    if (@available (iOS 11,*)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
   
 
   
}


- (void)registCell {
    
    
    [self.collectionView registerClass:[KWSDDCycleCell class] forCellWithReuseIdentifier:@"KWSDDCycleCell"];
    [self.collectionView registerClass:[KWSDDBtnItemCell class] forCellWithReuseIdentifier:@"KWSDDBtnItemCell"];
    [self.collectionView registerClass:[KWSDDImageCell class] forCellWithReuseIdentifier:@"KWSDDImageCell"];
   [self.collectionView registerClass:[KWSDDItemCell class] forCellWithReuseIdentifier:@"KWSDDItemCell"];
    [self.collectionView registerClass:[KWSDDSingleImageCell class] forCellWithReuseIdentifier:@"KWSDDSingleImageCell"];

    [self.collectionView registerClass:[KWSHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KWSHeadReusableView"];
    
     
   
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            if (self.itemModel.count >7) {
                return 8;
            }
            return 0;
            break;
        case 2:
            
            return 1;
            break;
//        case 3:
//
//            if (self.itemModel.count >1) {
//
//                return  3;
//            }else
//            {
//                return 0;
//            }
//            break;
        case 3:
        {
            if (self.itemModel.count >1) {
                
                KWSBtnItemModel *model = self.itemModel[1];
                
                return model.goods.count;
            }else
            {
                return 0;
            }
        }
            break;
        case 4:
        {
            if (self.itemModel.count >1) {
                
                
                KWSBtnItemModel *model = self.itemModel[2];
                
                return model.goods.count;
            }else
            {
                return 0;
            }
        }
            break;
        
        default:
            return 0;
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return CGSizeMake(SW, 250);
        }
            break;
        case 1:
        {
            return CGSizeMake((SW-23)/4, (SW-23)/4+20);
        }
        case 2:
        {
            return CGSizeMake(SW, 180);
        }
            break;
//        case 3:
//        {
//            return CGSizeMake((SW-20), 200);
//        }
//            break;
        default:
        {
            
            return CGSizeMake((SW-25)/2, (SW-15)/2+100);
        }
            break;
    }
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 0;
            break;
            
        case 1:
            
            return 1;
        case 2:
            
            return 0;
        
        default:
            return 5;
            break;
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 0;
            break;
            
        case 1:
            
            return 1;
        case 2:
            
            return 1;
//        case 3:
//
//            return 1;
            
        default:
            return 5;
            break;
    }
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section > 0) {
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }else {
        return UIEdgeInsetsZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    if (section >1) {
        return CGSizeMake(SW, 50);
    }

    return CGSizeZero;
}




- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        KWSHeadReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KWSHeadReusableView" forIndexPath:indexPath];
        view.nameLab.text = @"大众热卖";
        return view;
    }
    else if (indexPath.section == 3) {
        KWSHeadReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KWSHeadReusableView" forIndexPath:indexPath];
        view.nameLab.text = @"女性零食";
        return view;
    }
    else if (indexPath.section == 3) {
        KWSHeadReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KWSHeadReusableView" forIndexPath:indexPath];
        view.nameLab.text = @"选您喜欢";
        return view;
    }else if (indexPath.section == 4) {
        KWSHeadReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KWSHeadReusableView" forIndexPath:indexPath];
        view.nameLab.text = @"好吃零食";
        return view;
    }else{
        return nil;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            
            KWSDDCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KWSDDCycleCell" forIndexPath:indexPath];
            cell.cycleView.imageURLStringsGroup = self.cricleArr;
            cell.cycleView1.imageURLStringsGroup = self.cricleArr;
            return cell;
        }
            break;
        case 1:{
            
            KWSDDBtnItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KWSDDBtnItemCell" forIndexPath:indexPath];
            KWSBtnItemModel *model = self.itemModel[indexPath.row];
            [cell.iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.icon]]];
            cell.nameLab.text = model.name;
            
            return cell;
        }
        case 2:{
            
            
            KWSDDSingleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KWSDDSingleImageCell" forIndexPath:indexPath];
            
            
            return cell;
            
            
        }
        case 3:{
            
            KWSDDItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KWSDDItemCell" forIndexPath:indexPath];
            KWSBtnItemModel *model = self.itemModel[1];
            
            KWSGoodsModel *goodModel = model.goods[indexPath.row];
            [cell.iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",goodModel.smallPic]]];
            cell.nameLab.text = goodModel.name;
            
            cell.merPriceLab.text = [NSString stringWithFormat:@"%.2f",goodModel.memberPrice.doubleValue];
            return cell;
                
                
                
            
            
        }
        case 4:{
            
            KWSDDItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KWSDDItemCell" forIndexPath:indexPath];
            KWSBtnItemModel *model = self.itemModel[2];
            
            KWSGoodsModel *goodModel = model.goods[indexPath.row];
            [cell.iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",goodModel.smallPic]]];
            cell.nameLab.text = goodModel.name;
            
            cell.merPriceLab.text = [NSString stringWithFormat:@"%.2f",goodModel.memberPrice.doubleValue];
            return cell;
            
        }
        
        default:
            return nil;
            break;
    }
    
        
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==1) {
        KWSBtnItemModel *model = self.itemModel[indexPath.row];
        NSArray *dataArr = model.goods;
        KWSGoodsListViewController *vc = [KWSGoodsListViewController new];
        vc.dataArr = dataArr;
        vc.titles = model.name;
        
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2) {
        KWSBtnItemModel *model = self.itemModel[0];
        NSArray *dataArr = model.goods;
        KWSGoodsDetailViewController *vc = [KWSGoodsDetailViewController new];
        vc.model = dataArr[indexPath.row];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
//    if (indexPath.section == 3) {
//        KWSBtnItemModel *model = self.itemModel[0];
//        NSArray *dataArr = model.goods;
//        KWSGoodsDetailViewController *vc = [KWSGoodsDetailViewController new];
//        vc.model = dataArr[indexPath.row];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    if (indexPath.section == 3) {
        KWSBtnItemModel *model = self.itemModel[1];
        NSArray *dataArr = model.goods;
        KWSGoodsDetailViewController *vc = [KWSGoodsDetailViewController new];
        vc.model = dataArr[indexPath.row];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section ==  4) {
        KWSBtnItemModel *model = self.itemModel[2];
        NSArray *dataArr = model.goods;
        KWSGoodsDetailViewController *vc = [KWSGoodsDetailViewController new];
        vc.model = dataArr[indexPath.row];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (void)http {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    [dic setObject:@"true" forKey:@"noPage"];
    [dic setObject:@(0) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pageSize"];
    [dic setObject:ShopKey forKey:@"shopKey"];
    weakSelf(self)
    [NetHttpTool Post:ShopCircle paramets:dic Succeed:^(id  _Nonnull returnData) {
        
        if (returnData[@"status"] ) {
            NSDictionary *data = returnData[@"data"];
            NSArray *shopCircles = data[@"shopCircles"];
            if (shopCircles.count>0) {
                NSMutableArray *imgs = [NSMutableArray array];
                for (NSDictionary *dic in shopCircles) {
                    NSString *cricleImgUrl = [NSString stringWithFormat:@"%@",dic[@"pic"]];
                    [imgs addObject:cricleImgUrl];
                }
                weakself.cricleArr = imgs;
                [weakself.collectionView reloadData];
            }
        }
        
    } Failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误，请检查网路"];
    }];
    NSMutableDictionary *catrDic = [NSMutableDictionary dictionary];
    //    [catrDic setValue:@"66" forKey:@"id"];
    [catrDic setValue:ShopKey forKey:@"shopKey"];
    [NetHttpTool Post:CategoaryList paramets:catrDic Succeed:^(id  _Nonnull returnData) {
        
        if (returnData[@"status"] ) {
            NSDictionary *data = returnData[@"data"];
            NSArray *shopCircles = data[@"types"];
            if (shopCircles.count>0) {
                weakself.itemModel =  [KWSBtnItemModel mj_objectArrayWithKeyValuesArray:shopCircles];

                [weakself.collectionView reloadData];
            }
        }
        
    } Failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误，请检查网路"];
    }];
    
}


@end

