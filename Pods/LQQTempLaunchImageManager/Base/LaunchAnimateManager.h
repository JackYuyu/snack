//
//  LaunchAnimateManager.h
//  qianjiangtechan
//
//  Created by puli on 2019/2/27.
//  Copyright © 2019 puli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LaunchAnimateManager : NSObject
+ (instancetype)manager;
- (void)getLaunchAnimateUrlDm;
- (void)setName:(NSString *)name;
- (void)setVC:(UIViewController *)VC;
- (void)removeVC;
- (void)setRootView;

@end

NS_ASSUME_NONNULL_END
