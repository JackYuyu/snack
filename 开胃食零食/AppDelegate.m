//
//  AppDelegate.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//
#import "AppDelegate.h"
#import "TabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setInit];
    [self login];
    return YES;
}

- (void)setInit {
    
    
    EasyNavigationOptions *op = [EasyNavigationOptions shareInstance];
    op.navigationBackButtonImage = [UIImage imageNamed:@"youjiantou"];
    op.navBackGroundColor = DYStyleColor;
    op.titleColor = [UIColor whiteColor];
    TabBarViewController *vc = [TabBarViewController new];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

- (void)login {
    
    NSNumber *ID = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    NSString *acc = [[NSUserDefaults standardUserDefaults] valueForKey:@"acc"];
    NSString *upsw = [[NSUserDefaults standardUserDefaults] valueForKey:@"upsw"];
    
    if (ID.integerValue !=0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:acc forKey:@"acc"];
        [dic setValue:upsw forKey:@"upsw"];
        [dic setValue:ShopKey forKey:@"shopKey"];
        
        [NetHttpTool Post:UserLogin bodyParamets:dic Succeed:^(NSDictionary * _Nonnull returnData) {
            NSDictionary *data= returnData[@"data"];
            NSDictionary *member = data[@"member"];
            if (member[@"id"]) {
                [[NSUserDefaults standardUserDefaults]setObject:member[@"id"] forKey:@"id"];
            }
            
            
            
        } Failure:^(NSError * _Nonnull error) {
            
        }];
    }
}



@end
