//
//  KWSDDGoodsListCell.h
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWSDDGoodsListCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *goodLab;
@property (nonatomic, strong) UILabel *sendStyleLab;
@property (nonatomic, strong) UIImageView *cartIconV;
@end

NS_ASSUME_NONNULL_END
