//
//  KWSSearchViewController.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "KWSSearchViewController.h"
#import "KWSSearchChildController.h"
#import "KWSGoodsListViewController.h"
#import "KWSBtnItemModel.h"
#import "KWSGoodsModel.h"

@interface KWSSearchViewController ()
<UISearchBarDelegate,ZJScrollPageViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *titles;
@property(nonatomic,strong) NSMutableArray *itemModel;
@property (nonatomic, strong) ZJScrollPageView *scrollPageView ;
@end

@implementation KWSSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SW, 40)];
    UIImageView *barImageView = [[[self.searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = DYStyleColor.CGColor;
    barImageView.layer.borderWidth=0.01;
    self.searchBar.layer.cornerRadius = 20;
    self.searchBar.layer.masksToBounds = YES;
    
    _titles = [NSMutableArray new];
    self.searchBar.delegate = self;
    
    self.searchBar.placeholder =@"输入要搜索的商品名";
    UITextField *tf = [self.searchBar valueForKey:@"searchField"];
    tf.backgroundColor = DYWhite;
    self.searchBar.barTintColor = DYWhite;
    [self.navigationView addTitleView:self.searchBar];
    [self getData];
}

- (void)zjcontentView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.scrollLineColor = DYStyleColor;
    //显示遮盖
    style.showCover = NO;
    style.segmentViewBounces = NO;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    // 显示附加的按钮
    style.showExtraButton = NO;
    style.selectedTitleColor = DYStyleColor;
    style.titleFont = DYFont(15);
//    self.titles = @[
//                    @"畅销植物",
//                    @"热门推荐",
//                    @"热带食虫",
//                    @"掌柜推荐",
//                    @"小狸藻",
//                    @"捕虫堇",
//                    @"茅膏菜",
//                    @"高手进阶"
//                    ];
    CGFloat y = CGRectGetMaxY(self.navigationView.frame);
    // 初始化
    CGRect scrollPageViewFrame = CGRectMake(0, y, self.view.bounds.size.width, SH - y);
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:_titles parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    [self.view addSubview:self.scrollPageView];
   
    
}

- (NSInteger)numberOfChildViewControllers {

    return self.titles.count;// 传入页面的总数, 推荐使用titles.count
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {

    UIViewController *childVc = reuseViewController;
    // 这里一定要判断传过来的是否是nil, 如果为nil直接使用并返回
    // 如果不为nil 就创建
    if (childVc == nil) {
                   
        KWSSearchChildController *vc = [KWSSearchChildController new];
        vc.index = index;
        childVc= vc;


    }
    return childVc;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (searchBar.text.length <= 0) {
        [MBProgressHUD showMessage:@"搜索关键词为空"];
        return;
    }
    NSMutableDictionary *catrDic = [NSMutableDictionary dictionary];
    [catrDic setValue:@"true" forKey:@"noPage"];
    [catrDic setValue:ShopKey forKey:@"shopKey"];
    [catrDic setValue:@"10" forKey:@"pageSize"];
    [catrDic setValue:@"0" forKey:@"page"];
    [catrDic setValue:searchBar.text forKey:@"name"];
    
    [NetHttpTool Post:@"/api/pub/goods/search" paramets:catrDic Succeed:^(id  _Nonnull returnData) {
        
        if (returnData[@"status"] ) {
            NSDictionary *data = returnData[@"data"];
            NSArray *goods = data[@"goods"];
            if (goods.count>0) {
                
                
                NSArray *dataArr = [KWSGoodsModel mj_objectArrayWithKeyValuesArray:goods];
                KWSGoodsListViewController *vc = [KWSGoodsListViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.dataArr = dataArr;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [MBProgressHUD showMessage:@"暂无数据"];
            }
        }
        
    } Failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络错误"];
    }];
}

- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    [dic setObject:@"true" forKey:@"noPage"];
    [dic setObject:@(0) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pageSize"];
    [dic setObject:ShopKey forKey:@"shopKey"];
    weakSelf(self)
    NSMutableDictionary *catrDic = [NSMutableDictionary dictionary];
    //    [catrDic setValue:@"66" forKey:@"id"];
    [catrDic setValue:ShopKey forKey:@"shopKey"];
    [NetHttpTool Post:CategoaryList paramets:catrDic Succeed:^(id  _Nonnull returnData) {
        
        if (returnData[@"status"] ) {
            NSDictionary *data = returnData[@"data"];
            NSArray *shopCircles = data[@"types"];
            if (shopCircles.count>0) {
                weakself.itemModel =  [KWSBtnItemModel mj_objectArrayWithKeyValuesArray:shopCircles];
                for (int i=0; i<=shopCircles.count-1; i++) {
                    KWSBtnItemModel *model = [KWSBtnItemModel mj_objectWithKeyValues:[shopCircles objectAtIndex:i]];
                    [self.titles addObject:model.name];                    
                }
                [self zjcontentView];
            }
        }
       
        
    } Failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误，请检查网路"];
    }];
}
@end
