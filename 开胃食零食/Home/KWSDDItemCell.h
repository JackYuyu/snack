//
//  KWSDDItemCell.h
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWSDDItemCell : UICollectionViewCell
@property (strong, nonatomic)  UIImageView *iconV;
@property (strong, nonatomic)  UILabel *nameLab;
@property (strong, nonatomic)  UILabel *merPriceLab;
@property (nonatomic, strong) UILabel *soldLab;
@end

NS_ASSUME_NONNULL_END
