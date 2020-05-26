//
//  KWSAddCartView.h
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWSAddCartView : UIView
@property (strong, nonatomic)  UIButton *okBtn;
@property (strong, nonatomic)  UIButton *closeBtn;
@property (strong, nonatomic)  UIImageView *iconV;
@property (strong, nonatomic)  UILabel *priceLab;
@property (strong, nonatomic)  UILabel *countLab;
@property (strong, nonatomic)  UILabel *nameLab;
@property (strong, nonatomic)  UILabel *numLab;
@property (strong, nonatomic)  UIStepper *stepper;
@end

NS_ASSUME_NONNULL_END
